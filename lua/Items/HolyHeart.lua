local mod = further
local rng = RNG()

function mod:CollectHeart(pickup, collider)
	for i = 0, Game():GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
		if player:HasTrinket(TrinketType.TRINKET_HOLY_HEART, false) then
			if collider.Type == EntityType.ENTITY_PLAYER then
				if pickup.SubType == HeartSubType.HEART_ETERNAL then
					if rng:RandomInt(3) == 1 then
						player:UseCard(Card.CARD_HOLY, 257)
					end
				elseif pickup.SubType == HeartSubType.HEART_SOUL then
					if rng:RandomInt(20) == 1 then
						player:UseCard(Card.CARD_HOLY, 257)
					end
				elseif pickup.SubType == HeartSubType.HEART_BLENDED then
					if rng:RandomInt(20) == 1 then
						player:UseCard(Card.CARD_HOLY, 257)
					end
				elseif pickup.SubType == HeartSubType.HEART_HALF_SOUL then
					if rng:RandomInt(50) == 1 then
						player:UseCard(Card.CARD_HOLY, 257)
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.CollectHeart)