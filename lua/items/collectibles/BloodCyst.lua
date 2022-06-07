local mod = Furtherance
local game = Game()

local Cyst = Isaac.GetEntityVariantByName("Blood Cyst")

function mod:RespawnCyst()
    local room = game:GetRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if room:IsClear() == false and player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_CYST) then
            Isaac.Spawn(EntityType.ENTITY_FAMILIAR, Cyst, 0, Isaac.GetFreeNearPosition(room:GetRandomPosition(0), 40), Vector.Zero, player)
        elseif room:IsClear() then
            for _, entity in ipairs(Isaac.GetRoomEntities()) do
                if entity.Type == EntityType.ENTITY_FAMILIAR and entity.Variant == Cyst then
                    entity:Remove()
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RespawnCyst)

function mod:BloodCystBurst(bloodcyst)
    local player = bloodcyst.SpawnerEntity:ToPlayer()
    for _, entity in ipairs(Isaac.FindInRadius(bloodcyst.Position, 15, EntityPartition.TEAR)) do
        if entity.Type == EntityType.ENTITY_TEAR then
            bloodcyst:Die()
            entity:Die()
            for i = 1, 8 do
                if player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_CYST) and player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
                    local CystTears = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, bloodcyst.Position, Vector(8, 0):Rotated(i * 45), bloodcyst):ToTear()
                    CystTears.CollisionDamage = 7
                    CystTears.Scale = 1.1
                else
                    Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, bloodcyst.Position, Vector(8, 0):Rotated(i * 45), bloodcyst)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.BloodCystBurst, Cyst)