local mod = Furtherance
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

function mod:PuddleMagik(player)
	local data = mod:GetData(player)
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) or player:GetName() == "Miriam" then
		for i, entity in ipairs(Isaac.GetRoomEntities()) do
			if entity.Type == EntityType.ENTITY_TEAR then
				if entity:IsDead() then
					local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 1, entity.Position, Vector.Zero, player):ToEffect()
					if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) and player:GetName() == "Miriam" then
						if entity.SubType == 0 then
							PolyMiriam = player:FireTear(entity.Position, entity.Velocity, true, true, false, entity, 1)
							PolyMiriam.SubType = 1
						end
					end
					puddle.CollisionDamage = player.Damage * 0.33
					if player:GetName() == "Miriam" then
						if data.MiriamTearCount > 11 then
							puddle.Scale = 1.75
						else
							puddle.Scale = data.MiriamAOE
						end
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.PuddleMagik)

function mod:polydipsiaTear(tear)
    local player = tear.Parent:ToPlayer()
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)) or player:GetName() == "Miriam" then
		tear.Scale = tear.Scale * 1.4
		tear:AddTearFlags(TearFlags.TEAR_KNOCKBACK)
		tear:SetKnockbackMultiplier(tear.KnockbackMultiplier*2)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.polydipsiaTear)