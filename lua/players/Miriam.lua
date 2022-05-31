local mod = Furtherance
local game = Game()
local rng = RNG()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

COSTUME_MIRIAM_A_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_003_Miriam_Hair.anm2")
COSTUME_MIRIAM_B_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_003b_Miriam_Hair.anm2")

function mod:OnInit(player)
	local data = mod:GetData(player)
	data.Init = true
	if player:GetPlayerType() == MiriamA then -- If the player is Miriam it will apply her hair
		player:AddNullCostume(COSTUME_MIRIAM_A_HAIR)
		data.MiriamTearCount = 0
		data.MiriamRiftTimeout = 0
		data.MiriamAOE = 1
		player:AddCollectible(CollectibleType.COLLECTIBLE_TAMBOURINE, 0, true, ActiveSlot.SLOT_PRIMARY, 0)
	elseif player:GetPlayerType() == MiriamB then -- Apply different hair for her tainted variant
		player:AddNullCostume(COSTUME_MIRIAM_B_HAIR)
		player:AddBoneHearts(2)
		player:AddHearts(4)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:OnUpdate(player)
	local data = mod:GetData(player)
	if player:GetPlayerType() == MiriamA then
		if data.MiriamRiftTimeout > -1 then
			data.MiriamRiftTimeout = data.MiriamRiftTimeout - 1
		end
		if data.MiriamRiftTimeout == 0 then
			for i, entity in ipairs(Isaac.GetRoomEntities()) do
				if entity.Type == EntityType.ENTITY_EFFECT and entity.Variant == EffectVariant.RIFT then
					entity:Die()
				end
			end
		end
	elseif player:GetPlayerType() == MiriamB then
		if player.FrameCount == 1 and data.Init and not mod.isLoadingData then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_POLARITY_SHIFT, ActiveSlot.SLOT_POCKET, false)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnUpdate)

function mod:PuddleRift(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:GetPlayerType() == MiriamA then
			if entity.Type == EntityType.ENTITY_TEAR then
				local data = mod:GetData(player)
				if data.MiriamTearCount == 12 then
					local rift = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RIFT, 0, entity.Position, Vector.Zero, player):ToEffect()
					local sprite = rift:GetSprite()
					sprite.Scale = Vector.Zero
					data.MiriamRiftTimeout = 90
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, mod.PuddleRift)

function mod:tearCounter(tear)
	local player = tear.Parent:ToPlayer()
	local data = mod:GetData(player)
	if player:GetPlayerType() == MiriamA then
		if data.MiriamTearCount > 11 then
			data.MiriamTearCount = 0
		end
		data.MiriamTearCount = data.MiriamTearCount + 1
	end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.tearCounter)

function mod:miriamStats(player, flag)
	local data = mod:GetData(player)
	if player:GetPlayerType() == MiriamA then -- If the player is Miriam it will apply her stats
		if flag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + 0.25
		end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 17.39999961853
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - 60
			if player.TearRange ~= 200 then
				if player.TearRange <= 160 then
					data.MiriamAOE = 0.75
				elseif player.TearRange > 160 and player.TearRange <= 640 then
					data.MiriamAOE = 1
				elseif player.TearRange > 640 then
					data.MiriamAOE = 1.5
				end
				player.TearRange = 200
			end
		end
	elseif player:GetPlayerType() == MiriamB then -- If the player is Tainted Miriam it will apply her stats
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck - 2
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.miriamStats)

function mod:ClickerFix(_, _, player)
	if player:GetPlayerType() == MiriamA then
		player:TryRemoveNullCostume(COSTUME_MIRIAM_A_HAIR)
		player:AddNullCostume(COSTUME_MIRIAM_A_HAIR)
	elseif player:GetPlayerType() == MiriamB then
		player:TryRemoveNullCostume(COSTUME_MIRIAM_B_HAIR)
		player:AddNullCostume(COSTUME_MIRIAM_B_HAIR)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_CLICKER)
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_SHIFT_KEY)



function mod:TaintedMiriamHome()
	local level = game:GetLevel()
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == MiriamA and level:GetCurrentRoomIndex() == 94 and level:GetStage() == LevelStage.STAGE8 and mod.Unlocks.Miriam.Tainted ~= true  then
			for _, entity in ipairs(Isaac.GetRoomEntities()) do
				if (((entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE)
				or (entity.Type == EntityType.ENTITY_SHOPKEEPER)) and room:IsFirstVisit())
				or (entity.Type == EntityType.ENTITY_SLOT and entity.Variant == 14) then
					entity:Remove()
					player:ChangePlayerType(MiriamB)
					Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, entity.Position, Vector.Zero, nil)
					player:ChangePlayerType(MiriamA)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.TaintedMiriamHome)

function mod:UnlockTaintedMiriam(player)
	if player:GetPlayerType() ~= MiriamA or mod.Unlocks.Miriam.Tainted then return end

	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, 14)) do
		local sprite = entity:GetSprite()
		if sprite:IsFinished("PayPrize") then
			mod.Unlocks.Miriam.Tainted = true
			GiantBookAPI.ShowAchievement("achievement_taintedmiriam.png")
			for _, poof in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.POOF01)) do
				poof:Remove()
			end
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.UnlockTaintedMiriam)

function mod:ResetTaintedUnlock(cmd)
	if string.lower(cmd) == "resetmiriam" then
		mod.Unlocks.Miriam.MomsHeart = false
		mod.Unlocks.Miriam.Isaac = false
		mod.Unlocks.Miriam.Satan = false
		mod.Unlocks.Miriam.BlueBaby = false
		mod.Unlocks.Miriam.Lamb = false
		mod.Unlocks.Miriam.BossRush = false
		mod.Unlocks.Miriam.Hush = false
		mod.Unlocks.Miriam.MegaSatan = false
		mod.Unlocks.Miriam.Delirium = false
		mod.Unlocks.Miriam.Mother = false
		mod.Unlocks.Miriam.Beast = false
		mod.Unlocks.Miriam.GreedMode = false
		mod.Unlocks.Miriam.Tainted = false
		mod.Unlocks.Miriam.FullCompletion = false
		print("Miriam has been reset.")
	end
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.ResetTaintedUnlock)