--[[
	Firstborn Son - "Fleeting friend"
	A familiar baby that:

    * Upon entering an uncleared room,
        * it immediately chases down and kills the enemy with the highest HP in
        the room that is not a boss/mini boss.
            * Ideally, this would be done using Spiritual Wound (basically
            homing lasers)
            * If too difficult, it can fire a fatal holy shot instead
        * it targets the nearest enemy if there's multiple.

    * If there are no normal enemies, it deals 10% of total HP damage to
    bosses.
    * It will respawn after each "wave" of enemies, if in Boss Rush/Mega Satan
    /The Beast/Greed Mode.

    Quality: 1
	Type: Familiar
	Item Pool: Treasure, Ultra Secret Room
	Transformations: Conjoined
	Item Sprite: Flesh coloured baby with Xs for eyes and blood painted on their forehead and arms.
	Appearance: See above. Animation for attack has the baby shoot a homing
    blue "holy shot" at the chosen target.
]]

--[[ see:
    Familiars Who Follow: https://www.youtube.com/watch?v=Vw5qQBaecGY&list=PLMZJyHSWa_My5DDoTQcKCgs475xIpQHSF&index=16
    Following Familiars Followup: https://www.youtube.com/watch?v=88uQQeqRWrg&list=PLMZJyHSWa_My5DDoTQcKCgs475xIpQHSF&index=21
]]

--[[
local LaserHomingType = {
    NORMAL = 0,
    FREEZE = 1,
    FREEZE_HEAD = 2
}

local LaserVariant = {
    BRIMSTONE = 1,
    TECHNOLOGY = 2,
    SHOOP_DA_WHOOP = 3,
    PRIDE = 4,
    LIGHT_BEAM = 5,
    MEGA_BLAST = 6,
    TRACTOR_BEAM = 7,
    LIGHT_RING = 8, -- crashes if you run this with homing
    BRIMTECH = 9,
    [1] = 10,
    [2] = 11,
    [3] = 12,
    [4] = 13,
    [5] = 14,
    [6] = 15
}
--]]

local mod = Furtherance
local game = Game()
local level = game:GetLevel()

---@param entities Entity[]
---@param source Entity
---@return Entity|nil -- the Entity that is closest to `source`. Returns `nil` if the `entities` argument was empty.
local function getClosestEntity(entities, source)
    local closestDist = math.huge
    local closestEnemy = nil
    for _, entity in ipairs(entities) do
        local dist = source.Position:Distance(entity.Position)
        if dist < closestDist then
            closestDist = dist
            closestEnemy = entity
        end
    end

    return closestEnemy
end

---@param entities Entity[]
---@return Entity[] -- an array of the highest max HP entities in the given array.
local function getMaxHPEntities(entities)
    ---@type Entity[]
    local allMaxHPEntities = {}

    local highestHP = -math.huge
    for _, entity in ipairs(entities) do
        local hp = entity.MaxHitPoints
        if hp > highestHP then
            highestHP = hp
        end
    end

    for _, entity in ipairs(entities) do
        if entity.MaxHitPoints == highestHP then
            table.insert(allMaxHPEntities, entity)
        end
    end

    return allMaxHPEntities
end

---@return Entity[]
local function getEnemies()
    ---@type Entity[]
    local allEnemies = {}
    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
            table.insert(allEnemies, entity)
        end
    end

    return allEnemies
end

---Gives back an entity with these attributes:
--- 1. Preferred non-boss
--- 2. has the highest HP in the room
--- 3. is the closest enemy to the `source` argument
---@param source Entity
---@return Entity|nil
local function getClosestHighestHPEnemyFavorNonBoss(source)
    ---@type Entity[]
    local allNonBosses = {}
    ---@type Entity[]
    local allBosses = {}
    for _, entity in ipairs(getEnemies()) do
        if GetPtrHash(entity) ~= GetPtrHash(source) then
            if entity:IsBoss() then
                table.insert(allBosses, entity)
            else
                table.insert(allNonBosses, entity)
            end
        end
    end

    if #allNonBosses > 0 then
        local allMaxHPNonBosses = getMaxHPEntities(allNonBosses)
        return getClosestEntity(allMaxHPNonBosses, source)
    elseif #allBosses > 0 then
        local allMaxHPBosses = getMaxHPEntities(allBosses)
        return getClosestEntity(allMaxHPBosses, source)
    else
        return nil
    end
end

---@param player EntityPlayer
function mod:SpawnFirstbornSon(player)
    player:CheckFamiliar(
        FamiliarVariant.FIRSTBORN_SON,
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_FIRSTBORN_SON, false),
        player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_FIRSTBORN_SON),
        Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_FIRSTBORN_SON),
        0
    )
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.SpawnFirstbornSon, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
function mod:FirstbornSonInit(familiar)
    local data = mod:GetData(familiar)
    data.ShotTear = false
    data.UnclearDelay = 30
    familiar.IsFollower = true
end

mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.FirstbornSonInit, FamiliarVariant.FIRSTBORN_SON)

local directionBoundaries = {
    { -135, Direction.LEFT },
    { -45, Direction.UP },
    { 45, Direction.RIGHT },
    { 135, Direction.DOWN }
}

---@param angle number -- An angle in degrees
---@return integer -- The corresponding Direction enum
local function getDirectionFromAngle(angle)
    local result = Direction.LEFT
    for _, array in ipairs(directionBoundaries) do
        local angleBoundary, direction = table.unpack(array)
        if angle < angleBoundary then
            result = direction
            break
        end
    end

    return result
end

---@param familiar EntityFamiliar -- The familiar shooting the tear
---@param target Entity -- The entity this tear is aimed at
local function shootFatalTear(familiar, target)
    local data = mod:GetData(familiar)
    local velocity = (target.Position - familiar.Position):Normalized() * 10

    ---@type EntityTear
    local tear = Isaac.Spawn(
        EntityType.ENTITY_TEAR,
        TearVariant.BLUE,
        0,
        familiar.Position,
        velocity,
        familiar
    ):ToTear()

    local tearData = mod:GetData(tear)
    tearData.IsFirstbornSonTear = true

    tear.Scale = 2
    tear:AddTearFlags(TearFlags.TEAR_SPECTRAL | TearFlags.TEAR_HOMING | TearFlags.TEAR_LIGHT_FROM_HEAVEN)
    tear.Target = target
    tear.Height = -20

    data.ShotTear = true
    data.ShootingDirection = getDirectionFromAngle(velocity:GetAngleDegrees())
    mod:DelayFunction(function()
        data.ShootingDirection = nil
    end, 10, nil, nil, true)
end

local oldGreedWavesNum = level.GreedModeWave

---@param familiar EntityFamiliar
function mod:FirstbornSonUpdate(familiar)
    familiar:FollowParent()

    local room = game:GetRoom()
    local data = mod:GetData(familiar)

    -- animation

    if data.ShootingAngle then
        familiar:PlayShootAnim(data.ShootingDirection)
    elseif familiar.Velocity:LengthSquared() >= 10 then
        familiar:PlayFloatAnim(getDirectionFromAngle(familiar.Velocity:GetAngleDegrees()))
    else
        familiar:PlayFloatAnim(Direction.DOWN)
    end

    -- make the familiar shoot a tear some time if they are in an uncleared room
    if room:IsClear() or oldGreedWavesNum ~= level.GreedModeWave then
        oldGreedWavesNum = level.GreedModeWave
        data.ShotTear = false
        data.UnclearDelay = 30
    elseif data.UnclearDelay > 0 then
        data.UnclearDelay = data.UnclearDelay - 1
    elseif not data.ShotTear then
        local target = getClosestHighestHPEnemyFavorNonBoss(familiar)
        if target then
            shootFatalTear(familiar, target)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.FirstbornSonUpdate, FamiliarVariant.FIRSTBORN_SON)

function mod:FirstbornSonNewRoom()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.FIRSTBORN_SON, 0, false, false)
    for _, familiar in ipairs(familiars) do
        local data = mod:GetData(familiar)
        data.ShotTear = false
        data.UnclearDelay = 30
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.FirstbornSonNewRoom)

---@param tear EntityTear
function mod:FirstbornSonTearUpdate(tear)
    if tear.FrameCount == 0 or tear:IsDead() then return end

    local tearData = mod:GetData(tear)
    if not tearData.IsFirstbornSonTear then return end

    local target = tear.Target
    if target:IsDead() or not target:Exists() then
        tear:Die()
    end

    tear.Height = -20
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.FirstbornSonTearUpdate)

---@param tear EntityTear
---@param collider Entity
---@return boolean|nil
function mod:FirstbornSonTearHit(tear, collider)
    local tearData = mod:GetData(tear)

    if not tearData.IsFirstbornSonTear then return end

    ---@type Entity
    local target = tear.Target
    if collider == nil or GetPtrHash(target) ~= GetPtrHash(collider) then
        return true
    end

    if target:IsBoss() then
        target:TakeDamage(target.MaxHitPoints * 0.1, 0, EntityRef(tear.SpawnerEntity), 0)
    else
        target:Kill()
    end
    tear:Die()
end

mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.FirstbornSonTearHit)
