local mod = Furtherance

function mod:UseReverseFaith(card, player, flag)
	for _ = 1, 2 do
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_MOON, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseReverseFaith, CARD_REVERSE_FAITH)