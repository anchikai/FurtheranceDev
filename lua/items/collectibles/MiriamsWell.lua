local mod = Furtherance

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
    Well.OrbitDistance = Vector(40, 40)
    Well.OrbitSpeed = 0.03
    Well.Velocity = Well:GetOrbitPosition(player.Position + player.Velocity) - Well.Position
    local sprite = Well:GetSprite()
    if data.WellRespawnTimer > 0 then
        data.WellRespawnTimer = data.WellRespawnTimer - 1
        if data.WellRespawnTimer == 0 then
            sprite:Load("gfx/miriams_well.anm2", true)
            sprite:SetAnimation("Idle", true)
            sprite:Play("Idle", true)
            data.WellRespawnTimer = -1
            data.WellDied = false
        end
    end
    if sprite:IsPlaying("Break") and sprite:GetFrame() == 10 then
        local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 1, Well.Position, Vector.Zero, player):ToEffect()
        puddle.CollisionDamage = player.Damage/2
        SFXManager():Play(SoundEffect.SOUND_GASCAN_POUR)
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.WellUpdate, MiriamWell)

function mod:WellCollide(Well, collider)
    local data = mod:GetData(Well)
    if collider.Type ~= EntityType.ENTITY_PLAYER then
        if data.WellDied ~= true then
            local sprite = Well:GetSprite()
            sprite:Load("gfx/miriams_well.anm2", true)
            sprite:SetAnimation("Break", true)
            sprite:Play("Break", true)
            data.WellDied = true
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