local mod = Furtherance
local game = Game()

local EffectVariantTarget = Isaac.GetEntityVariantByName("Spiritual Wound Target")
local EffectVariantImpact = Isaac.GetEntityVariantByName("Spiritual Wound Impact")

local HURT_COLOR = Color(1, 0, 0, 0.8)

local laserHelpers = include("lua/items/collectibles/SpiritualWound/laserHelpers.lua")
local targetHelpers = include("lua/items/collectibles/SpiritualWound/targetHelpers.lua")

local function hasItem(player)
    return player ~= nil and (
        player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
        or player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B
    )
end

local function addActiveCharge(player, amount, activeSlot)
    local polShiftConfig = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_POLARITY_SHIFT)
    player:SetActiveCharge(math.min(player:GetActiveCharge(activeSlot) + amount, polShiftConfig.MaxCharges), activeSlot)
end

local function setCanShoot(player, canShoot) -- Funciton Credit: im_tem
    local oldchallenge = game.Challenge

    game.Challenge = canShoot and Challenge.CHALLENGE_NULL or Challenge.CHALLENGE_SOLAR_SYSTEM
    player:UpdateCanShoot()
    game.Challenge = oldchallenge
end

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
    JACOBS_LADDER = 10,
    BIG_BRIMSTONE = 11,
    DIARRHEASTONE = 12,
    MEGA_BRIMTECH = 13,
    BIG_BRIMTECH = 14,
    BIGGER_BRIMTECH = 15,
}

local EnemyType = targetHelpers.EnemyType

local SpiritualWoundVariant = {
    NORMAL = LaserVariant.BRIMTECH,
    POLARITY_SHIFT = LaserVariant.JACOBS_LADDER
}

function mod:GetSpiritualWound(player)
    if hasItem(player) then
        setCanShoot(player, false)
    else
        setCanShoot(player, true)
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetSpiritualWound)

function mod:SpiritualWoundUpdate(laser)
    local data = mod:GetData(laser)
    if data.IsSpiritualWound then
        SFXManager():Stop(SoundEffect.SOUND_BLOOD_LASER)
        SFXManager():Stop(SoundEffect.SOUND_BLOOD_LASER_LOOP)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, mod.SpiritualWoundUpdate)

function mod:ReplaceBrimstoneSplash(entityType, variant, _, _, _, spawner)
    if spawner == nil then return end
    local laserSpawner = spawner.SpawnerEntity and spawner.SpawnerEntity:ToPlayer()

    if entityType == EntityType.ENTITY_EFFECT and variant == EffectVariant.LASER_IMPACT and hasItem(laserSpawner) then
        return { EntityType.ENTITY_EFFECT, EffectVariantImpact }
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.ReplaceBrimstoneSplash)

function mod:SpiritualWoundRender(laser)
    local data = mod:GetData(laser)
    if data.IsSpiritualWound then
        if laser.Variant == SpiritualWoundVariant.NORMAL then
            laser.SpriteScale = Vector.One * 0.3
        elseif laser.Variant == SpiritualWoundVariant.POLARITY_SHIFT then
            laser.SpriteScale = Vector.One * 2
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_RENDER, mod.SpiritualWoundRender)

local function handleUntargetedEnemyLasers(player, itemData, untargetedEnemies)
    local untargetLasers = itemData.UntargetLasers

    if next(untargetedEnemies) == nil then
        if untargetLasers then
            for _, lasers in pairs(untargetLasers) do
                laserHelpers.stopLasers(lasers)
            end
            itemData.UntargetLasers = nil
        end
        return false
    end

    if untargetLasers == nil then
        untargetLasers = {}
        itemData.UntargetLasers = untargetLasers
    end

    -- remove lasers for enemies that are missing
    local removedLasers = {}
    for ptrHash, lasers in pairs(untargetLasers) do
        local enemy = untargetedEnemies[ptrHash]
        if enemy == nil then
            laserHelpers.stopLasers(lasers)
            table.insert(removedLasers, ptrHash)
        end
    end

    for _, ptrHash in ipairs(removedLasers) do
        untargetLasers[ptrHash] = nil
    end

    -- spawn and update lasers for existing enemies
    local lasersSpawned = false
    for ptrHash, enemy in pairs(untargetedEnemies) do
        local lasers = itemData.UntargetLasers[ptrHash]
        if lasers == nil then
            lasers = laserHelpers.spawnLasers(player, enemy.Position, 1)
            itemData.UntargetLasers[ptrHash] = lasers
            lasersSpawned = true
        elseif player.FrameCount % 2 == 0 then
            laserHelpers.updateLasers(player, lasers, enemy.Position)
        end
    end

    return lasersSpawned
end

local function handleUntargetedEnemyDamage(player, enemyTarget, targetDamage, untargetedEnemies, untargetedEnemiesCount)
    local untargetDamage
    if enemyTarget then
        untargetDamage = targetDamage * 0.05
    else
        untargetDamage = targetDamage / untargetedEnemiesCount
    end

    for _, enemy in pairs(untargetedEnemies) do
        enemy:TakeDamage(untargetDamage, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
        enemy:SetColor(HURT_COLOR, 2, 1, false, false)
    end
end

local function aimWithEnemiesPresent(player, itemData)

    local targetEffect = itemData.TargetEffect
    local enemyTarget = targetHelpers.updateTargetWithEnemiesPresent(player)

    local lasersSpawned = false
    if enemyTarget ~= nil and itemData.TargetLasers == nil then
        itemData.TargetLasers = laserHelpers.spawnLasers(player, targetEffect.Position, 3)
        lasersSpawned = true
    elseif enemyTarget == nil and itemData.TargetLasers ~= nil then
        laserHelpers.stopLasers(itemData.TargetLasers)
        itemData.TargetLasers = nil
    elseif enemyTarget ~= nil and itemData.TargetLasers ~= nil and player.FrameCount % 2 == 0 then
        itemData.TargetLasers = laserHelpers.updateLasers(player, itemData.TargetLasers, enemyTarget.Entity.Position)
    end

    local untargetedEnemies, untargetedEnemiesCount
    local hasBirthright = player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
    if hasBirthright then
        untargetedEnemies, untargetedEnemiesCount = targetHelpers.getUntargetedEnemies(enemyTarget)
        lasersSpawned = lasersSpawned or handleUntargetedEnemyLasers(player, itemData, untargetedEnemies)
    end

    if lasersSpawned then
        laserHelpers.playLaserSounds()
    elseif (itemData.TargetLasers == nil or #itemData.TargetLasers <= 0) and (itemData.UntargetLasers == nil or next(itemData.UntargetLasers) == nil) then
        laserHelpers.stopLaserSounds()
    end

    local roundedFireDelay = math.floor(player.MaxFireDelay + 0.5)
    if game:GetFrameCount() % roundedFireDelay ~= 0 then return end

    -- Damaging
    local damageMultiplier = 0.33
    if itemData.GetDamageMultiplier then
        damageMultiplier = itemData:GetDamageMultiplier()
    end

    local targetDamage = player.Damage * damageMultiplier
    if hasBirthright then
        handleUntargetedEnemyDamage(player, enemyTarget, targetDamage, untargetedEnemies, untargetedEnemiesCount)
        if enemyTarget and enemyTarget.Type == EnemyType.ENTITY then
            targetDamage = targetDamage * (1 - 0.05 * untargetedEnemiesCount)
        end
    end

    if enemyTarget == nil then return end

    if enemyTarget.Type == EnemyType.ENTITY then
        itemData.HitCount = (itemData.HitCount or 0) + 1

        enemyTarget.Entity:TakeDamage(targetDamage, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
        enemyTarget.Entity:SetColor(HURT_COLOR, 2, 1, false, false)

        if enemyTarget.Entity:HasMortalDamage() then
            itemData.HitCount = 0
        end
    elseif enemyTarget.Type == EnemyType.GRID_ENTITY then
        local roundedTargetDamage = math.floor(targetDamage + 0.5)
        enemyTarget.Entity:Hurt(roundedTargetDamage)
    elseif enemyTarget.Type == EnemyType.FIREPLACE then
        enemyTarget.Entity:TakeDamage(targetDamage, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
    end
end

local function aimWithNoEnemiesPresent(player, itemData)
    local targetEffect = itemData.TargetEffect

    if itemData.UntargetLasers then
        for _, lasers in pairs(itemData.UntargetLasers) do
            laserHelpers.stopLasers(lasers)
        end
        itemData.UntargetLasers = nil
    end

    local lasersSpawned = false

    local enemyTarget = targetHelpers.updateTargetWithNoEnemiesPresent(player)
    if enemyTarget ~= nil and itemData.TargetLasers == nil then
        itemData.TargetLasers = laserHelpers.spawnLasers(player, targetEffect.Position, 3)
        lasersSpawned = true
    elseif enemyTarget == nil and itemData.TargetLasers ~= nil then
        laserHelpers.stopLasers(itemData.TargetLasers)
        itemData.TargetLasers = nil
    elseif enemyTarget ~= nil and itemData.TargetLasers ~= nil and player.FrameCount % 2 == 0 then
        itemData.TargetLasers = laserHelpers.updateLasers(player, itemData.TargetLasers, enemyTarget.Entity.Position)
    end

    if lasersSpawned then
        laserHelpers.playLaserSounds()
    elseif (itemData.TargetLasers == nil or #itemData.TargetLasers <= 0) and (itemData.UntargetLasers == nil or next(itemData.UntargetLasers) == nil) then
        laserHelpers.stopLaserSounds()
    end

    local roundedFireDelay = math.floor(player.MaxFireDelay + 0.5)
    if game:GetFrameCount() % roundedFireDelay ~= 0 then return end

    if enemyTarget == nil then return end

    -- Damaging
    local damageMultiplier = 0.33
    if itemData.GetDamageMultiplier then
        damageMultiplier = itemData:GetDamageMultiplier()
    end

    local targetDamage = player.Damage * damageMultiplier
    if enemyTarget.Type == EnemyType.GRID_ENTITY then
        local roundedTargetDamage = math.floor(targetDamage + 0.5)
        enemyTarget.Entity:Hurt(roundedTargetDamage)
    elseif enemyTarget.Type == EnemyType.FIREPLACE then
        enemyTarget.Entity:TakeDamage(targetDamage, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
    end
end

---@param player EntityPlayer
function mod:AimSpiritualWound(player)
    if not hasItem(player) then return end

    local data = mod:GetData(player)
    local room = game:GetRoom()

    local itemData = data.SpiritualWound
    if not itemData then
        itemData = {
            TargetEffect = nil,
            HitCount = 0,
            LaserVariant = SpiritualWoundVariant.NORMAL,
        }
        data.SpiritualWound = itemData
    end

    -- Target (credit to lambchop_is_ok for the base for this)
    local b_left = Input.GetActionValue(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
    local b_right = Input.GetActionValue(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
    local b_up = Input.GetActionValue(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
    local b_down = Input.GetActionValue(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
    local isAttacking = (b_down + b_right + b_left + b_up) > 0

    -- Create target
    if isAttacking and not itemData.TargetEffect then
        local targetEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariantTarget, 0, player.Position, Vector.Zero, player):ToEffect()
        itemData.TargetEffect = targetEffect

        targetEffect.Parent = player
        targetEffect.SpawnerEntity = player
        targetEffect.DepthOffset = -100
        targetEffect:GetSprite():Play("Blink", true)
        targetEffect.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
    end

    -- Continue if target exists
    if not itemData.TargetEffect then return end
    if not itemData.TargetEffect:Exists() then
        itemData.TargetEffect = nil
        return
    end

    local targetEffect = itemData.TargetEffect

    -- Snap to closest enemy if player isn't moving target
    targetHelpers.setSnapped(targetEffect, not isAttacking)

    -- Movement
    local targetVelocity = Vector(b_right - b_left, b_down - b_up)
    targetEffect.Velocity = (targetEffect.Velocity * 0.5 + targetVelocity * (player.ShotSpeed * 6.25) * 0.5)

    if room:GetAliveEnemiesCount() > 0 then
        aimWithEnemiesPresent(player, itemData)
    else
        aimWithNoEnemiesPresent(player, itemData)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.AimSpiritualWound)

function mod:RemoveTargetOnDrop(player)
    local data = mod:GetData(player)
    local itemData = data.SpiritualWound
    if itemData == nil then return end

    local isDropPressed = Input.GetActionValue(ButtonAction.ACTION_DROP, player.ControllerIndex) > 0
    if not itemData.WasDropPressed and isDropPressed then
        local targetEffect = itemData.TargetEffect
        if targetEffect == nil then goto updateDropPressed end

        if targetEffect:Exists() then
            targetEffect:Remove()

            if itemData.TargetLasers then
                laserHelpers.stopLasers(itemData.TargetLasers)
                itemData.TargetLasers = nil
            end

            if itemData.UntargetLasers then
                for _, lasers in pairs(itemData.UntargetLasers) do
                    laserHelpers.stopLasers(lasers)
                end
                itemData.UntargetLasers = nil
            end

            laserHelpers.stopLaserSounds()
        end
        itemData.TargetEffect = nil
    end
    ::updateDropPressed::
    itemData.WasDropPressed = isDropPressed
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.RemoveTargetOnDrop)

function mod:ResetSpiritualWoundTarget()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        local itemData = data.SpiritualWound
        if hasItem(player) and itemData then
            itemData.HitCount = 0
            itemData.LaserVariant = SpiritualWoundVariant.NORMAL
            itemData.OldLaserVariant = nil
            itemData.GetDamageMultiplier = nil
            if itemData.TargetEffect and not itemData.TargetEffect:Exists() then
                itemData.TargetEffect = nil
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ResetSpiritualWoundTarget)

function mod:SpiritualKill(entity)
    local enemyData = mod:GetData(entity)
    if enemyData.spiritualWound == nil then return end

    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)

        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
        if hasItem(player) and rng:RandomFloat() <= 1 then
            if player:HasCollectible(CollectibleType.COLLECTIBLE_POLARITY_SHIFT) and (player:HasFullHearts() or data.UsedPolarityShift) then
                for _, activeSlot in pairs(ActiveSlot) do
                    if player:GetActiveItem(activeSlot) == CollectibleType.COLLECTIBLE_POLARITY_SHIFT then
                        addActiveCharge(player, 1, activeSlot)
                        game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_PRIMARY)
                        if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) < 6 then
                            SFXManager():Play(SoundEffect.SOUND_BEEP)
                        else
                            SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
                            SFXManager():Play(SoundEffect.SOUND_ITEMRECHARGE)
                        end
                    end
                end
            elseif not data.UsedPolarityShift then
                SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
                player:AddHearts(1)
            end

        end
    end

    enemyData.spiritualWound = nil
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.SpiritualKill)