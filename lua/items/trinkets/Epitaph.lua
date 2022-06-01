local mod = Furtherance
local game = Game()

local TombstoneVariant = Isaac.GetEntityVariantByName("Epitaph Tombstone")

local Tombstone = {}
Tombstone.__index = Tombstone


function Tombstone.new(owner, position)
    local room = game:GetRoom()
    local instance = Isaac.Spawn(EntityType.ENTITY_EFFECT, TombstoneVariant, 0, position, Vector.Zero, owner):ToEffect()

    local self = mod:GetData(instance)
    self.Instance = instance
    self.Owner = owner
    self.Health = 3

    setmetatable(self, Tombstone)
    return self
end

function Tombstone:Die()
    local rng = self.Owner:GetTrinketRNG(TrinketType.TRINKET_EPITAPH)
    local sprite = self.Instance:GetSprite()

    sprite:Play("Destroyed", true)

    local coinCount = rng:RandomInt(3) + 3
    for _ = 1, coinCount do
        local velocity = 10 * Vector(
            rng:RandomFloat() - 0.5,
            rng:RandomFloat() - 0.5
        )
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, self.Instance.Position, velocity, self.Instance)
    end

    local keyCount = rng:RandomInt(2) + 2
    for _ = 1, keyCount do
        local velocity = 10 * Vector(
            rng:RandomFloat() - 0.5,
            rng:RandomFloat() - 0.5
        )
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL, self.Instance.Position, velocity, self.Instance)
    end

    local ownerData = mod:GetData(self.Owner)
    if ownerData.EpitaphFirstPassiveItem then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ownerData.EpitaphFirstPassiveItem, Isaac.GetFreeNearPosition(self.Instance.Position, 40), Vector.Zero, self.Instance)
    end
    if ownerData.EpitaphLastPassiveItem then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ownerData.EpitaphLastPassiveItem, Isaac.GetFreeNearPosition(self.Instance.Position, 40), Vector.Zero, self.Instance)
    end
end

function Tombstone:TakeDamage()
    self.Health = math.max(self.Health - 1, -1)
    if self.Health == 0 then
        self:Die()
    end
end

local function evalEpitaph(level)
    local room = game:GetRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        if level:GetStage() == data.EpitaphStage then
            if data.EpitaphTombstonePosition == nil then
                data.EpitaphTombstonePosition = room:FindFreeTilePosition(Isaac.GetRandomPosition(), 0)
            end
            Tombstone.new(player, data.EpitaphTombstonePosition)
        end
    end
end

function mod:EpitaphInit(player)
    local data = mod:GetData(player)
    data.OldCollectibleCount = player:GetCollectibleCount()
    data.OldCollectibles = {}
end

function mod:PickupItem(player)
    local data = mod:GetData(player)
    if data.OldCollectibles == nil then
        data.OldCollectibles = {}
    end

    if data.NewEpitaphFirstPassiveItem == nil then
        local oldItem
        for i = 1, Isaac.GetItemConfig():GetCollectibles().Size do
            local itemConfig = Isaac.GetItemConfig():GetCollectible(i)
            if itemConfig and itemConfig.Type == ItemType.ITEM_PASSIVE then
                local oldNum = data.OldCollectibles[i] or 0
                local num = player:GetCollectibleNum(i, false)
                if num > oldNum then
                    oldItem = i
                    break
                end
            end
        end

        if oldItem then
            data.NewEpitaphFirstPassiveItem = oldItem
        end
    end

    if data.OldCollectibleCount == player:GetCollectibleCount() then return end
    data.OldCollectibleCount = player:GetCollectibleCount()

    local newItem
    for i = 1, Isaac.GetItemConfig():GetCollectibles().Size do
        local itemConfig = Isaac.GetItemConfig():GetCollectible(i)
        if itemConfig and itemConfig.Type == ItemType.ITEM_PASSIVE then
            local oldNum = data.OldCollectibles[i] or 0
            local num = player:GetCollectibleNum(i, false)
            if num > oldNum then
                newItem = i
            end
            data.OldCollectibles[i] = num
        end
    end

    if newItem then
        data.NewEpitaphLastPassiveItem = newItem
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.PickupItem)

local function setTombstoneRoom(player, roomsList)
    local rng = player:GetTrinketRNG(TrinketType.TRINKET_EPITAPH)
    local data = mod:GetData(player)

    local NormalRooms = {}
    for i = 0, #roomsList - 1 do
        local roomDesc = roomsList:Get(i)
        if roomDesc.Data.Type == RoomType.ROOM_DEFAULT then
            table.insert(NormalRooms, roomDesc)
        end
    end

    if #NormalRooms > 0 then
        local choice = rng:RandomInt(#NormalRooms) + 1
        data.EpitaphRoom = NormalRooms[choice].GridIndex
        print(data.EpitaphRoom)
    end
end

function mod:EpitaphLevel()
    local level = game:GetLevel()
    local roomsList = level:GetRooms()
    for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
        setTombstoneRoom(player, roomsList)
    end
end
mod:AddCustomCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.EpitaphLevel)

function mod:EpitaphRoom()
    local level = game:GetLevel()
    for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
        local data = mod:GetData(player)
        if level:GetCurrentRoomIndex() == data.EpitaphRoom then
            evalEpitaph(level)
        end
    end
end
mod:AddCustomCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.EpitaphRoom)

function mod:EpitaphDied(entity)
    local player = entity:ToPlayer()
    if player then
        local data = mod:GetData(player)
        if player:HasTrinket(TrinketType.TRINKET_EPITAPH) then
            local level = game:GetLevel()
            data.EpitaphStage = level:GetStage()
        else
            data.EpitaphStage = nil
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.EpitaphDied, EntityType.ENTITY_PLAYER)

function mod:DetectExplosion(bomb)
    local sprite = bomb:GetSprite()
    if not sprite:IsPlaying("Explode") then return end

    for _, tombstone in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, TombstoneVariant)) do
        tombstone = tombstone:ToEffect()
        local tombSpr = tombstone:GetSprite()
        local distance = bomb.Position:Distance(tombstone.Position)
        if distance <= 100 then
            mod:GetData(tombstone):TakeDamage()
            if mod:GetData(tombstone).Health == 2 then
                tombSpr:Play("Damaged1", true)
            end
            if mod:GetData(tombstone).Health == 1 then
                tombSpr:Play("Damaged2", true)
            end
        end
    end

end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, mod.DetectExplosion)

--[[mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
        local f = Font()
        local bruh
        if data.EpitaphStage ~= -1 then
            bruh = "Yes"
        else
            bruh = "No"
        end
        f:Load("font/pftempestasevencondensed.fnt")
        f:DrawString("Stage you died on: ", 75, 250, KColor(1, 1, 1, 1), 0, true)
        f:DrawString(data.EpitaphStage, 146+25, 250, KColor(1, 1, 1, 1), 0, true)
        f:DrawString("Died with Epitaph? ", 75, 240, KColor(1, 1, 1, 1), 0, true)
        f:DrawString(bruh, 148+25, 240, KColor(1, 1, 1, 1), 0, true)
	end
end)
]]