local mod = further

function mod:UseBackSpace(boi, rng, player, slot, data)
	local level = Game():GetLevel()
	
	SFXManager():Play(SoundEffect.SOUND_GOLDENKEY)
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_BACKSPACE_KEY, "UseItem", "PlayerPickup")
	Game():GetRoom():GetDoor(level.EnterDoor):Open()
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBackSpace, CollectibleType.COLLECTIBLE_BACKSPACE_KEY)