local mod = Furtherance
local game = Game()

mod:ShelvePlayerData({
    EpitaphStage = mod.SaveNil,
    EpitaphFirstPassiveItem = mod.SaveNil,
    EpitaphLastPassiveItem = mod.SaveNil
})

mod:SavePlayerData({
    EpitaphRoom = mod.SaveNil,
    EpitaphTombstonePosition = mod:Serialize(Vector, mod.SaveNil),
    EpitaphTombstoneDestroyed = mod.SaveNil,
    OldCollectibles = function() return {} end
})

local TombstoneVariant = Isaac.GetEntityVariantByName("Epitaph Tombstone")

local Tombstone = include("lua/items/trinkets/Epitaph/Tombstone.lua")

local function pickTombstoneRoom(player, roomsList)
    local rng = player:GetTrinketRNG(TrinketType.TRINKET_EPITAPH)

    local NormalRooms = {}
    for i = 0, #roomsList - 1 do
        local roomDesc = roomsList:Get(i)
        if roomDesc.Data.Type == RoomType.ROOM_DEFAULT then
            table.insert(NormalRooms, roomDesc)
        end
    end

    if #NormalRooms > 0 then
        local choice = rng:RandomInt(#NormalRooms) + 1
        return NormalRooms[choice].GridIndex
    end
end

function mod:PickupItem(player)
    local data = mod:GetData(player)
    if data.OldCollectibles == nil then
        data.OldCollectibles = {}
    end

    if data.NewEpitaphFirstPassiveItem == nil then
        local oldItem
        local itemConfig = Isaac.GetItemConfig()
        for i = 1, Isaac.GetItemConfig():GetCollectibles().Size do
            local key = tostring(i) -- so data.OldCollectibles it can be saved
            local itemConfigItem = itemConfig:GetCollectible(i)
            if itemConfigItem and itemConfigItem.Type == ItemType.ITEM_PASSIVE then
                local oldItemCount = data.OldCollectibles[key] or 0
                local itemCount = player:GetCollectibleNum(i, false)
                if itemCount > oldItemCount then
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
        local key = tostring(i) -- so data.OldCollectibles it can be saved
        local itemConfig = Isaac.GetItemConfig():GetCollectible(i)
        if itemConfig and itemConfig.Type == ItemType.ITEM_PASSIVE then
            local oldItemCount = data.OldCollectibles[key] or 0
            local itemCount = player:GetCollectibleNum(i, false)
            if itemCount > oldItemCount then
                newItem = i
            end
            data.OldCollectibles[key] = itemCount
        end
    end

    if newItem then
        data.NewEpitaphLastPassiveItem = newItem
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.PickupItem)

function mod:EpitaphLevel()
    local level = game:GetLevel()
    local roomsList = level:GetRooms()
    for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
        local data = mod:GetData(player)
        if data.EpitaphRoom == nil then
            data.EpitaphRoom = pickTombstoneRoom(player, roomsList)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.EpitaphLevel)

function mod:EpitaphRoom()
    local level = game:GetLevel()
    local room = game:GetRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        if level:GetStage() == data.EpitaphStage and level:GetCurrentRoomDesc().GridIndex == data.EpitaphRoom then
            if data.EpitaphTombstonePosition == nil then
                data.EpitaphTombstonePosition = room:FindFreeTilePosition(Isaac.GetRandomPosition(), 0)
            end

            local tombstone = Tombstone.new(player, data.EpitaphTombstonePosition)
            if data.EpitaphTombstoneDestroyed then
                tombstone.Health = 0
                tombstone.Instance:GetSprite():Play("Destroyed", true)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.EpitaphRoom)

function mod:EpitaphDied(entity)
    local player = entity:ToPlayer()
    if player then
        local data = mod:GetData(player)
        if player:HasTrinket(TrinketType.TRINKET_EPITAPH) then
            local level = game:GetLevel()
            data.EpitaphStage = level:GetStage()
        else
            data.EpitaphStage = nil
            data.EpitaphFirstPassiveItem = nil
            data.EpitaphLastPassiveItem = nil
        end
        data.EpitaphRoom = nil
        data.EpitaphTombstonePosition = nil
        data.EpitaphTombstoneDestroyed = nil
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.EpitaphDied, EntityType.ENTITY_PLAYER)

function mod:DetectExplosion(bomb)
    local sprite = bomb:GetSprite()
    if not sprite:IsPlaying("Explode") then return end

    for _, tombstone in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, TombstoneVariant)) do
        tombstone = tombstone:ToEffect()
        local distance = bomb.Position:Distance(tombstone.Position)
        if distance <= 100 then
            mod:GetData(tombstone):TakeDamage()
        end
    end

end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, mod.DetectExplosion)

--[[mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
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