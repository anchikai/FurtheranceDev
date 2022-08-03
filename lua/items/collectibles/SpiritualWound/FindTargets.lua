local game = Game()

local TargetType = {
    ENTITY = 0,
    GRID_ENTITY = 1,
    PSEUDO_GRID_ENTITY = 2,
    NO_TARGET = 3,
}

local TARGET_RANGE_MODIFIER = 0.5

local PSEUDO_GRID_MAX_DISTANCE = 800 -- (20 * sqrt(2)) ^ 2

---@class EntityTargetQuery
---@field Result Entity[]
---@field AllEnemies Entity[]
---@field Type 0

---@class GridEntityTargetQuery
---@field Result GridEntity
---@field AllEnemies Entity[]
---@field Type 1

---@class PseudoGridEntityTargetQuery
---@field Result Entity
---@field AllEnemies Entity[]
---@field Type 2

---@class NoTargetQuery
---@field AllEnemies Entity[]
---@field Type 3

---@alias TargetQuery EntityTargetQuery|GridEntityTargetQuery|PseudoGridEntityTargetQuery|NoTargetQuery

---@param focusPosition Vector
---@return Entity[]|nil
local function findEntityTargets(focusPosition)
    local result = {}
    local distanceMapping = {}
    for _, enemy in ipairs(Isaac.GetRoomEntities()) do
        if enemy:IsActiveEnemy() and enemy:IsVulnerableEnemy() and not enemy:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) or enemy.Type == EntityType.ENTITY_DUMMY then
            distanceMapping[enemy] = enemy.Position:DistanceSquared(focusPosition)
            table.insert(result, enemy)
        end
    end

    if #result == 0 then return nil end

    table.sort(result, function(a, b)
        return distanceMapping[a] < distanceMapping[b]
    end)

    return result
end

local vulnerableGridEntities = {
    [GridEntityType.GRID_POOP] = true,
    [GridEntityType.GRID_TNT] = true,
    [GridEntityType.GRID_FIREPLACE] = true
}

local deathStates = {
    [GridEntityType.GRID_POOP] = 1000,
    [GridEntityType.GRID_TNT] = 4,
}

---@param focusPosition Vector
---@return GridEntity|nil
local function findGridEntityTarget(focusPosition)
    local room = game:GetRoom()
    local gridEntity = room:GetGridEntityFromPos(focusPosition)
    if gridEntity == nil then return nil end

    local gridType = gridEntity:GetType()
    if vulnerableGridEntities[gridType] and deathStates[gridType] ~= gridEntity.State then
        return gridEntity
    end

    return nil
end

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

local vulnerableFireplaceVariants = {
    [FireplaceVariant.NORMAL] = true,
    [FireplaceVariant.RED] = true,
    [FireplaceVariant.MOVEABLE_NORMAL] = true,
}

---@param focusPosition Vector
---@return Entity|nil
local function findPseudoGridEntityTarget(focusPosition)
    local minDistance = PSEUDO_GRID_MAX_DISTANCE
    local nearestEntity
    for _, fireplace in ipairs(Isaac.FindByType(EntityType.ENTITY_FIREPLACE)) do
        local distance = fireplace.Position:DistanceSquared(focusPosition)
        if vulnerableFireplaceVariants[fireplace.Variant] and fireplace.HitPoints > 1 and distance < minDistance then
            minDistance = distance
            nearestEntity = fireplace
        end
    end

    for _, poop in ipairs(Isaac.FindByType(EntityType.ENTITY_POOP)) do
        local distance = poop.Position:DistanceSquared(focusPosition)
        if poop.HitPoints > 1 and distance < minDistance then
            minDistance = distance
            nearestEntity = poop
        end
    end

    for _, tnt in ipairs(Isaac.FindByType(EntityType.ENTITY_MOVABLE_TNT)) do
        local distance = tnt.Position:DistanceSquared(focusPosition)
        if tnt.HitPoints > 0.5 and distance < minDistance then
            minDistance = distance
            nearestEntity = tnt
        end
    end

    return nearestEntity
end

---@param entities Entity[]|nil -- this table should be sorted by distance
---@param maxDistance number
---@return Entity[]|nil
local function filterByMaxDistance(entities, focusPosition, maxDistance)
    if entities == nil then return nil end
    maxDistance = maxDistance * maxDistance

    local result = {}
    for _, entity in ipairs(entities) do
        if entity.Position:DistanceSquared(focusPosition) <= maxDistance then
            table.insert(result, entity)
        else
            break
        end
    end

    return #result > 0 and result or nil
end

local FindTargets = {
    TargetType = TargetType,
    TARGET_RANGE_MODIFIER = TARGET_RANGE_MODIFIER,
}
setmetatable(FindTargets, FindTargets)

---@param itemData SpiritualWoundItemData
---@return TargetQuery|nil
function FindTargets:__call(itemData)
    local focus = itemData.Focus
    if focus == nil then return nil end

    local player = itemData.Owner
    local focusPosition = focus.Position

    local entities = findEntityTargets(focusPosition)
    local entityTargets = filterByMaxDistance(entities, focusPosition, player.TearRange * TARGET_RANGE_MODIFIER)

    local result = {
        AllEnemies = entities
    }

    if entityTargets then
        result.Result = entityTargets
        result.Type = TargetType.ENTITY
        return result
    end

    local gridTarget = findGridEntityTarget(focusPosition)
    if gridTarget then
        result.Result = gridTarget
        result.Type = TargetType.GRID_ENTITY
        return result
    end
    
    local psuedoGridEntityTarget = findPseudoGridEntityTarget(focusPosition)
    if psuedoGridEntityTarget then
        result.Result = psuedoGridEntityTarget
        result.Type = TargetType.PSEUDO_GRID_ENTITY
        return result
    end

    if entities then
        result.Type = TargetType.NO_TARGET
        return result
    end

    return nil
end



return FindTargets
