local mod = Furtherance

function mod:UseGameDie(_, _, player)
    local itemConfig = Isaac.GetItemConfig()
	for i, item in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
        if item.SubType ~= 0 then
            -- if the item pool runs out, items morph to breakfast by default.
            -- so we can't reroll items that are already breakfast, it'll just
            -- create more of them.
            local oldItemQuality = itemConfig:GetCollectible(item.SubType).Quality
            if item.SubType ~= CollectibleType.COLLECTIBLE_BREAKFAST and oldItemQuality > 0 then
                for _ = 1, 2 do
                    local newItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(item.Position, 40), Vector.Zero, player):ToPickup()

                    local maxItemQuality = math.max(0, oldItemQuality - 1)
                    while newItem.SubType ~= CollectibleType.COLLECTIBLE_BREAKFAST and itemConfig:GetCollectible(newItem.SubType).Quality > maxItemQuality do
                        newItem:Morph(item.Type, item.Variant, 0, false, false, false)
                    end

                    newItem.Price = item:ToPickup().Price
                    newItem.OptionsPickupIndex = 123 + i
                end
            end

            item:Remove()
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, item.Position, Vector.Zero, item)
        end
    end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseGameDie, CollectibleType.COLLECTIBLE_GAME_DIE)