local mod = Furtherance

function mod:OwlFlags(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE) and rollOwl <= (player.Luck * 8 + 8) then
		player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_HOMING
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.OwlFlags, CacheFlag.CACHE_TEARFLAG)

local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

function mod:OwlTear(tear)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player and player:HasCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE) then
		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_OWLS_EYE)

		local chance = clamp(player.Luck, 0, 12) * 0.08 + 0.08
		if player:HasTrinket(TrinketType.TRINKET_TEARDROP_CHARM) then
			chance = 1 - (1 - chance) ^ 2
		end

		if rng:RandomFloat() <= chance then
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