local mod = Furtherance

function mod:OwlFlags(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE) and RollOwl <= (player.Luck * 8 + 8) then
		player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_HOMING
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.OwlFlags, CacheFlag.CACHE_TEARFLAG)

function mod:OwlTear(tear)
	if tear.SpawnerType == EntityType.ENTITY_PLAYER and tear.Parent then
        local player = tear.Parent:ToPlayer()
		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_OWLS_EYE)
		RollOwl = rng:RandomInt(100)+1
		if player:HasCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE) and RollOwl <= (player.Luck * 8 + 8) then
			tear:ChangeVariant(TearVariant.CUPID_BLUE)
			tear.CollisionDamage = tear.CollisionDamage * 2

			local OwlColor = Color(1, 1, 1, 1, 0, 0, 0)
            OwlColor:SetColorize(3, 1, 0, 1)
            tear:SetColor(OwlColor, 0, 0, false, false)
		end
		player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
		player:EvaluateItems()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.OwlTear)