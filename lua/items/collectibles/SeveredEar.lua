local mod = Furtherance

function mod:GetSeveredEar(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_SEVERED_EAR) then
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 1.2
        end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay / (0.8 / player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SEVERED_EAR, false))
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + (48 * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SEVERED_EAR, false))
		end
		if flag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed - (0.6 * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SEVERED_EAR, false))
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetSeveredEar)