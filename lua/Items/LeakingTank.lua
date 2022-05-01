local mod = Furtherance

function mod:Leaking(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_LEAKING_TANK) then
		if player:GetHearts() <= 2 then
			local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LEAKING_TANK)
			if rng:RandomInt(20) == 1 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, player.Position, Vector.Zero, player)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.Leaking)