--[[

-0.5 Shot Speed
+0.2 range
chance to fire a "light beam" tear with a godhead-like aura that can shrink or
grow non-boss enemies.

]]

local mod = Furtherance
local game = Game()

function mod:KeratoconusBuffs(player, flag)
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS) then return end

    if flag == CacheFlag.CACHE_SHOTSPEED then
        player.ShotSpeed = player.ShotSpeed - 0.5
    elseif flag == CacheFlag.CACHE_RANGE then
        player.TearRange = player.TearRange + 8
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.KeratoconusBuffs)

function mod:KeratoconusTear(tear)
    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil then return end
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS) then return end

    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KERATOCONUS)
    -- if rng:RandomFloat() >= 0.25 then return end

    local data = mod:GetData(tear)
    data.IsKeratoconusTear = true

    local glowEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALLOWED_GROUND, 0, tear.Position, tear.Velocity, tear):ToEffect()
    glowEffect:FollowParent(tear)
    data.KeratoconusGlow = glowEffect
    glowEffect.SpriteScale = glowEffect.SpriteScale / 2.2
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.KeratoconusTear)

function mod:SizeChanging(tear)
    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil then return end
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS) then return end

    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KERATOCONUS)
    for _, entity in ipairs(Isaac.FindInRadius(tear.Position, 40, EntityPartition.ENEMY)) do
        local data = mod:GetData(entity)
        if rng:RandomFloat() <= 0.5 then
            data.KeratoconusScale = 2
        else
            data.KeratoconusScale = 0.5
        end
        if data.IsAffectedByKer ~= true then
            entity:ToNPC().Scale = data.KeratoconusScale
            data.IsAffectedByKer = true
        end
        print(data.KeratoconusScale)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.SizeChanging)