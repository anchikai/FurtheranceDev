local mod = Furtherance
local game = Game()

local TARGET_RANGE_MULTIPLIER = 0.5

local targetHelpers = {}

local vulnerableGridTypes = {
    [GridEntityType.GRID_FIREPLACE] = true,
    [GridEntityType.GRID_POOP] = true,
    [GridEntityType.GRID_TNT] = true,
}

local deathStates = {
    [GridEntityType.GRID_POOP] = 1000,
    [GridEntityType.GRID_TNT] = 4
}

local EnemyType = {
    ENTITY = 0,
    GRID_ENTITY = 1,
    FIREPLACE = 2,
}
targetHelpers.EnemyType = EnemyType

local FireplaceVariant = {
    NORMAL = 0,
    RED = 1,
    BLUE = 2,
    PURPLE = 3,
    WHITE = 4,
    MOVEABLE_NORMAL = 10,
    COAL = 11,
    MOVEABLE_BLUE = 12,
    MOVEABLE_PURPLE = 13,
}

local targetableFireplaceVariants = {
    [FireplaceVariant.NORMAL] = true,
    [FireplaceVariant.RED] = true,
    [FireplaceVariant.MOVEABLE_NORMAL] = true,
}

local Enemy = {
    __type = "Enemy"
}
Enemy.__index = Enemy

function Enemy.new(entity, enemyType)
    local self = {
        Entity = entity,
        Type = enemyType
    }

    setmetatable(self, Enemy)

    return self
end

function Enemy:GetPtrHash()
    return GetPtrHash(self.Entity)
end

function Enemy:EntityExists()
    return self.Type == EnemyType.ENTITY and self.Entity:Exists()
end

function Enemy.equal(enemyA, enemyB)
    return enemyA == enemyB
        or enemyA ~= nil and enemyB ~= nil and enemyA:GetPtrHash() == enemyB:GetPtrHash()
end

local function getNewTargetEntity(position, maxDistance)
    local maxDistanceSq = maxDistance * maxDistance
    local newEnemy
    for _, entity in ipairs(Isaac.FindInRadius(position, maxDistanceSq, EntityPartition.ENEMY)) do
        if entity:IsVulnerableEnemy() and entity.Type ~= EntityType.ENTITY_FIREPLACE and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT) then
            local distanceSq = entity.Position:DistanceSquared(position)
            if distanceSq < maxDistanceSq then
                newEnemy = entity
                maxDistanceSq = distanceSq
            end
        end
    end

    return newEnemy
end

-- I purposely don't check every grid entity in a tear range radius. I think 
-- hitting stationary targets is not that difficult and it gives precision
local function getNewTargetGridEntity(position)
    local room = game:GetRoom()
    local gridEntity = room:GetGridEntityFromPos(position)
    if gridEntity == nil then return end

    local gridType = gridEntity:GetType()
    if vulnerableGridTypes[gridType] and deathStates[gridType] ~= gridEntity.State then
        return gridEntity
    end
end

local function getNewTargetFireplace(position)
    local fireplaceEntity
    
    local fireplaces = Isaac.FindByType(EntityType.ENTITY_FIREPLACE)
    for i = #fireplaces, 1, -1 do
        local fireplace = fireplaces[i]
        if not targetableFireplaceVariants[fireplace.Variant] then
            table.remove(fireplaces, i)
        end
    end
    
    local maxDistanceSq = 20 * 20
    for _, fireplace in ipairs(fireplaces) do
        local distanceSq = fireplace.Position:DistanceSquared(position)
        if distanceSq < maxDistanceSq then
            fireplaceEntity = fireplace
            maxDistanceSq = distanceSq
        end
    end

    return fireplaceEntity
end

local function getNewTarget(position, maxDistance)
    local newEnemy

    newEnemy = getNewTargetEntity(position, maxDistance)
    if newEnemy then
        return Enemy.new(newEnemy, EnemyType.ENTITY)
    end

    newEnemy = getNewTargetGridEntity(position)
    if newEnemy then
        return Enemy.new(newEnemy, EnemyType.GRID_ENTITY)
    end

    newEnemy = getNewTargetFireplace(position)
    if newEnemy then
        return Enemy.new(newEnemy, EnemyType.FIREPLACE)
    end

    return nil
end

function targetHelpers.getUntargetedEnemies(enemyTarget)
    local untargetedEnemies = {}
    local untargetedEnemiesCount = 0
    for _, enemy in ipairs(Isaac.GetRoomEntities()) do
        local enemyHash = GetPtrHash(enemy)
        if enemy:IsActiveEnemy()
            and enemy:IsVulnerableEnemy()
            and (enemyTarget == nil or enemyTarget:GetPtrHash() == enemyHash)
        then
            untargetedEnemies[enemyHash] = enemy
            untargetedEnemiesCount = untargetedEnemiesCount + 1
        end
    end

    return untargetedEnemies, untargetedEnemiesCount
end

function targetHelpers.updateTargetWithEnemiesPresent(player)
    local data = mod:GetData(player)
    local itemData = data.SpiritualWound
    if itemData == nil then return end

    local targetEffect = itemData.TargetEffect
    if targetEffect == nil then return end

    local targetData = mod:GetData(targetEffect)

    local oldEnemy = targetData.enemyTarget
    local newEnemy = getNewTarget(targetEffect.Position, player.TearRange * TARGET_RANGE_MULTIPLIER)
    if Enemy.equal(oldEnemy, newEnemy) then
        return oldEnemy
    end

    itemData.HitCount = 0
    targetData.enemyTarget = newEnemy

    -- increments/decrements a count of items targeting this entity
    -- Only used to work with multiplayer
    if oldEnemy and oldEnemy:EntityExists() then
        local oldEnemyData = mod:GetData(oldEnemy.Entity)
        if oldEnemyData.spiritualWound ~= nil then
            if oldEnemyData.spiritualWound > 1 then
                oldEnemyData.spiritualWound = oldEnemyData.spiritualWound - 1
            else
                oldEnemyData.spiritualWound = nil
            end
        end
    end

    if newEnemy and newEnemy:EntityExists() then
        local newEnemyData = mod:GetData(newEnemy.Entity)
        newEnemyData.spiritualWound = (newEnemyData.spiritualWound or 0) + 1
    end

    return newEnemy
end

function targetHelpers.updateTargetWithNoEnemiesPresent(player)
    local data = mod:GetData(player)
    local itemData = data.SpiritualWound
    if itemData == nil then return end

    local targetEffect = itemData.TargetEffect
    if targetEffect == nil then return end

    local targetData = mod:GetData(targetEffect)

    local oldEnemy = targetData.enemyTarget
    local newEnemy = getNewTarget(targetEffect.Position, player.TearRange * TARGET_RANGE_MULTIPLIER)
    if Enemy.equal(oldEnemy, newEnemy) then
        return oldEnemy
    end

    itemData.HitCount = 0
    targetData.enemyTarget = newEnemy
    targetData.enemyTargetType = EnemyType.GRID_ENTITY

    return newEnemy
end

local function snapTargetEffect(targetEffect)
    local targetData = mod:GetData(targetEffect)
    if targetData.enemyTarget == nil or targetData.enemyTarget.Type ~= EnemyType.ENTITY then return end
    local enemyTarget = targetData.enemyTarget.Entity

    if targetData.SnapCooldown == nil then
        targetData.SnapCooldown = 0
    end

    if targetData.SnapCooldown <= 0 and mod:GetData(enemyTarget).spiritualWound then
        --targetEffect.Position = targetData.enemyTarget.Position
        if targetEffect.Position:Distance(enemyTarget.Position) > 10 then
            local delta = enemyTarget.Position - targetEffect.Position
            targetEffect.Velocity = (0.75 * targetEffect.Velocity + delta:Resized(0.25 * 75))
        else
            targetEffect.Velocity = enemyTarget.Velocity
            targetEffect.Position = enemyTarget.Position
        end
    else
        targetData.SnapCooldown = targetData.SnapCooldown - 1
    end
end

function targetHelpers.setSnapped(targetEffect, isSnapped)
    if isSnapped then
        snapTargetEffect(targetEffect)
    else
        local targetData = mod:GetData(targetEffect)
        targetData.SnapCooldown = 15
    end
end



return targetHelpers