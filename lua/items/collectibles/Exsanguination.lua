local mod = Furtherance
local game = Game()

mod:SavePlayerData({
	ExsanguinationDamage = 0
})

local redHearts = {
    [HeartSubType.HEART_FULL] = true,
    [HeartSubType.HEART_HALF] = true,
    [HeartSubType.HEART_DOUBLEPACK] = true,
    [HeartSubType.HEART_SCARED] = true,
    [HeartSubType.HEART_BLENDED] = true,
}

local soulHearts = {
    [HeartSubType.HEART_SOUL] = true,
    [HeartSubType.HEART_HALF_SOUL] = true,
    [HeartSubType.HEART_BLENDED] = true,
}

local function getFirstPlayerWithItem()
    for p = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(p)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_EXSANGUINATION) then
            return player
        end
    end

    return nil
end

---@param player EntityPlayer
local function canPickUpHeart(player, heartSubType)
    return redHearts[heartSubType] and player:CanPickRedHearts()
        or soulHearts[heartSubType] and player:CanPickSoulHearts()
        or heartSubType == HeartSubType.HEART_BLACK and player:CanPickBlackHearts()
        or heartSubType == HeartSubType.HEART_BONE and player:CanPickBoneHearts()
        or heartSubType == HeartSubType.HEART_ROTTEN and player:CanPickRottenHearts()
        or heartSubType == HeartSubType.HEART_GOLDEN and player:CanPickGoldenHearts()
        or heartSubType == HeartSubType.HEART_ETERNAL
        or heartSubType == HeartSubType.HEART_ROCK and mod.CanPickHearts(player, "RockHeart")
        or heartSubType == HeartSubType.HEART_MOON and mod.CanPickHearts(player, "MoonHeart")
        or false -- make it false in case it's nil
end

function mod:SetExsanguinationData(player)
    player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
    player:EvaluateItems()
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.SetExsanguinationData)

---@param heart EntityPickup
---@param collider Entity
function mod:PickupHeart(heart, collider)

    local player = collider:ToPlayer()
    if player == nil then return end
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_EXSANGUINATION) then return end

    local data = mod:GetData(player)
    if canPickUpHeart(player, heart.SubType) then
        data.ExsanguinationDamage = data.ExsanguinationDamage + 0.1
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
        player:EvaluateItems()
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.PickupHeart, PickupVariant.PICKUP_HEART)

function mod:HeartDamage(player)
    local data = mod:GetData(player)
    if data.ExsanguinationDamage == nil then return end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_EXSANGUINATION) then
		player.Damage = player.Damage + data.ExsanguinationDamage
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HeartDamage, CacheFlag.CACHE_DAMAGE)

---@param heart EntityPickup
function mod:RemoveHalfOfHearts(heart)
    local player = getFirstPlayerWithItem()
    if player == nil then return end

    local rng = heart:GetDropRNG()
    if rng:RandomFloat() < 0.5 then
        heart:Remove()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.RemoveHalfOfHearts, PickupVariant.PICKUP_HEART)