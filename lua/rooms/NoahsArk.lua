local mod = Furtherance
local game = Game()
local rng = RNG()
mod.NoahsArkIdx = nil

function mod.RoomGenerator(index, slot, newroom)
    local level = game:GetLevel()
    local OldStage, OldStageType, OldChallenge = level:GetStage(), level:GetStageType(), game.Challenge
    -- Set to Basement 1
    level:SetStage(LevelStage.STAGE1_1, StageType.STAGETYPE_ORIGINAL)
    game.Challenge = Challenge.CHALLENGE_RED_REDEMPTION

    -- Make the room
    level:MakeRedRoomDoor(index, slot)

    RedRoom = level:GetRoomByIdx(newroom, 0)
    RedRoom.Flags = 0
    RedRoom.DisplayFlags = 0

    -- Revert Back to normal
    level:SetStage(OldStage, OldStageType)
    game.Challenge = OldChallenge
    level:UpdateVisibility()
end

local function CanCreateRoom(id, doorSlot) -- this can definitely be done better
	local level = game:GetLevel()
	if doorSlot == DoorSlot.LEFT0 then
		if level:GetRoomByIdx(id-1,0).GridIndex > -1 or level:GetRoomByIdx(id-2,0).GridIndex > -1 or level:GetRoomByIdx(id-14,0).GridIndex > -1 or level:GetRoomByIdx(id+12,0).GridIndex > -1 then
			return false
		end
		if level:GetRoomByIdx(id-1,0).GridIndex < -1 or level:GetRoomByIdx(id-2,0).GridIndex < -1 or level:GetRoomByIdx(id-14,0).GridIndex < -1 or level:GetRoomByIdx(id+12,0).GridIndex < -1 then
			return false
		end
	elseif doorSlot == DoorSlot.UP0 then
		if level:GetRoomByIdx(id-13,0).GridIndex > -1 or level:GetRoomByIdx(id-26,0).GridIndex > -1 or level:GetRoomByIdx(id-14,0).GridIndex > -1 or level:GetRoomByIdx(id-12,0).GridIndex > -1 then
			return false
		end
		if level:GetRoomByIdx(id-13,0).GridIndex < -1 or level:GetRoomByIdx(id-26,0).GridIndex < -1 or level:GetRoomByIdx(id-14,0).GridIndex < -1 or level:GetRoomByIdx(id-12,0).GridIndex < -1 then
			return false
		end
	elseif doorSlot == DoorSlot.RIGHT0 then
		if level:GetRoomByIdx(id+1,0).GridIndex > -1 or level:GetRoomByIdx(id+2,0).GridIndex > -1 or level:GetRoomByIdx(id+14,0).GridIndex > -1 or level:GetRoomByIdx(id-12,0).GridIndex > -1 then
			return false
		end
		if level:GetRoomByIdx(id+1,0).GridIndex < -1 or level:GetRoomByIdx(id+2,0).GridIndex < -1 or level:GetRoomByIdx(id+14,0).GridIndex < -1 or level:GetRoomByIdx(id-12,0).GridIndex < -1 then
			return false
		end
	elseif doorSlot == DoorSlot.DOWN0 then
		if level:GetRoomByIdx(id+13,0).GridIndex > -1 or level:GetRoomByIdx(id+26,0).GridIndex > -1 or level:GetRoomByIdx(id+14,0).GridIndex > -1 or level:GetRoomByIdx(id+12,0).GridIndex > -1 then
			return false
		end
		if level:GetRoomByIdx(id+13,0).GridIndex < -1 or level:GetRoomByIdx(id+26,0).GridIndex < -1 or level:GetRoomByIdx(id+14,0).GridIndex < -1 or level:GetRoomByIdx(id+12,0).GridIndex < -1 then
			return false
		end
	end
	return true
end

function mod:CreateArk()
    local level = game:GetLevel()
    local room = game:GetRoom()
    local roomsList = level:GetRooms()
    -- Iterate over each index in the rooms list.
    for i = 0, roomsList.Size - 1 do
        local roomDesc = roomsList:Get(i)
        if roomDesc.Data.Type == RoomType.ROOM_LIBRARY then
            break
        elseif roomDesc.Data.Type == RoomType.ROOM_DEFAULT then
            local door = rng:RandomInt(4)
            local doorIndex
            if door == 0 then
                doorIndex = -1
            elseif door == 1 then
                doorIndex = -13
            elseif door == 2 then
                doorIndex = 1
            elseif door == 3 then
                doorIndex = 13
            end
            if CanCreateRoom(roomDesc.GridIndex, door) == true and roomDesc.Data.Shape == RoomShape.ROOMSHAPE_1x1 then
                mod.RoomGenerator(roomDesc.GridIndex, door, roomDesc.GridIndex+doorIndex)
                mod.NoahsArkIdx = roomDesc.GridIndex+doorIndex
                mod.ArkDoor = door
                break
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.CreateArk)

function mod:EnterArk()
    local level = game:GetLevel()
    local room = game:GetRoom()
    if mod.NoahsArkIdx ~=  nil and level:GetCurrentRoomIndex() == mod.NoahsArkIdx then
        if room:IsFirstVisit() then
            room:GetDoor(level.EnterDoor):Open()
            room:SetClear(true)
            for i = 1, room:GetGridSize() do
				local gridEntities = room:GetGridEntity(i)
				if gridEntities ~= nil and gridEntities:GetType() ~= GridEntityType.GRID_WALL and gridEntities:GetType() ~= GridEntityType.GRID_DOOR then
					gridEntities:Destroy(true)
                    SFXManager():Stop(SoundEffect.SOUND_ROCK_CRUMBLE)
				end
			end
            for _, entity in pairs(Isaac.GetRoomEntities()) do
				if entity.Type ~= EntityType.ENTITY_PLAYER then
                    entity:Remove()
                end
			end
            for p = 0, game:GetNumPlayers() - 1 do
                local player = Isaac.GetPlayer(p)
                repeat
                    ID1 = player:GetDropRNG():RandomInt(Isaac.GetItemConfig():GetCollectibles().Size - 1) + 1
                until (Isaac.GetItemConfig():GetCollectible(ID1).Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST and Isaac.GetItemConfig():GetCollectible(ID1).Type == 4)
                local baby = game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetCenterPos(), Vector.Zero, nil, ID1, room:GetSpawnSeed()):ToPickup()
                baby.OptionsPickupIndex = 2
                repeat
                    ID2 = player:GetDropRNG():RandomInt(Isaac.GetItemConfig():GetCollectibles().Size - 1) + 1
                until (Isaac.GetItemConfig():GetCollectible(ID2).Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST and Isaac.GetItemConfig():GetCollectible(ID2).Type == 4)
                local baby = game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(63), Vector.Zero, nil, ID2, room:GetSpawnSeed()):ToPickup()
                baby.OptionsPickupIndex = 2
                repeat
                    ID3 = player:GetDropRNG():RandomInt(Isaac.GetItemConfig():GetCollectibles().Size - 1) + 1
                until (Isaac.GetItemConfig():GetCollectible(ID3).Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST and Isaac.GetItemConfig():GetCollectible(ID3).Type == 4)
                local baby = game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(71), Vector.Zero, nil, ID3, room:GetSpawnSeed()):ToPickup()
                baby.OptionsPickupIndex = 2
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.EnterArk)