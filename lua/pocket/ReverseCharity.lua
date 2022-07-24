local mod = Furtherance

function mod:UseReverseCharity(card, player, flag)
	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
        local clone = Isaac.Spawn(entity.Type, entity.Variant, entity.SubType, Isaac.GetFreeNearPosition(entity.Position, 40), Vector.Zero, player):ToPickup()
        clone.Price = 15
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseReverseCharity, CARD_REVERSE_CHARITY)