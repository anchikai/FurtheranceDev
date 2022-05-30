--[[

-0.5 Shot Speed
+0.2 range
chance to fire a "light beam" tear with a godhead-like aura that can shrink or
grow non-boss enemies.

]]

local mod = Furtherance
local game = Game()

---@param player EntityPlayer
---@param flag integer
function mod:KeratoconusBuffs(player, flag)
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS) then return end

    if flag == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed - 0.5
    elseif flag == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange + 8
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.KeratoconusBuffs)

---@param tear EntityTear
function mod:KeratoconusTear(tear)
    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil then return end
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS) then return end

    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KERATOCONUS)
    -- if rng:RandomFloat() >= 0.25 then return end

    local data = mod:GetData(tear)
    data.IsKeratoconusTear = true

    tear.TearFlags = tear.TearFlags | TearFlags.TEAR_LASERSHOT
    local glowEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALLOWED_GROUND, 0, tear.Position, tear.Velocity, tear):ToEffect()
    glowEffect.SpriteOffset = tear.Velocity:Resized(20)
    glowEffect:FollowParent(tear)
    data.KeratoconusGlow = glowEffect
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.KeratoconusTear)

function mod:KeratoconusTearUpdate(tear)
    local data = mod:GetData(tear)
    if not data.IsKeratoconusTear then return end

    local glowEffect = data.KeratoconusGlow
    if glowEffect == nil then return end

    glowEffect.SpriteOffset = tear.Velocity:Resized(20)
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.KeratoconusTearUpdate)