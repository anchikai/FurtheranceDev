local mod = further

function mod:HeartsToCoins(entity, collider)
	local heartCounter = {
		[HeartSubType.HEART_FULL] = 2,
		[HeartSubType.HEART_SCARED] = 2,
		[HeartSubType.HEART_DOUBLEPACK] = 4,
		[HeartSubType.HEART_HALF] = 1,
		[HeartSubType.HEART_BLENDED] = 2,
	}
	if RepentancePlusMod then
		heartCounter[CustomPickups.TaintedHearts.HEART_HOARDED] = 8
	end
	if collider.Type == EntityType.ENTITY_PLAYER then
		local collider = collider:ToPlayer()
		local data = mod:GetData(collider)
		if collider:HasCollectible(CollectibleType.COLLECTIBLE_HEART_EMBEDDED_COIN) then
			if collider:GetNumCoins() < 99 and entity:IsShopItem() == false and collider:HasCollectible(CollectibleType.COLLECTIBLE_DEEP_POCKETS) == false then
				for subtype, amount in pairs (heartCounter) do
					if entity.SubType == subtype then
						local emptyHearts = collider:GetEffectiveMaxHearts() - collider:GetHearts()
						local fullHearts = collider:GetHearts() + collider:GetSoulHearts() + collider:GetBrokenHearts() * 2
						if emptyHearts <= amount then
							if subtype ~= HeartSubType.HEART_BLENDED then
								collider:AddCoins(amount - emptyHearts)
							else
								if fullHearts == 24 then
									collider:AddCoins(2)
								elseif fullHearts == 23 then
									collider:AddCoins(1)
								end
							end
							if not collider:CanPickRedHearts() then
								entity:GetSprite():Play("Collect",true)
								entity:Die()
								SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
							elseif collider:CanPickRedHearts() and RepentancePlusMod then
								if entity.SubType == CustomPickups.TaintedHearts.HEART_HOARDED then
									entity:GetSprite():Play("Collect",true)
									entity:Die()
									SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
									collider:AddCoins(emptyHearts)
								end
							end
						end
					end
				end
			elseif collider:GetNumCoins() < 999 and entity:IsShopItem() == false and collider:HasCollectible(CollectibleType.COLLECTIBLE_DEEP_POCKETS) then
				for subtype, amount in pairs (heartCounter) do
					if entity.SubType == subtype then
						local emptyHearts = collider:GetEffectiveMaxHearts() - collider:GetHearts()
						local fullHearts = collider:GetHearts() + collider:GetSoulHearts() + collider:GetBrokenHearts() * 2
						if emptyHearts <= amount then
							if subtype ~= HeartSubType.HEART_BLENDED then
								collider:AddCoins(amount - emptyHearts)
							else
								if fullHearts == 24 then
									collider:AddCoins(2)
								elseif fullHearts == 23 then
									collider:AddCoins(1)
								end
							end
							if not collider:CanPickRedHearts() then
								entity:GetSprite():Play("Collect",true)
								entity:Die()
								SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
							elseif collider:CanPickRedHearts() and RepentancePlusMod then
								if entity.SubType == CustomPickups.TaintedHearts.HEART_HOARDED then
									entity:GetSprite():Play("Collect",true)
									entity:Die()
									SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
									collider:AddCoins(emptyHearts)
								end
							end
						end
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.HeartsToCoins, PickupVariant.PICKUP_HEART)