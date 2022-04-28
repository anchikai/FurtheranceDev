local mod = Furtherance

function mod:GetBrunch(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BRUNCH) then
		if flag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.16
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetBrunch)