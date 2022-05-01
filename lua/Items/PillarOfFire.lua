local mod = Furtherance
local game = Game()

function mod:SpawnFire(entity, damage, flag, source, frames)
    if entity.Type == EntityType.ENTITY_PLAYER then
        local player = entity:ToPlayer()
        if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)
            local rollFire = rng:RandomInt(100) + 1
            if rollFire <= (player.Luck * 5) + 5 then
                local speed = 4
                for i = 1, 5 do
                    if rng:RandomInt(2) == 0 then
                        RandomVector1 = rng:RandomFloat() * speed
                    else
                        RandomVector1 = -rng:RandomFloat() * speed
                    end
                    if rng:RandomInt(2) == 0 then
                        RandomVector2 = rng:RandomFloat() * speed
                    else
                        RandomVector2 = -rng:RandomFloat() * speed
                    end
                    local fire = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HOT_BOMB_FIRE, 0, player.Position, Vector(RandomVector1, RandomVector2), player)
                    fire:ToEffect().Scale = fire:ToEffect().Scale / 1.5

                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.SpawnFire, EntityType.ENTITY_PLAYER)

---@param player Entity
---@return Entity
local function getNearestEnemy(player)
    local nearestEnemy = nil
    local nearestDistance = math.huge

    for _, enemy in ipairs(Isaac.GetRoomEntities()) do
        if enemy:IsActiveEnemy(false) and enemy:IsVulnerableEnemy() then
            local delta = (player.Position - enemy.Position)
            local distance = delta:LengthSquared()
            if distance < nearestDistance then
                nearestDistance = distance
                nearestEnemy = enemy
            end
        end
    end

    return nearestEnemy
end

function mod:FireTears(entity)
    if entity.SpawnerType == EntityType.ENTITY_PLAYER then
        local player = entity.SpawnerEntity:ToPlayer()
        if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)
            if rng:RandomFloat() < 0.0025 then
                local target = getNearestEnemy(entity)
                if not target then return end

                local direction = (target.Position - entity.Position):Normalized()

                local speed = 4
                local velocity = direction * speed

                Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, entity.Position, velocity, entity)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.FireTears, EffectVariant.HOT_BOMB_FIRE)
