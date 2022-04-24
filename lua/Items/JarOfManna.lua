local mod = Furtherance
local game = Game()

MannaOrb = Isaac.GetEntityVariantByName("Manna Orb")

function mod:UseMannaJar(_, _, player)
	local room = game:GetRoom()
	local roomType = room:GetType()
	local level = game:GetLevel()
	
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseMannaJar, CollectibleType.COLLECTIBLE_JAR_OF_MANNA)

function mod:SpawnMana(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_JAR_OF_MANNA) then
			manna = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ENEMY_SOUL, 2, entity.Position, Vector.Zero, player):ToEffect()
			manna.Timeout = 1
			manna.LifeSpan = 1
			data.MannaTimer = 60
			print("fart")
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.SpawnMana)

function mod:MannaEffect(effect)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if data.MannaCount == nil then
			data.MannaCount = 0
		end
		if data.MannaTimer == nil or data.MannaTimer < 0 then
			data.MannaTimer = 0

		elseif data.MannaTimer > 0 then
			data.MannaTimer = data.MannaTimer - 1
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.MannaEffect, MannaOrb)

function mod:MannaCollide(entity, collider)
	for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_JAR_OF_MANNA) then
			if collider.Type == EntityType.ENTITY_PLAYER then
				if entity.Variant == MannaOrb then
					entity:Remove()
					data.MannaCount = data.MannaCount + 1
				end
			end
			print(data.MannaCount)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.MannaCollide)