local mod = Furtherance

function mod:UseTrapCard(card, player, useflags)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, UseFlag.USE_NOANIM, -1)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseTrapCard, CARD_TRAP)