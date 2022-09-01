local mod = Furtherance

function mod:UseFortitude(card, player, flag)
	for _ = 1, 2 do
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ROCK, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseFortitude, CARD_FORTITUDE)