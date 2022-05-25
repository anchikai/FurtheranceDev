local mod = Furtherance

function mod:Minus1Shots(tear)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1) then
		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1)
		if rng:RandomFloat() <= 0.0314 then
			for i = 1, 3 do
				player:FireTechLaser(tear.Position, LaserOffset.LASER_TECH1_OFFSET, Vector(math.random(-1, 1), math.random(-1, 1)), true, false, player, 1)
			end
			tear:Die()
		end
		tear.Color = Color(0.75, 0, 0, 1, 0.25, 0, 0)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.Minus1Shots)
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, mod.Minus1Shots)
