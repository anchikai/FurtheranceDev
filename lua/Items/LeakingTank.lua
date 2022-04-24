local mod = Furtherance
local rng = RNG()

function mod:Leaking(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_LEAKING_TANK) then
		if player:GetHearts() <= 2 then
			if rng:RandomInt(100) <= 5 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, player.Position, Vector(0,0), player)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.Leaking)