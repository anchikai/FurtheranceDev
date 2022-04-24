local mod = Furtherance

function mod:GetOphiuchus(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_OPHIUCHUS) then
		if cacheFlag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_WIGGLE | TearFlags.TEAR_SPECTRAL
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.3
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + player.FireDelay
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetOphiuchus)