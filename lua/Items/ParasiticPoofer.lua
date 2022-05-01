local mod = Furtherance
local game = Game()

function mod:Parasite(entity)
	local player = entity:ToPlayer()
	local poofRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PARASITIC_POOFER)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_PARASITIC_POOFER) then
		if poofRNG:RandomInt(5) == 0 then
			player:UseCard(Card.CARD_HEARTS_2, 257)
			player:AddBrokenHearts(1)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 5, player.Position, Vector.Zero, player)
			SFXManager():Play(SoundEffect.SOUND_DEATH_BURST_LARGE)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.Parasite, EntityType.ENTITY_PLAYER)