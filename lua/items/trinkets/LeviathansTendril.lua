local mod = Furtherance
local game = Game()

local MaxTearDistance = 80 ^ 2
local MaxEnemyDistance = 80 ^ 2

---@param entity Entity
---@return table<integer, true>
local function getProcessedSet(entity)
    local data = mod:GetData(entity)
    local processedSet = data.LeviathansTendrilProcessed
    if processedSet == nil then
        processedSet = {}
        data.LeviathansTendrilProcessed = processedSet
    end

    return processedSet
end

---@param player EntityPlayer
---@param projectile EntityProjectile
---@param angleOffset number
local function redirectProjectile(player, projectile, angleOffset)
    -- redirect it in a direction away from the player
    local delta = projectile.Position - player.Position ---@type Vector
    projectile.Velocity = delta:Rotated(angleOffset):Resized(projectile.Velocity:Length())

    -- let it hit other enemies and stop homing
    projectile:AddProjectileFlags(ProjectileFlags.HIT_ENEMIES)
    projectile:ClearProjectileFlags(ProjectileFlags.SMART)
    projectile.Target = nil
end

---@param player EntityPlayer
---@param enemy Entity
local function redirectEnemy(player, enemy)
    local playerRef = EntityRef(player)

    -- redirect it away from the player
    enemy:AddFear(playerRef, 60)

    -- Deal some damage in the process
    enemy:TakeDamage(5, 0, playerRef, 0)
end

---@param player EntityPlayer
function mod:LeviathansTendrilUpdate(player)
    if not player:HasTrinket(TrinketType.TRINKET_LEVIATHANS_TENDRIL) then return end

    -- give a 5% bonus if they have the Leviathan transformation
    local chanceBonus = player:HasPlayerForm(PlayerForm.PLAYERFORM_EVIL_ANGEL) and 0.05 or 0
    local rng = player:GetTrinketRNG(TrinketType.TRINKET_LEVIATHANS_TENDRIL)
    local playerIndex = mod:GetEntityIndex(player)

    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        local processedSet = getProcessedSet(entity)
        if processedSet[playerIndex] then goto continue end

        local projectile = entity:ToProjectile()
        if projectile then
            if projectile.SpawnerType == EntityType.ENTITY_PLAYER then goto continue end
            if projectile.Position:DistanceSquared(player.Position) >= MaxTearDistance then goto continue end

            processedSet[playerIndex] = true
            if rng:RandomFloat() < 0.25 + chanceBonus then
                local angleOffset = rng:RandomFloat() * 180 - 90
                redirectProjectile(player, projectile, angleOffset)
            end
        elseif entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
            if entity.Position:DistanceSquared(player.Position) >= MaxEnemyDistance then goto continue end

            processedSet[playerIndex] = true
            if rng:RandomFloat() < 0.1 + chanceBonus then
                redirectEnemy(player, entity)
            end
        end
        ::continue::
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.LeviathansTendrilUpdate)

local wormFriendColor = Color(1, 1, 1)
wormFriendColor:SetColorize(1, 1, 1, 1)
wormFriendColor:SetTint(0.5, 0.5, 0.5, 1)

---@param familiar EntityFamiliar
function mod:WormFriendColorChange(familiar)
    local player = familiar.SpawnerEntity and familiar.SpawnerEntity:ToPlayer()

    if player and player:HasTrinket(TrinketType.TRINKET_LEVIATHANS_TENDRIL) then
        familiar:SetColor(wormFriendColor, 0, 0)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, mod.WormFriendColorChange, FamiliarVariant.WORM_FRIEND)

function mod:WormFriendKilledEnemy(entity)
    local wormFriends = Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.WORM_FRIEND)

    local killedByLeviathanWormFriend = false
    for _, wormEntity in ipairs(wormFriends) do
        local wormFriend = wormEntity:ToFamiliar() ---@type EntityFamiliar
        local owner = wormFriend.SpawnerEntity and wormFriend.SpawnerEntity:ToPlayer()
        if owner and owner:HasTrinket(TrinketType.TRINKET_LEVIATHANS_TENDRIL) and wormFriend.Target and GetPtrHash(wormFriend.Target) == GetPtrHash(entity) then
            killedByLeviathanWormFriend = true
            break
        end
    end

    if killedByLeviathanWormFriend then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, entity.Position, Vector.Zero, nil)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.WormFriendKilledEnemy)
