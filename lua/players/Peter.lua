local mod = Furtherance
local game = Game()
local rng = RNG()

COSTUME_PETER_A_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002_Peter_Drip.anm2")
COSTUME_PETER_B_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002b_Peter_Drip.anm2")

function mod:OnInit(player)
	local data = mod:GetData(player)
	if player:GetPlayerType() == PeterA then -- If the player is Peter it will apply his drip
		player:AddNullCostume(COSTUME_PETER_A_DRIP)
		player:AddTrinket(TrinketType.TRINKET_ALABASTER_SCRAP, true)
	elseif player:GetPlayerType() == PeterB then -- Apply different drip for his tainted variant
		player:AddNullCostume(COSTUME_PETER_B_DRIP)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:PeterUpdate(player)
	local data = mod:GetData(player)
	if player:GetPlayerType() == PeterA then
		if player.FrameCount == 1 and data.Init then
			if not mod.isLoadingData then
				player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, ActiveSlot.SLOT_POCKET, false)
			end
		end
	elseif player:GetPlayerType() == PeterB then
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
	if player:GetPlayerType() == PeterA then
		if flag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed - 0.25
		end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 8.69999981
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage - 0.5
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + 20
		end
	elseif player:GetPlayerType() == PeterB then
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
		if player:GetPlayerType() == PeterB then -- Prevent Tainted Peter from obtaining Non-Red Health
			if entity.SubType == HeartSubType.HEART_SOUL or entity.SubType == HeartSubType.HEART_HALF_SOUL or entity.SubType == HeartSubType.HEART_BLACK then
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
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.Hearts, PickupVariant.PICKUP_HEART)

function mod:PeterQual(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == PeterB then
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
	if player:GetPlayerType() == PeterB then
		if tear.Variant == TearVariant.BLUE then
			tear:ChangeVariant(TearVariant.BLOOD)
		elseif tear.Variant == TearVariant.CUPID_BLUE then
			tear:ChangeVariant(TearVariant.CUPID_BLOOD)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.BloodyTears)



function mod:TaintedPeterHome()
	local level = game:GetLevel()
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == PeterA and level:GetCurrentRoomIndex() == 94 and level:GetStage() == LevelStage.STAGE8 and mod.Unlocks.Peter.Tainted ~= true then
			local RememberPocket = player:GetActiveCharge(ActiveSlot.SLOT_POCKET)
			for _, entity in ipairs(Isaac.GetRoomEntities()) do
				if (((entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE)
				or (entity.Type == EntityType.ENTITY_SHOPKEEPER)) and room:IsFirstVisit())
				or (entity.Type == EntityType.ENTITY_SLOT and entity.Variant == 14) then
					entity:Remove()
					player:ChangePlayerType(PeterB)
					Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, entity.Position, Vector.Zero, nil)
					player:ChangePlayerType(PeterA)
					player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, ActiveSlot.SLOT_POCKET, false)
					player:SetActiveCharge(RememberPocket, ActiveSlot.SLOT_POCKET)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.TaintedPeterHome)

function mod:UnlockTaintedPeter(player)
	if player:GetPlayerType() ~= PeterA or mod.Unlocks.Peter.Tainted then return end

	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, 14)) do
		local sprite = entity:GetSprite()
		if sprite:IsFinished("PayPrize") then
			mod.Unlocks.Peter.Tainted = true
			GiantBookAPI.ShowAchievement("achievement_taintedpeter.png")
			for _, poof in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.POOF01)) do
				poof:Remove()
			end
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.UnlockTaintedPeter)

function mod:ResetTaintedUnlock(cmd)
	if string.lower(cmd) == "resetpeter" then
		mod.Unlocks.Peter.MomsHeart = false
		mod.Unlocks.Peter.Isaac = false
		mod.Unlocks.Peter.Satan = false
		mod.Unlocks.Peter.BlueBaby = false
		mod.Unlocks.Peter.Lamb = false
		mod.Unlocks.Peter.BossRush = false
		mod.Unlocks.Peter.Hush = false
		mod.Unlocks.Peter.MegaSatan = false
		mod.Unlocks.Peter.Delirium = false
		mod.Unlocks.Peter.Mother = false
		mod.Unlocks.Peter.Beast = false
		mod.Unlocks.Peter.GreedMode = false
		mod.Unlocks.Peter.Tainted = false
		mod.Unlocks.Peter.FullCompletion = false
		print("Peter has been reset.")
	end
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.ResetTaintedUnlock)