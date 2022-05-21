local mod = Furtherance
local game = Game()

function mod:GetVeil(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_PUTRID_VEIL) then
		player.TearHeight = player.TearHeight + 2
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetVeil, CacheFlag.CACHE_RANGE)

function mod:HealChance(entity)
    for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MIRIAMS_PUTRID_VEIL)
        if player and player:HasCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_PUTRID_VEIL) and rng:RandomFloat() <= 0.05 then
            if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
                SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
                player:AddHearts(1)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.HealChance)

function mod:SetLinger(tear, collider)
    local data = mod:GetData(collider)
    local player = tear.SpawnerEntity:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_PUTRID_VEIL) then
        if collider:IsActiveEnemy(false) and collider:IsVulnerableEnemy() then
            data.VeilLingerDamage = 90
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.SetLinger)
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.SetLinger)

function mod:LingeringDamage(entity)
    local data = mod:GetData(entity)
    if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
        if data.VeilLingerDamage == nil then
            data.VeilLingerDamage = 0
        elseif data.VeilLingerDamage > 0 then
            data.VeilLingerDamage = data.VeilLingerDamage - 1
            if game:GetFrameCount()%30 == 0 then
                for i = 0, game:GetNumPlayers() - 1 do
                    local player = Isaac.GetPlayer(i)
                    entity:TakeDamage(player.Damage * 0.2, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.LingeringDamage)