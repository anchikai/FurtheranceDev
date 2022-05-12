local mod = Furtherance
local game = Game()

local MiriamWell = Isaac.GetEntityVariantByName("Miriam's Well")

function mod:WellInit(Well)
    local data = mod:GetData(Well)
    data.WellRespawnTimer = -1
    data.WellDied = false
    Well:AddToOrbit(1)
    if data.WellRespawnTimer > 0 then
        Well:Remove()
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.WellInit, MiriamWell)

function mod:WellUpdate(Well)
    local data = mod:GetData(Well)
    local player = Well.SpawnerEntity:ToPlayer()
    Well.OrbitDistance = Vector(45, 45)
    Well.OrbitSpeed = 0.03
    Well.Velocity = Well:GetOrbitPosition(player.Position + player.Velocity) - Well.Position
    if data.WellRespawnTimer > 0 then
        data.WellRespawnTimer = data.WellRespawnTimer - 1
        if data.WellRespawnTimer == 0 then
            data.WellRespawnTimer = -1
            data.WellDied = false
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.WellUpdate, MiriamWell)

function mod:WellCollide(Well, collider)
    local player = Well.SpawnerEntity:ToPlayer()
    local data = mod:GetData(Well)
    if collider.Type ~= EntityType.ENTITY_PLAYER then
        if data.WellDied ~= true then
            data.WellDied = true
            SFXManager():Play(SoundEffect.SOUND_ROCK_CRUMBLE)
            local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 1, Well.Position, Vector.Zero, player):ToEffect()
            puddle.CollisionDamage = player.Damage/2
            data.WellRespawnTimer = 240
            if collider.Type == EntityType.ENTITY_PROJECTILE then
                collider:Die()
            end
        else
            return true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, mod.WellCollide, MiriamWell)

function mod:MiriamCache(player, flag)
    if flag == CacheFlag.CACHE_FAMILIARS then
        player:CheckFamiliar(MiriamWell, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MIRIAMS_WELL), player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MIRIAMS_WELL), Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_WELL))
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.MiriamCache)

function mod:WellRender(Well)
    local data = mod:GetData(Well)
    local sprite = Well:GetSprite()
    sprite:Load("gfx/miriams_well.anm2", true)
    if data.WellDied then
        if sprite:IsPlaying("Break") == false then
            sprite:Play("Break", true)
        end
    else
        if sprite:IsPlaying("Idle") == false then
            sprite:Play("Idle", true)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_RENDER, mod.WellRender, MiriamWell)