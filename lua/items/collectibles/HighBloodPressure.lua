local mod = Furtherance
local game = Game()

local function getNearestEnemy(position)
    local nearestEnemy
    local maxDistance = math.huge
    for _, enemy in ipairs(Isaac.GetRoomEntities()) do
        if enemy:IsActiveEnemy() and enemy:IsVulnerableEnemy() then
            local distance = enemy.Position:DistanceSquared(position)
            if distance < maxDistance then
                maxDistance = distance
                nearestEnemy = enemy
            end
        end
    end

    return nearestEnemy
end

function mod:HighBloodPressureOnHit(entity)
    local player = entity:ToPlayer()
    if player == nil then return end
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_HIGH_BLOOD_PRESSURE) then return end
    print("player took damage")

    local nearestEnemy = getNearestEnemy(player.Position)
    local delta
    if nearestEnemy then
        delta = (nearestEnemy.Position - player.Position)
    else
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HIGH_BLOOD_PRESSURE)
        local angle = rng:RandomFloat() * 360
        delta = Vector.FromAngle(angle)
    end
    player:FireBrimstone(delta, player, 1)
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.HighBloodPressureOnHit)