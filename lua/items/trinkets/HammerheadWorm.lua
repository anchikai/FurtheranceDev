local mod = Furtherance
local game = Game()

local RNG_INFLUENCE = 0.2
local function getMultiplier(rng)
    return rng:RandomFloat() * RNG_INFLUENCE * 2 + 1 - RNG_INFLUENCE
end

---@param tear EntityTear
function mod:FireHammerheadWormTear(tear)
    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil then return end
    if not player:HasTrinket(TrinketType.TRINKET_HAMMERHEAD_WORM) then return end

    local rng = player:GetTrinketRNG(TrinketType.TRINKET_HAMMERHEAD_WORM)
    local damageMultiplier = getMultiplier(rng)
    local velocityMultiplier = getMultiplier(rng)

    tear.ContinueVelocity = tear.ContinueVelocity * velocityMultiplier
    tear.Velocity = tear.Velocity * velocityMultiplier
    tear.CollisionDamage = tear.CollisionDamage * damageMultiplier
    tear.Height = tear.Height * getMultiplier(rng)
    tear.Scale = tear.Scale * (damageMultiplier * 0.5 + 0.5)
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireHammerheadWormTear)