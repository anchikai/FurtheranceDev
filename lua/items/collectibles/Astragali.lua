local mod = Furtherance

local RerollableChests = {
	[PickupVariant.PICKUP_CHEST] = true,
	[PickupVariant.PICKUP_BOMBCHEST] = true,
	[PickupVariant.PICKUP_SPIKEDCHEST] = true,
	[PickupVariant.PICKUP_ETERNALCHEST] = true,
	[PickupVariant.PICKUP_MIMICCHEST] = true,
	[PickupVariant.PICKUP_OLDCHEST] = true,
	[PickupVariant.PICKUP_WOODENCHEST] = true,
    [PickupVariant.PICKUP_MEGACHEST] = true,
    [PickupVariant.PICKUP_HAUNTEDCHEST] = true,
    [PickupVariant.PICKUP_LOCKEDCHEST] = true,
    [PickupVariant.PICKUP_REDCHEST] = true,
}

local RandomChests = {
	PickupVariant.PICKUP_CHEST,
	PickupVariant.PICKUP_BOMBCHEST,
	PickupVariant.PICKUP_SPIKEDCHEST,
	PickupVariant.PICKUP_ETERNALCHEST,
	PickupVariant.PICKUP_MIMICCHEST,
	PickupVariant.PICKUP_OLDCHEST,
	PickupVariant.PICKUP_WOODENCHEST,
    PickupVariant.PICKUP_MEGACHEST,
    PickupVariant.PICKUP_HAUNTEDCHEST,
    PickupVariant.PICKUP_LOCKEDCHEST,
    PickupVariant.PICKUP_REDCHEST,
}

function mod:UseAstragali(_, _, player)
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ASTRAGALI)
	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
		local pickup = entity:ToPickup()
        local choice = rng:RandomInt(#RandomChests) + 1
		if RerollableChests[pickup.Variant] and pickup.SubType > ChestSubType.CHEST_OPENED then
			pickup:Morph(EntityType.ENTITY_PICKUP, RandomChests[choice], 0)
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseAstragali, CollectibleType.COLLECTIBLE_ASTRAGALI)