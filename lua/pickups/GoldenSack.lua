local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:MakeGolden(pickup)
    local float = rng:RandomFloat()
    if pickup.SubType == SackSubType.SACK_NORMAL and float <= 0.5 then
        pickup:Morph(pickup.Type, PickupVariant.PICKUP_GRAB_BAG, SackSubType.SACK_GOLDEN)
        local data = mod:GetData(pickup)
        data.Despawn = 0.1
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.MakeGolden, PickupVariant.PICKUP_GRAB_BAG)

function mod:SackTele(pickup, collider)
    if collider.Type == EntityType.ENTITY_PLAYER then
        local data = mod:GetData(pickup)
        local room = game:GetRoom()
        if pickup.SubType == SackSubType.SACK_GOLDEN then
            if rng:RandomFloat() >= data.Despawn then
                local GoldenSack = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_GRAB_BAG, SackSubType.SACK_GOLDEN, room:GetRandomPosition(0), Vector.Zero, nil):ToPickup()
                local newData = mod:GetData(GoldenSack)
                newData.Despawn = math.min(data.Despawn * 2, 0.8)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.SackTele, PickupVariant.PICKUP_GRAB_BAG)