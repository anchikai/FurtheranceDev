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
		player:AddCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, 6, true, ActiveSlot.SLOT_PRIMARY)
		player:SetActiveCharge(12, ActiveSlot.SLOT_PRIMARY)
	elseif player:GetName() == "PeterB" then -- Apply different drip for his tainted variant
		player:AddNullCostume(COSTUME_PETER_B_DRIP)
		costumeEquipped = true
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:PeterUpdate(player)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then

	elseif player:GetName() == "PeterB" then
		if player:GetSoulHearts() > 0 then
			player:AddSoulHearts(-player:GetSoulHearts())
		end
		if player.FrameCount < 10 and (not mod.isLoadingData and data.Init) then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_FLIPPED_CROSS, ActiveSlot.SLOT_POCKET, false)
		elseif player.FrameCount >= 10 and data.Init then
			data.Init = nil
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.PeterUpdate)

function mod:PeterStats(player, flag)
	local data = mod:GetData(player)
	if data.DevilCount == nil then
		data.DevilCount = 0
	end
	if data.AngelCount == nil then
		data.AngelCount = 0
	end
	if player:GetName() == "Peter" then -- If the player is Peter it will apply his stats
		if flag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + 0.1
		end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - 3
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 0.5 + 1.25
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - 110
		end
		if flag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.15
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false then
			if data.AngelCount > data.DevilCount then -- Peter's stat modifiers for when he has more Angel Rooms
				if flag == CacheFlag.CACHE_FLYING then
					player.CanFly = true
				end
				if flag == CacheFlag.CACHE_SPEED then
					player.MoveSpeed = player.MoveSpeed + data.AngelCount * 0.1
				end
				if flag == CacheFlag.CACHE_FIREDELAY then
					player.MaxFireDelay = player.MaxFireDelay - data.AngelCount * (player.MaxFireDelay * 0.1)
					if player.MaxFireDelay < 1 then
						player.MaxFireDelay = 1
					end
				end
				if flag == CacheFlag.CACHE_SHOTSPEED then
					player.ShotSpeed = player.ShotSpeed - data.AngelCount * 0.1
				end
			elseif data.DevilCount > data.AngelCount then -- Peter's stat modifiers for when he has more Devil Rooms
				if flag == CacheFlag.CACHE_SPEED then
					player.MoveSpeed = player.MoveSpeed - data.DevilCount * 0.1
				end
				if flag == CacheFlag.CACHE_DAMAGE then
					player.Damage = player.Damage + data.DevilCount * 1.25
				end
				if flag == CacheFlag.CACHE_RANGE then
					player.TearRange = player.TearRange + data.DevilCount * 40
				end
			end
		else
			if data.AngelCount > 0 then
				if flag == CacheFlag.CACHE_FLYING then
					player.CanFly = true
				end
			end
			if flag == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed + data.AngelCount * 0.1
			end
			if flag == CacheFlag.CACHE_FIREDELAY then
				player.MaxFireDelay = player.MaxFireDelay - data.AngelCount * (player.MaxFireDelay * 0.1)
				if player.MaxFireDelay < 0 then
					player.MaxFireDelay = 0
				end
			end
			if flag == CacheFlag.CACHE_SHOTSPEED then
				player.ShotSpeed = player.ShotSpeed - data.AngelCount * 0.1
			end
			if flag == CacheFlag.CACHE_SPEED then
				player.MoveSpeed = player.MoveSpeed - data.DevilCount * 0.1
			end
			if flag == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + data.DevilCount * 1.25
			end
			if flag == CacheFlag.CACHE_RANGE then
				player.TearRange = player.TearRange + data.DevilCount * 40
			end
		end
	elseif player:GetName() == "PeterB" then -- If the player is Tainted Peter it will apply his stats
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck - 1
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.PeterStats)

function mod:PeterCostumes(player)
	local nailConfig = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_THE_NAIL)
	local revelationConfig = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_REVELATION)
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false then -- No birthright
		if data.AngelCount > data.DevilCount then -- Angel Costume
			if player:HasCollectible(CollectibleType.COLLECTIBLE_REVELATION) == false then
				if not data.AngelCostume then
					data.AngelCostume = 0
				end

				while data.AngelCount > data.AngelCostume do
					player:AddCostume(revelationConfig, false)
					data.AngelCostume = data.AngelCostume + 1
				end
				while data.AngelCount < data.AngelCostume do
					data.AngelCostume = data.AngelCostume - 1
					if data.AngelCostume <= 0 then
						player:TryRemoveCollectibleCostume(CollectibleType.COLLECTIBLE_REVELATION, true)
					end
				end
			end
		elseif data.DevilCount > data.AngelCount then -- Devil Costume
			if player:HasCollectible(CollectibleType.COLLECTIBLE_THE_NAIL) == false then
				if not data.DevilCostume then
					data.DevilCostume = 0
				end

				while data.DevilCount > data.DevilCostume do
					player:AddCostume(nailConfig, false)
					data.DevilCostume = data.DevilCostume + 1
				end
				while data.DevilCount < data.DevilCostume do
					data.DevilCostume = data.DevilCostume - 1
					if data.DevilCostume <= 0 then
						player:TryRemoveCollectibleCostume(CollectibleType.COLLECTIBLE_THE_NAIL, true)
					end
				end
			end
		elseif data.DevilCount == data.AngelCount then -- Remove Costumes
			player:TryRemoveCollectibleCostume(CollectibleType.COLLECTIBLE_THE_NAIL, true)
			player:TryRemoveCollectibleCostume(CollectibleType.COLLECTIBLE_REVELATION, true)
		end
	else -- Birthright
		if player:HasCollectible(CollectibleType.COLLECTIBLE_REVELATION) == false then
			if not data.AngelCostume then
				data.AngelCostume = 0
			end

			while data.AngelCount > data.AngelCostume do
				player:AddCostume(revelationConfig, false)
				data.AngelCostume = data.AngelCostume + 1
			end
			while data.AngelCount < data.AngelCostume do
				data.AngelCostume = data.AngelCostume - 1
				if data.AngelCostume <= 0 then
					player:TryRemoveCollectibleCostume(CollectibleType.COLLECTIBLE_REVELATION, true)
				end
			end
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_THE_NAIL) == false then
			if not data.DevilCostume then
				data.DevilCostume = 0
			end

			while data.DevilCount > data.DevilCostume do
				player:AddCostume(nailConfig, false)
				data.DevilCostume = data.DevilCostume + 1
			end
			while data.DevilCount < data.DevilCostume do
				data.DevilCostume = data.DevilCostume - 1
				if data.DevilCostume <= 0 then
					player:TryRemoveCollectibleCostume(CollectibleType.COLLECTIBLE_THE_NAIL, true)
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.PeterCostumes, normalPeter)

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
					entity:Morph(entity.Type, entity.Variant, HeartSubType.HEART_BLACK)
				end
			elseif mod.Flipped == false then
				if entity.SubType == HeartSubType.HEART_SOUL or entity.SubType == HeartSubType.HEART_HALF_SOUL then
					entity:Morph(entity.Type, entity.Variant, HeartSubType.HEART_BLACK)
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.MorphHeart, PickupVariant.PICKUP_HEART)

function mod:AngelDevil()
	local room = game:GetRoom()
	local roomType = room:GetType()
	local level = game:GetLevel()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:GetName() == "Peter" then
			data.DevilCount = data.DevilCount and data.DevilCount or 0
			data.AngelCount = data.AngelCount and data.AngelCount or 0
			if roomType == RoomType.ROOM_DEVIL and room:IsFirstVisit() then
				data.DevilCount = data.DevilCount + 1
			end
			if roomType == RoomType.ROOM_ANGEL and room:IsFirstVisit() then
				data.AngelCount = data.AngelCount + 1
			end
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false then
				if data.DevilCount > data.AngelCount then
					player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_LEO, false)
				end
			else
				if data.DevilCount > 0 then
					player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_LEO, false)
				end
			end
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_RANGE)
			player:AddCacheFlags(CacheFlag.CACHE_SHOTSPEED)
			player:AddCacheFlags(CacheFlag.CACHE_FLYING)
			player:EvaluateItems()
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.AngelDevil)

function mod:PeterQual(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetName() == "PeterB" then
			local itemConfig = Isaac.GetItemConfig()
			if mod.Flipped == false then
				if itemConfig:GetCollectible(entity.SubType).Quality > 2 and entity.SubType ~= CollectibleType.COLLECTIBLE_BIRTHRIGHT then
					entity:Morph(entity.Type, entity.Variant, 0, false, true, false)
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
		tear:ChangeVariant(TearVariant.BLOOD)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.BloodyTears)

function mod:shouldDeHook()
	local reqs = {
		not game:GetHUD():IsVisible(),
		game:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)
	}
	return reqs[1] or reqs[2]
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function() -- Peter's Devil/Angel indicator
	if mod:shouldDeHook() then return end
	local offset = Options.HUDOffset * Vector(20, 12)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:GetName() == "Peter" then
			local f = Font()
			f:Load("font/luaminioutlined.fnt")
			if game:GetNumPlayers() == 1 then
				coopOffset = 0
			else
				coopOffset = 12
			end
			f:DrawString(data.DevilCount, 44 + offset.X, 161 + offset.Y + coopOffset, KColor(1, 1, 1, 0.4, 0, 0, 0), 0, true)
			f:DrawString(data.AngelCount, 44 + offset.X, 173 + offset.Y + coopOffset * 1.2, KColor(1, 1, 1, 0.4, 0, 0, 0), 0, true)
		end
	end
end
)
