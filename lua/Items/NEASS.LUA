local MOD = further

function MOD:USEPLUGNPLAY(BOI, RNG, PLAYER, SLOT, DATA)
	PLAYER:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(PLAYER.Position, 30), Vector(0, 0), PLAYER)
	PLAYER:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
	return true
end

MOD:AddCallback(ModCallbacks.MC_USE_ITEM, MOD.USEPLUGNPLAY, CollectibleType.COLLECTIBLE_NEASS)