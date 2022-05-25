local mod = Furtherance

function mod:UseCaps(boi, rng, player, slot, data)
	player:UseCard(Card.CARD_HUGE_GROWTH, 0)
	SFXManager():Stop(SoundEffect.SOUND_HUGE_GROWTH)
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseCaps, CollectibleType.COLLECTIBLE_CAPS_KEY)