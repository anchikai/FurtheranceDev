local mod = further
local game = Game()
local rng = RNG()

function mod:GetPolydipsia(player, cacheFlag)
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) then
		if cacheFlag == CacheFlag.CACHE_RANGE then
			player.TearFallingSpeed = player.TearFallingSpeed + 20
            player.TearFallingAcceleration = player.TearFallingAcceleration + 1
		end
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = (player.MaxFireDelay * 2) + 10
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetPolydipsia)

function mod:PuddleBurst(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) then
			if entity.Type == EntityType.ENTITY_TEAR then
				local data = mod:GetData(player)
				tear = entity:ToTear()
				puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 0, entity.Position, Vector(0,0), player):ToEffect()
				puddle.CollisionDamage = player.Damage * 0.33
				puddle.Scale = 1.67
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, mod.PuddleBurst)

function mod:PolydipsiaKB(tear, collider)
	local player = tear.SpawnerEntity:ToPlayer()
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) then
		tear.KnockbackMultiplier = tear.KnockbackMultiplier * 2
	end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.PolydipsiaKB)

function mod:tearSize(tear)
    local player = tear.Parent:ToPlayer()
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) then
		tear.Scale = tear.Scale * 1.5
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.tearSize)