local mod = Furtherance
local game = Game()

function mod:UseDreidel(_, _, player)
    local data = mod:GetData(player)
    data.DreidelWasUsed = true
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseDreidel, CollectibleType.COLLECTIBLE_THE_DREIDEL)

function mod:DreidelQual(player)
    local data = mod:GetData(player)
    if data.DreidelWasUsed == true then
        data.DreidelWasUsed = false
        Item = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
        data.DreidelRerolling = true
    end
    local itemConfig = Isaac.GetItemConfig()
    if data.DreidelRerolling == true then
        if itemConfig:GetCollectible(Item.SubType).Quality < 4 then
            Item:ToPickup():Morph(Item.Type, Item.Variant, 0, false, true, false)
        else
            data.DreidelRerolling = false
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.DreidelQual)