local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:SpawnGoldenSack(entityType, variant, subType, _, _, _, seed)
    if entityType == EntityType.ENTITY_PICKUP and variant == PickupVariant.PICKUP_GRAB_BAG and subType == SackSubType.SACK_NORMAL then
        if rng:RandomFloat() <= 0.1 then
            return { entityType, variant, SackSubType.SACK_GOLDEN, seed }
        end
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.SpawnGoldenSack)

function mod:InitGoldenSack(pickup)
    if pickup.SubType == SackSubType.SACK_GOLDEN then
        local data = mod:GetData(pickup)
        data.Despawn = 0.1
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.InitGoldenSack, PickupVariant.PICKUP_GRAB_BAG)

function mod:GoldenSackRespawn(pickup, collider)
    if collider.Type ~= EntityType.ENTITY_PLAYER or pickup.SubType == SackSubType.SACK_GOLDEN then return end

    local data = mod:GetData(pickup)
    local room = game:GetRoom()
    if rng:RandomFloat() >= data.Despawn then
        local GoldenSack = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_GRAB_BAG, SackSubType.SACK_GOLDEN, room:GetRandomPosition(0), Vector.Zero, nil):ToPickup()
        local newData = mod:GetData(GoldenSack)
        newData.Despawn = math.min(data.Despawn * 2, 0.8)
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.GoldenSackRespawn, PickupVariant.PICKUP_GRAB_BAG)
