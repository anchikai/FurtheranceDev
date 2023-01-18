local mod = Furtherance

---@param tear EntityTear
function mod:FirePATears(tear)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_PSEUDOBULBAR_AFFECT) then return end

	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PSEUDOBULBAR_AFFECT)
	local chance = 0.5
	if player:HasTrinket(TrinketType.TRINKET_TEARDROP_CHARM) then
		chance = 1 - (1 - chance) ^ 2
	end

	local choice = rng:RandomFloat()
	if choice < chance / 2 then
		tear:AddTearFlags(TearFlags.TEAR_CHARM)
		tear:SetColor(Color(1, 0, 1, 1, 0.196, 0, 0), 0, 1)
	elseif choice < chance then
		tear:AddTearFlags(TearFlags.TEAR_BAIT)
		tear:SetColor(Color(0.7, 0.14, 0.1, 1, 0.3, 0, 0), 0, 1)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FirePATears)

function mod:GetPseudobulbarAffect(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_PSEUDOBULBAR_AFFECT) then
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = mod:GetFireDelayFromTears(mod:GetTearsFromFireDelay(player.MaxFireDelay) + 1)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetPseudobulbarAffect)