local mod = Furtherance

function mod:UseE(_, _, player)
	Isaac.Spawn(EntityType.ENTITY_BOMBDROP, BombVariant.BOMB_GIGA, 0, player.Position, Vector.Zero, nil)
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseE, CollectibleType.COLLECTIBLE_E_KEY)