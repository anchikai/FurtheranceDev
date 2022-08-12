local mod = Furtherance

function mod:UseFaith(card, player, flag)
	mod:PlaySND(CARD_FAITH_SFX)
	local confess = Isaac.Spawn(EntityType.ENTITY_SLOT, 17, 0, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
	local smoke = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 3, confess.Position, Vector.Zero, nil):GetSprite()
	SFXManager():Stop(SoundEffect.SOUND_FART)
	SFXManager():Play(SoundEffect.SOUND_SUMMONSOUND)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseFaith, CARD_FAITH)