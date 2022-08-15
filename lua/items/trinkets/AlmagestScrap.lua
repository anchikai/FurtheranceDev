local mod = Furtherance
local game = Game()

local function someoneHasAlmagest()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player and player:HasTrinket(TrinketType.TRINKET_ALMAGEST_SCRAP, false) then
            return true
        end
    end

    return false
end

local function isTreasureRoom()
    local room = game:GetRoom()
    return room:GetType() == RoomType.ROOM_TREASURE
end

local convertedRooms = {}

function mod:ConvertToPlanetarium()
    if not isTreasureRoom() then return end

    local room = game:GetRoom()
    local level = game:GetLevel()
    local roomIndex = level:GetCurrentRoomIndex()

    if not convertedRooms[roomIndex] and not (room:IsFirstVisit() and someoneHasAlmagest()) then return end
    convertedRooms[roomIndex] = true

    game:ShowHallucination(0, BackdropType.PLANETARIUM)
    SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)

    local entities = Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, false, false)

    local itemConfig = Isaac.GetItemConfig()
    for _, entity in ipairs(entities) do
        local collectible = entity:ToPickup()
        local data = mod:GetData(collectible)
        local configItem = itemConfig:GetCollectible(collectible.SubType)
        collectible.Price = -10
        collectible.AutoUpdatePrice = false
        if configItem.Quality == 0 or configItem.Quality == 1 then
            data.BrokenHeartsPrice = 1
        elseif configItem.Quality == 2 or configItem.Quality == 3 then
            data.BrokenHeartsPrice = 2
        elseif configItem.Quality == 4 then
            data.BrokenHeartsPrice = 3
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ConvertToPlanetarium)

function mod:ResetConvertedRoomsOnNewLevel()
    convertedRooms = {}
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ResetConvertedRoomsOnNewLevel)

function mod:ResetConvertedRoomsOnRestart(isContinued)
    if not isContinued then
        convertedRooms = {}
    end
end
local pickupOffset = Vector(0, 20)

function mod:RenderBrokenHeartPrice(pickup)
    local data = mod:GetData(pickup)
    local room = game:GetRoom()
    if data.BrokenHeartsPrice then
        local sprite = Sprite()
        sprite:Load("gfx/ui/ui_broken_heart_prices.anm2", true)
        if data.BrokenHeartsPrice == 1 then
            sprite:SetFrame("One", 0)
        elseif data.BrokenHeartsPrice == 2 then
            sprite:SetFrame("Two", 0)
        elseif data.BrokenHeartsPrice == 3 then
            sprite:SetFrame("Three", 0)
        end
        sprite:Render(room:WorldToScreenPosition(pickup.Position) + pickupOffset, Vector.Zero, Vector.Zero)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, mod.RenderBrokenHeartPrice)

function mod:PlanetariumPool(pool, decrease, seed)
    local level = game:GetLevel()
    local roomIndex = level:GetCurrentRoomIndex()
    if convertedRooms[roomIndex] then
        if Rerolled ~= true then
            Rerolled = true
            return game:GetItemPool():GetCollectible(ItemPoolType.POOL_PLANETARIUM, false, seed, CollectibleType.COLLECTIBLE_NULL)
        end
        Rerolled = false
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.PlanetariumPool)

local qualityPriceMap = {
    [0] = 1,
    [1] = 1,
    [2] = 2,
    [3] = 2,
    [4] = 3,
}

--[[function mod:PlanetariumPickupSpawned(pickup)
    if isTreasureRoom() and someoneHasAlmagest() and pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
        local itemConfig = Isaac.GetItemConfig()
        local pickupQuality = itemConfig:GetCollectible(pickup.SubType).Quality

        -- get the price for pickup to data
        local data = mod:GetData(pickup)
        data.BrokenHeartsPrice = qualityPriceMap[pickupQuality]
        print(data.BrokenHeartsPrice)
        -- add a broken hearts price graphic (wip)
    end


end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.PostPlanetariumPool)]]

function mod:PrePickupCollision(pickup, collider)
    local player = collider:ToPlayer()
    if not player then return end

    if isTreasureRoom() and someoneHasAlmagest() and pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
        -- check whether the pickup's price
        local data = mod:GetData(pickup)
        local price = data.BrokenHeartsPrice
        if price == nil then
            return nil
        elseif player:GetBrokenHearts() >= price then
            player:AddBrokenHearts(-price)
            return nil
        else
            return false
        end
    end

end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.PrePickupCollision)