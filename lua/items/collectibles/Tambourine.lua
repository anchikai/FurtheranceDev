local mod = Furtherance
local game = Game()

local TambourineMedium = Isaac.GetSoundIdByName("TambourineMedium")
local WhirlpoolVariant = Isaac.GetEntityVariantByName("Miriam Whirlpool")

function mod:UseTambourine(_, _, player)
	-- create a puddle at the player's feet
	local whirlpool = Isaac.Spawn(EntityType.ENTITY_EFFECT, WhirlpoolVariant, 1, player.Position, Vector.Zero, player):ToEffect()
	whirlpool.LifeSpan = 60
	whirlpool.CollisionDamage = player.Damage * 0.33

	-- create a pull effect
	local rift = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RIFT, 0, player.Position, Vector(0,0), player):ToEffect()
	rift.SpriteScale = Vector.Zero
	mod:DelayFunction(rift.Die, 60, {rift}, true)

	SFXManager():Play(TambourineMedium)
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseTambourine, CollectibleType.COLLECTIBLE_TAMBOURINE)