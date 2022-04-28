local mod = Furtherance

function mod:GetPallas(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_PALLAS) then
		if flag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_HYDROBOUNCE | TearFlags.TEAR_POP
		end
		if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_FLAT_STONE)) then
			if flag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage * 1.16
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetPallas)

function mod:TearSize(tear)
    local player = tear.Parent:ToPlayer()
    if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PALLAS) and player:HasCollectible(CollectibleType.COLLECTIBLE_FLAT_STONE)) then -- Flat stone synergy
		tear.Scale = tear.Scale * 2
    elseif (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PALLAS)) then
		tear.Scale = tear.Scale * 1.2
	end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.TearSize, CollectibleType.COLLECTIBLE_PALLAS)