local mod = Furtherance
local game = Game()

local MaxTearDistance = 80 ^ 2
local MaxEnemyDistance = 80 ^ 2

---@param player EntityPlayer
function mod:LeviathansTendrilUpdate(player)
    if not player:HasTrinket(TrinketType.TRINKET_LEVIATHANS_TENDRIL) then return end
    local rng = player:GetTrinketRNG(TrinketType.TRINKET_LEVIATHANS_TENDRIL)

    local chanceBonus = 0
    -- give a 5% bonus if they have the Leviathan transformation
    if player:HasPlayerForm(PlayerForm.PLAYERFORM_EVIL_ANGEL) then
        chanceBonus = 0.05
    end

    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        local data = mod:GetData(entity)
        if data.LeviathansTendrilProcessed then goto continue end

        local delta = entity.Position - player.Position ---@type Vector
        if entity.Type == EntityType.ENTITY_PROJECTILE then
            if entity.SpawnerType ~= EntityType.ENTITY_PLAYER and delta:LengthSquared() < MaxTearDistance then
                data.LeviathansTendrilProcessed = true
                if rng:RandomFloat() < 0.25 + chanceBonus then
                    local randomAngle = rng:RandomFloat() * 180 - 90
                    local newVelocity = delta:Rotated(randomAngle):Resized(entity.Velocity)
                    entity.Velocity = newVelocity
                end
            end
        elseif entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() and delta:LengthSquared() < MaxEnemyDistance then
            data.LeviathansTendrilProcessed = true
            if rng:RandomFloat() < 0.1 + chanceBonus then
                local playerRef = EntityRef(player)
                entity:AddFear(playerRef, 60)

                -- I don't know how much damage this should do
                entity:TakeDamage(5, 0, playerRef, 0)
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
