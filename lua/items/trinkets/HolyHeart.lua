local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:CollectHeart(pickup, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
        local player = collider:ToPlayer()
		if player:HasTrinket(TrinketType.TRINKET_HOLY_HEART, false) then
			if pickup.SubType == HeartSubType.HEART_ETERNAL then
				if rng:RandomInt(3) == 1 then
					player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
				end
			elseif pickup.SubType == HeartSubType.HEART_SOUL then
				if rng:RandomInt(20) == 1 then
					player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
				end
			elseif pickup.SubType == HeartSubType.HEART_BLENDED then
				if rng:RandomInt(20) == 1 then
					player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
				end
			elseif pickup.SubType == HeartSubType.HEART_HALF_SOUL then
				if rng:RandomInt(50) == 1 then
					player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.CollectHeart, PickupVariant.PICKUP_HEART)