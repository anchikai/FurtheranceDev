local mod = further
local game = Game()
local rng = RNG()

function mod:GetPolydipsia(player, cacheFlag)
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) or player:GetName() == "Miriam" then
		if cacheFlag == CacheFlag.CACHE_RANGE then
			player.TearFallingSpeed = player.TearFallingSpeed + 20
            player.TearFallingAcceleration = player.TearFallingAcceleration + 1
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			if player:GetName() ~= "Miriam" then
				player.MaxFireDelay = (player.MaxFireDelay * 2) + 10
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetPolydipsia)

function mod:PuddleBurst(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) or player:GetName() == "Miriam" then
			if entity.Type == EntityType.ENTITY_TEAR then
				local data = mod:GetData(player)
				local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, entity.Position, Vector(0,0), player):ToEffect()
				puddle.CollisionDamage = player.Damage * 0.33
				if data.MiriamTearCount == 5 then
					puddle.Scale = 2.25
				else
					puddle.Scale = 1.67
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, mod.PuddleBurst)

function mod:polydipsiaTear(tear)
    local player = tear.Parent:ToPlayer()
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) or player:GetName() == "Miriam" then
		tear.Scale = tear.Scale * 1.4
		tear:AddTearFlags(TearFlags.TEAR_KNOCKBACK)
		tear:SetKnockbackMultiplier(tear.KnockbackMultiplier*25)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.polydipsiaTear)