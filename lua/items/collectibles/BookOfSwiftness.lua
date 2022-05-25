local mod = Furtherance

function mod:UseBookOfSwiftness(_Type, RNG, player)
	local data = mod:GetData(player)
	mod:DoBigbook("gfx/ui/giantbook/Swiftness.png", SoundEffect.SOUND_BOOK_PAGE_TURN_12, nil, nil, true)
	player:UseCard(Card.CARD_ERA_WALK, 263)
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBookOfSwiftness, CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS)