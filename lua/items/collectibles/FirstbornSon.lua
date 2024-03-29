local mod = Furtherance
local game = Game()
local level = game:GetLevel()

local bossRushWave = 0
local FirstbornSonFamiliar = Isaac.GetEntityVariantByName("Firstborn Son")

---A mapping of entity types to variants to booleans.
---`true` means that they have spawned, `false` means that they haven't.
local spawnedFlags = {
    [EntityType.ENTITY_LARRYJR] = {
        [0] = false,
        [1] = false,
    },
    [EntityType.ENTITY_MONSTRO] = {
        [0] = false,
    },
    [EntityType.ENTITY_CHUB] = {
        [0] = false,
        [1] = false,
        [2] = false,
    },
    [EntityType.ENTITY_GURDY] = {
        [0] = false,
    },
    [EntityType.ENTITY_MONSTRO2] = {
        [0] = false,
        [1] = false,
    },
    [EntityType.ENTITY_PIN] = {
        [0] = false,
        [2] = false,
    },
    [EntityType.ENTITY_FAMINE] = {
        [0] = false,
    },
    [EntityType.ENTITY_PESTILENCE] = {
        [0] = false,
    },
    [EntityType.ENTITY_WAR] = {
        [0] = false,
    },
    [EntityType.ENTITY_DEATH] = {
        [0] = false,
    },
    [EntityType.ENTITY_DUKE] = { -- Duke of Flies
        [0] = false,
        [1] = false,
    },
    [EntityType.ENTITY_PEEP] = {
        [0] = false,
        [1] = false,
    },
    [EntityType.ENTITY_LOKI] = {
        [0] = false,
    },
    [EntityType.ENTITY_FISTULA_BIG] = {
        [0] = false,
    },
    [EntityType.ENTITY_BLASTOCYST_BIG] = {
        [0] = false,
    },
    [EntityType.ENTITY_GEMINI] = {
        [0] = false,
        [1] = false,
        [2] = false,
    },
    [EntityType.ENTITY_FALLEN] = {
        [0] = false,
    },
    [EntityType.ENTITY_HEADLESS_HORSEMAN] = {
        [0] = false,
    },
    [EntityType.ENTITY_MASK_OF_INFAMY] = {
        [0] = false,
    },
    [EntityType.ENTITY_GURDY_JR] = {
        [0] = false,
    },
    [EntityType.ENTITY_WIDOW] = {
        [0] = false,
        [1] = false,
    },
    [EntityType.ENTITY_GURGLING] = {
        [1] = false,
        [2] = false,
    },
    [EntityType.ENTITY_THE_HAUNT] = {
        [0] = false,
    },
    [EntityType.ENTITY_DINGLE] = {
        [0] = false,
        [1] = false,
    },
    [EntityType.ENTITY_MEGA_MAW] = {
        [0] = false,
    },
    [EntityType.ENTITY_GATE] = {
        [0] = false,
    },
    [EntityType.ENTITY_MEGA_FATTY] = {
        [0] = false,
    },
    [EntityType.ENTITY_CAGE] = {
        [0] = false,
    },
    [EntityType.ENTITY_DARK_ONE] = {
        [0] = false,
    },
    [EntityType.ENTITY_ADVERSARY] = {
        [0] = false,
    },
    [EntityType.ENTITY_POLYCEPHALUS] = {
        [0] = false,
    },
    [EntityType.ENTITY_URIEL] = {
        [0] = false,
    },
    [EntityType.ENTITY_GABRIEL] = {
        [0] = false,
    },
    [EntityType.ENTITY_STAIN] = {
        [0] = false,
    },
    [EntityType.ENTITY_BROWNIE] = {
        [0] = false,
    },
    [EntityType.ENTITY_FORSAKEN] = {
        [0] = false,
    },
    [EntityType.ENTITY_LITTLE_HORN] = {
        [0] = false,
    },
    [EntityType.ENTITY_RAG_MAN] = {
        [0] = false,
    },
}

-- make this table point to the same flags
spawnedFlags[EntityType.ENTITY_HORSEMAN_HEAD] = spawnedFlags[EntityType.ENTITY_HEADLESS_HORSEMAN]

-- similar mapping for compatibility with Updated Boss Rush
local updatedSpawnedFlags = {
    -- Afterbirth+ Bosses
    [EntityType.ENTITY_RAG_MEGA] = {
        [0] = false,
    },
    [EntityType.ENTITY_BIG_HORN] = {
        [0] = false,
    },
    [EntityType.ENTITY_SISTERS_VIS] = {
        [0] = false,
    },
    [EntityType.ENTITY_MATRIARCH] = {
        [0] = false,
    },

    [EntityType.ENTITY_WAR] = {
        [1] = false, -- Conquest
    },

    -- Repentance Bosses
    [EntityType.ENTITY_BABY_PLUM] = {
        [0] = false,
    },
    [EntityType.ENTITY_BUMBINO] = {
        [0] = false,
    },
    [EntityType.ENTITY_REAP_CREEP] = {
        [0] = false,
    },
    [EntityType.ENTITY_POLYCEPHALUS] = {
        [1] = false, -- The Pile
    },
}

local inBossRush = false

function mod:CheckBossRush()
    local room = game:GetRoom()
    inBossRush = room:GetType() == RoomType.ROOM_BOSSRUSH
    if inBossRush and bossRushWave < 15 then
        mod:ResetBossRushWaveCounter()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.CheckBossRush)

function mod:ResetBossRushWaveCounter()
    bossRushWave = 0

    for _, variantMap in pairs(spawnedFlags) do
        for key in pairs(variantMap) do
            variantMap[key] = false
        end
    end

    if UpdatedBossRush then
        for _, variantMap in pairs(updatedSpawnedFlags) do
            for key in pairs(variantMap) do
                variantMap[key] = false
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ResetBossRushWaveCounter)

---bosses will spawn in 15 waves of two bosses each, each boss can only spawn once, but bosses some bosses such as larryJr will spawn in as three separate bosses.
---I cant just check to see if the number of bosses has increased since the last run of the function because some bosses like fistula can split into more bosses and increase the wave number even if the wave hasn't finished.
---because of this, the loop will only look for each individual type and varient of a boss once, and if it finds one of them, it won't count the possible other copies of the same boss towards the newSpawns integer
---this will loop through all the bosses that are currently in the room
---if the loop finds a boss that hasn't spawned before, it will update the newSpawns integer.
---if the newSpawns integer is 2 (or greater than 2 for whatever reason), that means that a new wave has started and the waves number gets updated
function mod:UpdateBossRushWaveCounter()
    if not inBossRush then return end

    local newSpawns = 0

    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsBoss() and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) then
            local typeFlags = spawnedFlags[entity.Type]
            if typeFlags and typeFlags[entity.Variant] == false then
                newSpawns = newSpawns + 1
                typeFlags[entity.Variant] = true
            end

            if UpdatedBossRush then
                local updatedTypeFlags = updatedSpawnedFlags[entity.Type]
                if updatedTypeFlags and updatedTypeFlags[entity.Variant] == false then
                    newSpawns = newSpawns + 1
                    updatedTypeFlags[entity.Variant] = true
                end
            end

        end
    end

    if newSpawns >= 2 then
        bossRushWave = bossRushWave + 1
    end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.UpdateBossRushWaveCounter)

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

local function getMaxHPEntities(entities)
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

local function getEnemies()
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
local function getClosestHighestHPEnemyFavorNonBoss(source)
    local allNonBosses = {}
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

function mod:SpawnFirstbornSon(player)
    player:CheckFamiliar(FirstbornSonFamiliar, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_FIRSTBORN_SON, false), RNG(), Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_FIRSTBORN_SON), 0)
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.SpawnFirstbornSon, CacheFlag.CACHE_FAMILIARS)

function mod:FirstbornSonInit(familiar)
    local data = mod:GetData(familiar)
    data.ShotTear = false
    data.UnclearDelay = 30
    data.OldGreedWave = level.GreedModeWave
    data.OldBossRushWave = bossRushWave

    familiar.IsFollower = true
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.FirstbornSonInit, FirstbornSonFamiliar)

local directionBoundaries = {
    { -135, Direction.LEFT },
    { -45, Direction.UP },
    { 45, Direction.RIGHT },
    { 135, Direction.DOWN }
}

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

local function shootFatalTear(familiar, target)
    local data = mod:GetData(familiar)
    local velocity = (target.Position - familiar.Position):Normalized() * 10
    local tear = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLUE, 0, familiar.Position, velocity, familiar):ToTear()
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

function mod:FirstbornSonUpdate(familiar)
    familiar:FollowParent()

    local room = game:GetRoom()
    local data = mod:GetData(familiar)

    -- animation

    if data.ShootingDirection then
        familiar:PlayShootAnim(data.ShootingDirection)
    elseif familiar.Velocity:LengthSquared() >= 10 then
        familiar:PlayFloatAnim(getDirectionFromAngle(familiar.Velocity:GetAngleDegrees()))
    else
        familiar:PlayFloatAnim(Direction.DOWN)
    end

    if game:IsGreedMode() then
        -- room is never clear during greed mode waves
        if room:IsClear() or data.OldGreedWave == level.GreedModeWave then
            data.ShotTear = false
            data.UnclearDelay = 30
        elseif data.UnclearDelay > 0 then
            data.UnclearDelay = data.UnclearDelay - 1
        elseif not data.ShotTear then
            local target = getClosestHighestHPEnemyFavorNonBoss(familiar)
            if target then
                data.OldGreedWave = level.GreedModeWave
                shootFatalTear(familiar, target)
            end
        end
    elseif room:GetType() == RoomType.ROOM_BOSSRUSH then
        if data.OldBossRushWave == bossRushWave then
            data.ShotTear = false
            data.UnclearDelay = 30
        elseif data.UnclearDelay > 0 then
            data.UnclearDelay = data.UnclearDelay - 1
        elseif not data.ShotTear then
            local target = getClosestHighestHPEnemyFavorNonBoss(familiar)
            if target then
                data.OldBossRushWave = bossRushWave
                shootFatalTear(familiar, target)
            end
        end
    elseif room:IsClear() then -- make the familiar shoot a tear some time if they are in an uncleared room
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
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.FirstbornSonUpdate, FirstbornSonFamiliar)

function mod:FirstbornSonNewRoom()
    local familiars = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FirstbornSonFamiliar, 0, false, false)
    for _, familiar in ipairs(familiars) do
        local data = mod:GetData(familiar)
        data.ShotTear = false
        data.UnclearDelay = 30
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.FirstbornSonNewRoom)

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

function mod:FirstbornSonTearHit(tear, collider)
    local tearData = mod:GetData(tear)
    if not tearData.IsFirstbornSonTear then return end

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