local mod = further

function mod:GetBrunch(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BRUNCH) then
		if cacheFlag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.16
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetBrunch)