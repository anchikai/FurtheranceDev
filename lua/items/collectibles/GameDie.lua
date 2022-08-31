local mod = Furtherance

function mod:UseGameDie(_, _, player)
    local itemConfig = Isaac.GetItemConfig()
	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
        if entity.SubType ~= 0 then
            local OldItemQuality = itemConfig:GetCollectible(entity.SubType).Quality
            for i = 1, 2 do
                local NewItems = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(entity.Position, 40), Vector.Zero, player):ToPickup()         
                while (itemConfig:GetCollectible(NewItems.SubType).Quality >= OldItemQuality) do
                    if itemConfig:GetCollectible(NewItems.SubType).Quality < 1 then
                        NewItems:Remove()
                    else
                        print("Quality " .. itemConfig:GetCollectible(NewItems.SubType).Quality .. ", rerolling!")
                        NewItems:Morph(entity.Type, entity.Variant, 0, false, false, false)
                    end
                end
                NewItems.Price = entity:ToPickup().Price
                NewItems.OptionsPickupIndex = 123
            end
            entity:Remove()
        end
    end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseGameDie, CollectibleType.COLLECTIBLE_GAME_DIE)