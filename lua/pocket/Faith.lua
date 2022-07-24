local mod = Furtherance

function mod:UseFaith(card, player, flag)
	Isaac.Spawn(EntityType.ENTITY_SLOT, 17, 0, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseFaith, CARD_FAITH)