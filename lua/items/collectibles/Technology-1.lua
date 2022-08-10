local mod = Furtherance

---@param tear EntityTear
function mod:Minus1Shots(tear)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1) then
		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1)
		if rng:RandomFloat() <= 0.0314 then
			for i = 1, 3 do
				local direction = rng:RandomInt(8) * 45

				-- 2 is technology laser
				local laser = EntityLaser.ShootAngle(2, tear.Position, direction, 3, Vector.Zero, player)
				laser.TearFlags = player.TearFlags & ~TearFlags.TEAR_QUADSPLIT
				laser:SetOneHit(true)
			end
			tear:ClearTearFlags(TearFlags.TEAR_QUADSPLIT)
			tear:Die()
		end
		tear.Color = Color(0.75, 0, 0, 1, 0.25, 0, 0)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.Minus1Shots)
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, mod.Minus1Shots)
