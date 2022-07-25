local mod = Furtherance
local game = Game()

local allAllowedRooms = {
	Equal = {
		[RoomType.ROOM_SUPERSECRET] = true,
		[RoomType.ROOM_ISAACS] = true,
		[RoomType.ROOM_BARREN] = true,
		[RoomType.ROOM_SECRET] = true,
		[RoomType.ROOM_SHOP] = true,
		[RoomType.ROOM_TREASURE] = true,
		[RoomType.ROOM_DICE] = true,
		[RoomType.ROOM_LIBRARY] = true,
		[RoomType.ROOM_CHEST] = true,
		[RoomType.ROOM_PLANETARIUM] = true,
		[RoomType.ROOM_ARCADE] = true,
	},
	LeastCoins = {
		[RoomType.ROOM_ARCADE] = true
	},
	LeastBombs = {
		[RoomType.ROOM_SUPERSECRET] = true,
		[RoomType.ROOM_ISAACS] = true,
		[RoomType.ROOM_BARREN] = true,
		[RoomType.ROOM_SECRET] = true
	},
	LeastKeys = {
		[RoomType.ROOM_SHOP] = true,
		[RoomType.ROOM_TREASURE] = true,
		[RoomType.ROOM_DICE] = true,
		[RoomType.ROOM_LIBRARY] = true,
		[RoomType.ROOM_CHEST] = true,
		[RoomType.ROOM_PLANETARIUM] = true,
	}
}

function mod:UseF4(_, _, player)
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_F4_KEY, "UseItem", "PlayerPickup")
	if not player:HasCollectible(CollectibleType.COLLECTIBLE_ALT_KEY) then
		-- Thanks for solving this problem Connor!
		local level = game:GetLevel()
		local roomsList = level:GetRooms()
		local bombs = player:GetNumBombs()
		local coins = player:GetNumCoins()
		local keys = player:GetNumKeys()

		local allowedRooms
		if (coins == bombs) and (bombs == keys) then
			allowedRooms = allAllowedRooms.Equal
		elseif (coins < bombs) and (coins < keys) then
			allowedRooms = allAllowedRooms.LeastCoins
		elseif (bombs <= coins) and (bombs <= keys) then
			allowedRooms = allAllowedRooms.LeastBombs
		elseif (keys <= coins) and (keys < bombs) then
			allowedRooms = allAllowedRooms.LeastKeys
		end

		local unvisitedRooms = {}
		for i = 0, roomsList.Size - 1 do
			local roomDesc = roomsList:Get(i)
			if roomDesc ~= nil and roomDesc.VisitedCount == 0 and allowedRooms[roomDesc.Data.Type] then
				table.insert(unvisitedRooms, roomDesc.GridIndex)
			end
		end

		if #unvisitedRooms > 0 then
			local choice = rng:RandomInt(#unvisitedRooms) + 1
			local roomIndex = unvisitedRooms[choice]
			game:StartRoomTransition(roomIndex, Direction.NO_DIRECTION, 3)
		else
			mod:playFailSound()
			player:AnimateSad()
		end
	else -- Alt+F4 Synergy
		local level = game:GetLevel()
		local room = game:GetRoom()
		local data = mod:GetData(player)
		local stage = level:GetStage()
		local stageType = level:GetStageType()
		if room:IsCurrentRoomLastBoss() or (stage == LevelStage.STAGE4_3) or (stage == LevelStage.STAGE5) or (stage == LevelStage.STAGE6) or (stage == LevelStage.STAGE7) or (stage == LevelStage.STAGE8) or (stage == LevelStage.STAGE6_GREED) or (stage == LevelStage.STAGE7_GREED) or ((stage == LevelStage.STAGE4_2) and (stageType == StageType.STAGETYPE_REPENTANCE)) then
			mod:playFailSound()
			player:AnimateSad()
		else
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_F4_KEY)
			player:RemoveCollectible(CollectibleType.COLLECTIBLE_ALT_KEY)
			MusicManager():Fadeout(0.01)
			player:AddNullCostume(NullItemID.ID_WAVY_CAP_3)
			data.Transition = 4
			data.AltF4 = true
		end
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseF4, CollectibleType.COLLECTIBLE_F4_KEY)

function mod:RoomTransition(player)
	local data = mod:GetData(player)
	local room = game:GetRoom()
	local level = game:GetLevel()
	if data.Transition == nil then
		data.Transition = 0
		data.AltF4 = false
		data.Boss = false
	elseif data.Transition < 0 then
		data.Transition = 0
	end
	if not (stage == LevelStage.STAGE4_3) or (stage == LevelStage.STAGE5) or (stage == LevelStage.STAGE6) or (stage == LevelStage.STAGE7) or (stage == LevelStage.STAGE8) or (stage == LevelStage.STAGE7_GREED) or ((stage == LevelStage.STAGE4_2) and (stageType == StageType.STAGETYPE_REPENTANCE)) then
		data.Transition = data.Transition - 1
		if data.AltF4 == true then
			SFXManager():Stop(SoundEffect.SOUND_DOOR_HEAVY_CLOSE)
			SFXManager():Stop(SoundEffect.SOUND_DOOR_HEAVY_OPEN)
			SFXManager():Stop(SoundEffect.SOUND_METAL_DOOR_CLOSE)
			SFXManager():Stop(SoundEffect.SOUND_METAL_DOOR_OPEN)
			for _, entity in pairs(Isaac.FindInRadius(player.Position, 9999, 95)) do
				entity:Remove()
			end
			for i = 1, room:GetGridSize() do
				local gridEntity2 = room:GetGridEntity(i)
				if gridEntity2 ~= nil then
					room:RemoveGridEntity(i, 0, false)
				end
			end
			if room:IsCurrentRoomLastBoss() and room:GetFrameCount() == 1 then
				data.AltF4 = false
				data.Boss = true
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.RoomTransition)

function mod:UnJank()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		local level = game:GetLevel()
		local room = game:GetRoom()

		local stage = level:GetStage()
		local stageType = level:GetStageType()

		-- this "not" might be in the wrong spot, it only applies to the first stage condition...
		if not (stage == LevelStage.STAGE4_3) or (stage == LevelStage.STAGE5) or (stage == LevelStage.STAGE6) or (stage == LevelStage.STAGE7) or (stage == LevelStage.STAGE8) or (stage == LevelStage.STAGE7_GREED) or ((stage == LevelStage.STAGE4_2) and (stageType == StageType.STAGETYPE_REPENTANCE)) then
			if (data.Boss == true and room:IsCurrentRoomLastBoss()) or data.AltF4 == true then
				game:StartRoomTransition(level:GetCurrentRoomIndex(), Direction.NO_DIRECTION, RoomTransitionAnim.WALK, player, RoomTransitionAnim.WALK)
				data.Boss = false
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.UnJank)