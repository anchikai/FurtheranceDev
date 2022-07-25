local mod = Furtherance

local whitelistedPickupVariants = {
	[PickupVariant.PICKUP_TROPHY] = true,
	[PickupVariant.PICKUP_BED] = true,
	[PickupVariant.PICKUP_MOMSCHEST] = true,
	[PickupVariant.PICKUP_THROWABLEBOMB] = true,
}

function mod:UseReverseCharity(card, player, flag)
	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
        if not whitelistedPickupVariants[entity.Variant] then
            local clone = Isaac.Spawn(entity.Type, entity.Variant, entity.SubType, Isaac.GetFreeNearPosition(entity.Position, 40), Vector.Zero, player):ToPickup()
            clone.ShopItemId = -1
            clone.Price = 15
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseReverseCharity, CARD_REVERSE_CHARITY)