local mod = Furtherance
local game = Game()

MannaOrb = Isaac.GetEntityVariantByName("Manna Orb")

function mod:UseMannaJar(_, _, player)
	local data = mod:GetData(player)
	data.MannaCount = 0
	local bombs = player:GetNumBombs()
	local keys = player:GetNumKeys()
	local coins = player:GetNumCoins()
	-- If the
	if (coins == bombs) and (coins == keys) then -- Player has the same amount of coins, bombs & keys
		-- TODO: add a proper handler here
		print("well what the fuck")

	elseif (coins < bombs) and (coins < keys) then -- Player has the least amount of coins
		player:AddCoins(1)

	elseif (bombs <= coins) and (bombs <= keys) then -- Player has the least amount of bombs; coins or keys can be equal
		player:AddBombs(1)

	elseif (keys <= coins) and (keys < bombs) then -- Player has the least amount of keys; coins can be equal
		player:AddKeys(1)

	end
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseMannaJar, CollectibleType.COLLECTIBLE_JAR_OF_MANNA)

function mod:SpawnMana(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_JAR_OF_MANNA) then
			--[[manna = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ENEMY_SOUL, 2, entity.Position, Vector.Zero, player):ToEffect()
			manna.Timeout = 1
			manna.LifeSpan = 1
			data.MannaTimer = 60]]
			if data.MannaCount < 21 then
				data.MannaCount = data.MannaCount + 1
			end
			if data.MannaCount == 20 then
				if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_JAR_OF_MANNA then
					player:SetActiveCharge(1, ActiveSlot.SLOT_PRIMARY)
					game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_PRIMARY)
				elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_JAR_OF_MANNA then
					player:SetActiveCharge(1, ActiveSlot.SLOT_SECONDARY)
					game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_SECONDARY)
				end
				SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
				SFXManager():Play(SoundEffect.SOUND_ITEMRECHARGE)
			end
			print(data.MannaCount)
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
