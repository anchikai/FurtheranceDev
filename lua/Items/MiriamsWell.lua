local mod = Furtherance
local game = Game()

local MiriamWell = Isaac.GetEntityVariantByName("Miriam's Well")

function mod:WellInit(Well)
    Well:AddToOrbit(1)
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.WellInit, MiriamWell)

function mod:WellUpdate(Well)
    for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
        Well.OrbitDistance = Vector(25, 25)
        Well.OrbitSpeed = 0.045
        Well.Velocity = Well:GetOrbitPosition(player.Position + player.Velocity) - Well.Position
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.WellUpdate, MiriamWell)

RespawnTimer = -1
function mod:WellCollide(Well, collider)
    if collider.Type ~= EntityType.ENTITY_PLAYER then
        SFXManager():Play(SoundEffect.SOUND_ROCK_CRUMBLE)
        local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 1, Well.Position, Vector.Zero, player):ToEffect()
        puddle.CollisionDamage = player.Damage/2
        Well:Die()
        RespawnTimer = 240
        if collider.Type == EntityType.ENTITY_PROJECTILE then
            collider:Die()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, mod.WellCollide, MiriamWell)

function mod:MiriamCache(player, flag)
    if flag == CacheFlag.CACHE_FAMILIARS then
        player:CheckFamiliar(MiriamWell, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MIRIAMS_WELL), player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MIRIAMS_WELL))
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.MiriamCache)

function mod:RespawnWell(player)
    if RespawnTimer > 0 then
        RespawnTimer = RespawnTimer - 1
    end
    if RespawnTimer == 0 then
        Isaac.Spawn(EntityType.ENTITY_FAMILIAR, MiriamWell, 0, player.Position, Vector.Zero, player)
        RespawnTimer = -1
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.RespawnWell)