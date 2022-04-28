local MOD = Furtherance

function MOD:USEPLUGNPLAY(_, _, PLAYER)
	PLAYER:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(PLAYER.Position, 30), Vector.Zero, PLAYER)
	PLAYER:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
	return true
end

MOD:AddCallback(ModCallbacks.MC_USE_ITEM, MOD.USEPLUGNPLAY, CollectibleType.COLLECTIBLE_NEASS)