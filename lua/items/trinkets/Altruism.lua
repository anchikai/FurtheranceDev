local mod = Furtherance
local game = Game()

function mod:Donate(player, collider)
	local rng = player:GetTrinketRNG(TrinketType.TRINKET_ALTRUISM)
	if player:HasTrinket(TrinketType.TRINKET_ALTRUISM, false) and collider.Type == EntityType.ENTITY_SLOT and rng:RandomFloat() <= 0.25 then
		if player:GetNumCoins() > 0 and (collider.Variant == 4 or collider.Variant == 6 or collider.Variant == 13 or collider.Variant == 18) then -- Coin Beggars
			local sprite = collider:GetSprite()
			if (sprite:IsPlaying("PayNothing") or sprite:IsPlaying("PayShuffle")) and sprite:GetFrame() == 1 then
				if rng:RandomFloat() <= 0.5 then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
            		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
					player:AddHearts(1)
				else
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, Isaac.GetFreeNearPosition(collider.Position, 40), Vector.Zero, collider)
				end
			end
		end
		if player:GetNumBombs() > 0 and collider.Variant == 9 then -- Bomb Beggars
			local sprite = collider:GetSprite()
			if (sprite:IsPlaying("PayNothing") or sprite:IsPlaying("PayShuffle")) and sprite:GetFrame() == 1 then
				if rng:RandomFloat() <= 0.5 then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
            		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
					player:AddHearts(1)
				else
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BOMB, BombSubType.BOMB_NORMAL, Isaac.GetFreeNearPosition(collider.Position, 40), Vector.Zero, collider)
				end
			end
		end
		if player:GetNumKeys() > 0 and collider.Variant == 7 then -- Key Beggars
			local sprite = collider:GetSprite()
			if (sprite:IsPlaying("PayNothing") or sprite:IsPlaying("PayShuffle")) and sprite:GetFrame() == 1 then
				if rng:RandomFloat() <= 0.5 then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
            		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
					player:AddHearts(1)
				else
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL, Isaac.GetFreeNearPosition(collider.Position, 40), Vector.Zero, collider)
				end
			end
		end
		if player:GetNumKeys() > 0 and (collider.Variant == 5 or collider.Variant == 15) then -- Health Beggars
			local sprite = collider:GetSprite()
			if (sprite:IsPlaying("PayNothing") or sprite:IsPlaying("PayShuffle")) and sprite:GetFrame() == 1 then
				if rng:RandomFloat() <= 0.5 then
					SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
            		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
					player:AddHearts(1)
				else
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF_SOUL, Isaac.GetFreeNearPosition(collider.Position, 40), Vector.Zero, collider)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, mod.Donate)