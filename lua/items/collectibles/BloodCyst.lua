local mod = Furtherance
local game = Game()

local Cyst = Isaac.GetEntityVariantByName("Blood Cyst")
local CystHitbox = Isaac.GetEntityVariantByName("Blood Cyst Hitbox")

function mod:RespawnCyst()
    local room = game:GetRoom()

    -- the cyst hitbox get automatically removed
    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity.Type == EntityType.ENTITY_FAMILIAR and entity.Variant == Cyst then
            entity:Remove()
        end
    end

    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if not room:IsClear() then
            for _ = 1, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BLOOD_CYST) do
                local position = Isaac.GetFreeNearPosition(room:GetRandomPosition(0), 40)
                local bloodCyst = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, Cyst, 0, position, Vector.Zero, player)
                local data = mod:GetData(bloodCyst)
                data.SavedPosition = position
                
                local hitbox = Isaac.Spawn(EntityType.ENTITY_BOIL, CystHitbox, 0, bloodCyst.Position, Vector.Zero, player):ToNPC()
                hitbox.HitPoints = 0
                hitbox.CanShutDoors = false
                hitbox.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
                hitbox:SetColor(Color(1, 1, 1, 0), 0, 1)

                local hitboxData = mod:GetData(hitbox)
                hitboxData.BloodCyst = bloodCyst
                hitboxData.SavedPosition = position
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RespawnCyst)

function mod:FreezePosition(bloodCyst)
    local data = mod:GetData(bloodCyst)
    if data.SavedPosition == nil then return end

    bloodCyst.Position = data.SavedPosition
    bloodCyst.Velocity = Vector.Zero
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.FreezePosition)

function mod:StopHitboxAI(boil)
    if boil.Variant ~= CystHitbox then return end
    
    local data = mod:GetData(boil)
    boil.Position = data.SavedPosition
    boil.Velocity = Vector.Zero

    return true
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, mod.StopHitboxAI, EntityType.ENTITY_BOIL)

function mod:IgnorePlayerCollisions(boil, collider)
    if boil.Variant == CystHitbox and collider.Type == EntityType.ENTITY_PLAYER then
        return true
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.IgnorePlayerCollisions, EntityType.ENTITY_BOIL)

function mod:HitboxDied(boil)
    if boil.Variant ~= CystHitbox then return end

    local data = mod:GetData(boil)
    local bloodCyst = data.BloodCyst
    local player = bloodCyst.SpawnerEntity:ToPlayer()

    bloodCyst:Die()
    boil:Remove()

    local hasBFFs = player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS)
    for i = 1, 8 do
        local CystTears = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, bloodCyst.Position, Vector(8, 0):Rotated(i * 45), bloodCyst):ToTear()
        if hasBFFs then
            CystTears.CollisionDamage = 7
            CystTears.Scale = 1.1
        end
    end

end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.HitboxDied, EntityType.ENTITY_BOIL)