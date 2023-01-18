local mod = Furtherance

---@param tear EntityTear
function mod:FireLLTears(tear)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player == nil or not player:HasTrinket(TrinketType.TRINKET_LEAHS_LOCK) then return end

	local rng = player:GetTrinketRNG(TrinketType.TRINKET_LEAHS_LOCK)
	local chance = 0.25 + math.min(player.Luck * 0.025, 0.25)
	if player:HasTrinket(TrinketType.TRINKET_TEARDROP_CHARM) then
		chance = 1 - (1 - chance) ^ 2
	end

	local choice = rng:RandomFloat()
	if choice < chance / 2 then
		tear:AddTearFlags(TearFlags.TEAR_CHARM)
		tear:SetColor(Color(1, 0, 1, 1, 0.196, 0, 0), 0, 1)
	elseif choice < chance then
		tear:AddTearFlags(TearFlags.TEAR_FEAR)
		tear:SetColor(Color(1, 1, 0.455, 1, 0.169, 0.145, 0), 0, 1)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireLLTears)