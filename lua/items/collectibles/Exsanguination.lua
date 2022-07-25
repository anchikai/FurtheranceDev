local mod = Furtherance

mod:SavePlayerData({
	ExsanguinationDamage = 0
})

function mod:SetExsanguinationData(player)
    player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
    player:EvaluateItems()
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.SetExsanguinationData)

function mod:PickupHeart(pickup, collider)
    if collider.Type == EntityType.ENTITY_PLAYER then
        local player = collider:ToPlayer()
        local data = mod:GetData(player)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_EXSANGUINATION) then
            if (pickup.SubType == HeartSubType.HEART_FULL or pickup.SubType == HeartSubType.HEART_HALF or pickup.SubType == HeartSubType.HEART_DOUBLEPACK)
            and player:CanPickRedHearts() then
                data.ExsanguinationDamage = data.ExsanguinationDamage + 0.1
                player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
                player:EvaluateItems()
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.PickupHeart, PickupVariant.PICKUP_HEART)

function mod:HeartDamage(player, flag)
    local data = mod:GetData(player)
    if data.ExsanguinationDamage == nil then
        data.ExsanguinationDamage = 0
    end
	if player:HasCollectible(CollectibleType.COLLECTIBLE_EXSANGUINATION) then
		player.Damage = player.Damage + data.ExsanguinationDamage
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.HeartDamage, CacheFlag.CACHE_DAMAGE)