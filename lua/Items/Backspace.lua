local mod = further
local game = Game()

function mod:UseBackSpace(_, _, player)
	local level = game:GetLevel()
	
	SFXManager():Play(SoundEffect.SOUND_GOLDENKEY)
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_BACKSPACE_KEY, "UseItem", "PlayerPickup")
	game:GetRoom():GetDoor(level.EnterDoor):Open()
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBackSpace, CollectibleType.COLLECTIBLE_BACKSPACE_KEY)