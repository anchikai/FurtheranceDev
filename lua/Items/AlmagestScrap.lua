local mod = Furtherance
local game = Game()

local function someoneHasAlmagest()
    local result = false
    for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
        if player and player:HasTrinket(TrinketType.TRINKET_ALMAGEST_SCRAP, false) then
            result = true
            break
        end
    end

    return result
end

local function isTreasureRoom()
    local level = game:GetLevel()
    local room = level:GetCurrentRoom()
    return room:GetType() == RoomType.ROOM_TREASURE
end

function mod:ConvertToPlanetarium()
    if isTreasureRoom() and someoneHasAlmagest() then
        game:ShowHallucination(0, BackdropType.PLANETARIUM)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ConvertToPlanetarium)

function mod:PrePlanetariumPool(pool, decrease, seed)
    if isTreasureRoom() and someoneHasAlmagest() then
        return game:GetItemPool():GetCollectible(ItemPoolType.POOL_PLANETARIUM, false, seed, CollectibleType.COLLECTIBLE_NULL)
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.PrePlanetariumPool)

local qualityPriceMap = {
    [0] = 1,
    [1] = 1,
    [2] = 2,
    [3] = 2,
    [4] = 3,
}

---@param pickup EntityPickup
function mod:PlanetariumPickupSpawned(pickup)
    if isTreasureRoom() and someoneHasAlmagest() and pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
        local itemConfig = Isaac.GetItemConfig()
        local pickupQuality = itemConfig:GetCollectible(pickup.SubType).Quality

        -- get the price for pickup to data
        local data = mod:GetData(pickup)
        data.BrokenHeartsPrice = qualityPriceMap[pickupQuality]

        -- add a broken hearts price graphic (wip)
    end


end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.PostPlanetariumPool)

---@param pickup EntityPickup
---@param collider Entity
function mod:PrePickupCollision(pickup, collider)
    local player = collider:ToPlayer()
    if not player then return end

    if isTreasureRoom() and someoneHasAlmagest() and pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
        -- check whether the pickup's price
        local data = mod:GetData(pickup)
        local price = data.BrokenHeartsPrice
        if player:GetBrokenHearts() >= price then
            player:AddBrokenHearts(-price)
            return nil
        else
            return false
        end
    end

end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.PrePickupCollision)
