local mod = Furtherance

function mod:UseBookOfLeviticus(_, _, player)
    player:UseCard(Card.CARD_REVERSE_TOWER, 771)
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBookOfLeviticus, CollectibleType.COLLECTIBLE_BOOK_OF_LEVITICUS)