local mod = Furtherance

function mod:UseD9(_, _, player)
	for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_TRINKET then
            entity:ToPickup():Morph(entity.Type, entity.Variant, 0, false, false, false)
        end
    end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseD9, CollectibleType.COLLECTIBLE_D9)