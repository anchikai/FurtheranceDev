local mod = Furtherance

function mod:UseBookOfSwiftness(_, _, player)
	GiantBookAPI.playGiantBook("Appear", "swiftness.png", Color(1, 1, 1, 1, 0, 0, 0), Color(1, 1, 1, 1, 0, 0, 0), Color(1, 1, 1, 1, 0, 0, 0), SoundEffect.SOUND_BOOK_PAGE_TURN_12, false)
	player:UseCard(Card.CARD_ERA_WALK, 263)
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBookOfSwiftness, CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS)