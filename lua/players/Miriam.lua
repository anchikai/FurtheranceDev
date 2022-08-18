local mod = Furtherance
local game = Game()

mod:SavePlayerData({
	MiriamTearCount = 0,
})

COSTUME_MIRIAM_A_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_003_Miriam_Hair.anm2")
COSTUME_MIRIAM_B_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_003b_Miriam_Hair.anm2")

function mod:OnInit(player)
	local data = mod:GetData(player)
	data.Init = true
	if player:GetPlayerType() == PlayerType.PLAYER_MIRIAM then
		data.MiriamAOE = 1
		data.oldNumBirthrights = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	end

	if player:GetPlayerType() == PlayerType.PLAYER_MIRIAM then -- If the player is Miriam it will apply her hair
		data.MiriamTearCount = 0
		player:AddNullCostume(COSTUME_MIRIAM_A_HAIR)
	elseif player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B then -- Apply different hair for her tainted variant
		player:AddBoneHearts(2)
		player:AddMaxHearts(-2, true)
		player:AddHearts(4)
		player:AddNullCostume(COSTUME_MIRIAM_B_HAIR)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:GiveMiriamItems(player)
	local data = mod:GetData(player)
	if not data.Init then return end

	if player:GetPlayerType() == PlayerType.PLAYER_MIRIAM then
		if player.FrameCount == 1 and not mod.IsContinued then
			player:AddCollectible(CollectibleType.COLLECTIBLE_TAMBOURINE, 0, true, ActiveSlot.SLOT_PRIMARY, 0)
		elseif player.FrameCount > 1 then
			data.Init = nil
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B then
		if player.FrameCount == 1 and not mod.IsContinued then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_POLARITY_SHIFT, ActiveSlot.SLOT_POCKET, false)
		elseif player.FrameCount > 1 then
			data.Init = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.GiveMiriamItems)

function mod:PuddleRift(tear)
	local data = mod:GetData(tear)
	if data.MiriamPullEnemies then
		local rift = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RIFT, 1, tear.Position, Vector.Zero, player):ToEffect()
		rift.SpriteScale = Vector.Zero
		mod:DelayFunction(rift.Die, 60, {rift}, true)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, mod.PuddleRift, EntityType.ENTITY_TEAR)

function mod:tearCounter(tear)
	local player = tear.Parent and tear.Parent:ToPlayer()
	if player == nil then return end

	if player:GetPlayerType() == PlayerType.PLAYER_MIRIAM then
		local playerData = mod:GetData(player)
		if playerData.MiriamTearCount == nil then
			playerData.MiriamTearCount = 0
		end
		playerData.MiriamTearCount = (playerData.MiriamTearCount + 1) % 12

		if playerData.MiriamTearCount == 0 then
			local data = mod:GetData(tear)
			data.MiriamPullEnemies = true
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.tearCounter)

function mod:Birthright(tear, collider)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player and player:GetPlayerType() == PlayerType.PLAYER_MIRIAM and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		local entities = Isaac.FindInRadius(player.Position, 40, EntityPartition.ENEMY)
		if #entities > 0 then
			tear:AddTearFlags(TearFlags.TEAR_KNOCKBACK)
			tear:SetKnockbackMultiplier(tear.KnockbackMultiplier*5)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.Birthright)

function mod:miriamStats(player, flag)
	local data = mod:GetData(player)
	if player:GetPlayerType() == PlayerType.PLAYER_MIRIAM then -- If the player is Miriam it will apply her stats
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
				if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
					if data.oldNumBirthrights == nil then
						data.oldNumBirthrights = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
					end
					data.MiriamAOE = data.MiriamAOE * 1.25 ^ data.oldNumBirthrights
				end
				player.TearRange = 200
			end
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B then -- If the player is Tainted Miriam it will apply her stats
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck - 2
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.miriamStats)

function mod:UpdateBirthrightStatus(player)
	if player:GetPlayerType() ~= PlayerType.PLAYER_MIRIAM then return end

	
	local data = mod:GetData(player)
	local numBirthrights = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
	if data.oldNumBirthrights == nil then
		data.oldNumBirthrights = numBirthrights
	end
	if numBirthrights == data.oldNumBirthrights then return end
	data.MiriamAOE = data.MiriamAOE * 1.25 ^ (numBirthrights - data.oldNumBirthrights)
	data.oldNumBirthrights = numBirthrights
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.UpdateBirthrightStatus)

function mod:ClickerFix(_, _, player)
	player:TryRemoveNullCostume(COSTUME_MIRIAM_A_HAIR)
	player:TryRemoveNullCostume(COSTUME_MIRIAM_B_HAIR)
	if player:GetPlayerType() == PlayerType.PLAYER_MIRIAM then
		player:AddNullCostume(COSTUME_MIRIAM_A_HAIR)
	elseif player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B then
		player:AddNullCostume(COSTUME_MIRIAM_B_HAIR)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_CLICKER)



function mod:TaintedMiriamHome()
	local level = game:GetLevel()
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == PlayerType.PLAYER_MIRIAM and level:GetCurrentRoomIndex() == 94 and level:GetStage() == LevelStage.STAGE8 and mod.Unlocks.Miriam.Tainted ~= true  then
			for _, entity in ipairs(Isaac.GetRoomEntities()) do
				if (((entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE)
				or (entity.Type == EntityType.ENTITY_SHOPKEEPER)) and room:IsFirstVisit())
				or (entity.Type == EntityType.ENTITY_SLOT and entity.Variant == 14) then
					entity:Remove()
					player:ChangePlayerType(PlayerType.PLAYER_MIRIAM_B)
					Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, entity.Position, Vector.Zero, nil)
					player:ChangePlayerType(PlayerType.PLAYER_MIRIAM)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.TaintedMiriamHome)

function mod:UnlockTaintedMiriam(player)
	if player:GetPlayerType() ~= PlayerType.PLAYER_MIRIAM or mod.Unlocks.Miriam.Tainted then return end

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