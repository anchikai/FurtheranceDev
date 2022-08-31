local mod = Furtherance

local hahaFunnyBonk = Isaac.GetSoundIdByName("Bonk")
EffectVariant.COCONUT = Isaac.GetEntityVariantByName("Coconut")

function mod:GetCoconutMilk(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_COCONUT_MILK) then
        if flag == CacheFlag.CACHE_FIREDELAY then
            player.MaxFireDelay = player.MaxFireDelay * 3
        end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 2
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetCoconutMilk)

function mod:TearStuff(tear)
    local player = mod:GetPlayerFromTear(tear)
    if player then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_COCONUT_MILK) then
            tear.Scale = tear.Scale * 2
            tear:SetColor(Color(1.5, 2, 2, 1, 0, 0, 0), 0, 0, false, false)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.TearStuff)

local SelectedEnemy
function mod:SpawnCoconut(tear, collider)
    local player = mod:GetPlayerFromTear(tear)
    if player then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_COCONUT_MILK) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_COCONUT_MILK)
            if (player.Luck <= 0 and rng:RandomFloat() <= 0.01)
            or (rng:RandomFloat() <= player.Luck/10) then
                SelectedEnemy = collider
                local Coconut = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.COCONUT, 0, SelectedEnemy.Position, Vector.Zero, player):GetSprite()
                Coconut:Play("Coconut", true)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.SpawnCoconut)

function mod:Bonk(Coconut)
    local sprite = Coconut:GetSprite()
    Coconut.Position = SelectedEnemy.Position
    if sprite:IsFinished("Coconut") then
        Coconut:Remove()
        SelectedEnemy:TakeDamage(10, 0, EntityRef(nil), 0)
        SFXManager():Play(hahaFunnyBonk)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.Bonk, EffectVariant.COCONUT)