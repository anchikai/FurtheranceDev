local mod = Furtherance
local game = Game()
local level = game:GetLevel()

local Cyst = Isaac.GetEntityVariantByName("Blood Cyst")

function mod:RespawnCyst()
    local room = game:GetRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if room:IsClear() == false and player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_CYST) then
            Isaac.Spawn(EntityType.ENTITY_BOIL, Cyst, 0, Isaac.GetFreeNearPosition(room:GetRandomPosition(0), 40), Vector.Zero, player)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RespawnCyst)

function mod:BloodCystBurst(bloodcyst, collider)
    if bloodcyst.Variant == Cyst and (collider.SpawnerType == EntityType.ENTITY_PLAYER or collider.Type == EntityType.ENTITY_PLAYER) then
        bloodcyst:Die()
        for i = 1, 8 do
            Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, bloodcyst.Position, Vector(8, 0):Rotated(i * 45), bloodcyst)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.BloodCystBurst, EntityType.ENTITY_BOIL)