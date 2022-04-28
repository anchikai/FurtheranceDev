local mod = Furtherance
local game = Game()

function mod:UseApocalypse(_, _, player)
    local data = player:GetData()
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_APOCALYPSE)
    if player:GetCollectibleCount() > 0 then
        repeat
            data.items = player:GetCollectibleCount()
        until data.items == 0
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Vector.Zero, Vector.Zero, nil)
            data.items = data.items - 1
        end
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseApocalypse, CollectibleType.COLLECTIBLE_APOCALYPSE)

function mod:ChargeApocalypse()

end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ChargeApocalypse)
