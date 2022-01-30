local mod = further

function mod:UseCaps(boi, rng, player, slot, data)
	player:UseCard(Card.CARD_HUGE_GROWTH, 0)
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_CAPS_KEY, "UseItem", "PlayerPickup")
	SFXManager():Stop(SoundEffect.SOUND_HUGE_GROWTH)
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseCaps, CollectibleType.COLLECTIBLE_CAPS_KEY)