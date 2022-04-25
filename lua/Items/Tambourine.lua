local mod = Furtherance
local game = Game()
local TambourineMedium = Isaac.GetSoundIdByName("TambourineMedium")

function mod:UseTambourine(_, _, player)
	local data = mod:GetData(player)
	SFXManager():Play(TambourineMedium)
	local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 1, player.Position, Vector.Zero, player):ToEffect()
	puddle.CollisionDamage = player.Damage * 0.33
	puddle.Scale = 1.75
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseTambourine, CollectibleType.COLLECTIBLE_TAMBOURINE)