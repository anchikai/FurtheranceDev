local mod = Furtherance
local game = Game()
local rng = RNG()

normalPeter = Isaac.GetPlayerTypeByName("Peter", false)
taintedPeter = Isaac.GetPlayerTypeByName("PeterB", true)

COSTUME_PETER_A_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002_Peter_Drip.anm2")
COSTUME_PETER_B_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002b_Peter_Drip.anm2")

function mod:OnInit(player)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then -- If the player is Peter it will apply his drip
		player:AddNullCostume(COSTUME_PETER_A_DRIP)
		costumeEquipped = true
		player:AddTrinket(TrinketType.TRINKET_ALABASTER_SCRAP, true)
	elseif player:GetName() == "PeterB" then -- Apply different drip for his tainted variant
		player:AddNullCostume(COSTUME_PETER_B_DRIP)
		costumeEquipped = true
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:PeterUpdate(player)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then
		if player.FrameCount == 1 and data.Init then
			if not mod.isLoadingData then
				player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, ActiveSlot.SLOT_POCKET, false)
			end
		end
	elseif player:GetName() == "PeterB" then
		if player:GetSoulHearts() > 0 then
			player:AddSoulHearts(-player:GetSoulHearts())
		end
		if player.FrameCount < 10 and (not mod.isLoadingData and data.Init) then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_MUDDLED_CROSS, ActiveSlot.SLOT_POCKET, false)
		elseif player.FrameCount >= 10 and data.Init then
			data.Init = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.PeterUpdate)

function mod:PeterStats(player, flag)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then -- If the player is Peter it will apply his stats
		if flag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed - 0.25
		end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 17.39999961853
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage - 0.5
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + 20
		end
	elseif player:GetName() == "PeterB" then -- If the player is Tainted Peter it will apply his stats
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck - 1
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.PeterStats)

function mod:Hearts(entity, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		local data = mod:GetData(player)
		if player:GetName() == "PeterB" then -- Prevent Tainted Peter from obtaining Non-Red Health
			if entity.SubType == HeartSubType.HEART_SOUL or entity.SubType == HeartSubType.HEART_HALF_SOUL then
				return false
			elseif entity.SubType == HeartSubType.HEART_BLENDED then
				if player:GetHearts() < player:GetMaxHearts() + (player:GetBoneHearts() * 2) then
					entity:GetSprite():Play("Collect", true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
					SFXManager():Stop(SoundEffect.SOUND_HOLY, 1, 0, false)
					player:AddHearts(2)
				else
					return false
				end
			elseif entity.SubType == HeartSubType.HEART_BLACK then
				if player:GetActiveCharge(ActiveSlot.SLOT_POCKET) < 6 then
					entity:GetSprite():Play("Collect", true)
					entity:Die()
					if player:GetActiveCharge(ActiveSlot.SLOT_POCKET) == 5 then
						chargeAmount = 1
					else
						chargeAmount = 2
					end
					player:SetActiveCharge(player:GetActiveCharge(ActiveSlot.SLOT_POCKET) + chargeAmount, ActiveSlot.SLOT_POCKET)
					game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_POCKET)
					if player:GetActiveCharge(ActiveSlot.SLOT_POCKET) < 6 then
						SFXManager():Play(SoundEffect.SOUND_BEEP)
					else
						SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
						SFXManager():Play(SoundEffect.SOUND_ITEMRECHARGE)
					end
					SFXManager():Stop(SoundEffect.SOUND_UNHOLY, 1, 0, false)
				else
					return false
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.Hearts, PickupVariant.PICKUP_HEART)

function mod:MorphHeart(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:GetName() == "PeterB" then
			if mod.Flipped == true then
				if entity.SubType ~= HeartSubType.HEART_BLACK then
					local price = entity.Price
					entity:Morph(entity.Type, entity.Variant, HeartSubType.HEART_BLACK)
					entity.Price = price
				end
			elseif mod.Flipped == false then
				if entity.SubType == HeartSubType.HEART_SOUL or entity.SubType == HeartSubType.HEART_HALF_SOUL then
					local price = entity.Price
					entity:Morph(entity.Type, entity.Variant, HeartSubType.HEART_BLACK)
					entity.Price = price
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.MorphHeart, PickupVariant.PICKUP_HEART)

function mod:PeterQual(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetName() == "PeterB" then
			local itemConfig = Isaac.GetItemConfig()
			if mod.Flipped == false then
				if itemConfig:GetCollectible(entity.SubType).Quality > 2 and entity.SubType ~= CollectibleType.COLLECTIBLE_BIRTHRIGHT then
					local price = entity.Price
					entity:Morph(entity.Type, entity.Variant, 0, false, true, false)
					entity.Price = price
					return
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.PeterQual, PickupVariant.PICKUP_COLLECTIBLE)

function mod:BloodyTears(tear)
	local player = tear.Parent:ToPlayer()
	if player:GetName() == "PeterB" then
		if tear.Variant == TearVariant.BLUE then
			tear:ChangeVariant(TearVariant.BLOOD)
		elseif tear.Variant == TearVariant.CUPID_BLUE then
			tear:ChangeVariant(TearVariant.CUPID_BLOOD)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.BloodyTears)