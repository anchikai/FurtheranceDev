local mod = Furtherance
local game = Game()
local rng = RNG()

local function RoomGenerator(index, slot, newRoomIndex)
    local level = game:GetLevel()
    local OldStage, OldStageType, OldChallenge = level:GetStage(), level:GetStageType(), game.Challenge
    -- Set to Basement 1
    level:SetStage(LevelStage.STAGE1_1, StageType.STAGETYPE_ORIGINAL)
    game.Challenge = Challenge.CHALLENGE_RED_REDEMPTION

    -- Make the room
    level:MakeRedRoomDoor(index, slot)

    RedRoom = level:GetRoomByIdx(newRoomIndex, 0)
    RedRoom.Flags = 0
    RedRoom.DisplayFlags = 0

    -- Revert Back to normal
    level:SetStage(OldStage, OldStageType)
    game.Challenge = OldChallenge
    level:UpdateVisibility()
end

local roomNeighborOffsets = { 1, 13, -1, -13 }
local doorMap = {
    [-1] = 0,
    [-13] = 1,
    [1] = 2,
    [13] = 3
}

local function getPossibleRoomNeighbors(roomsList, level)
    local roomNeighbors = {}
    local visitedRooms = {}
    for i = 0, #roomsList - 1 do
        local roomDesc = roomsList:Get(i)
        if roomDesc.Data.Type ~= RoomType.ROOM_SECRET and roomDesc.Data.Type ~= RoomType.ROOM_SUPERSECRET and roomDesc.Data.Type ~= RoomType.ROOM_ULTRASECRET then
            for _, idxOffset in ipairs(roomNeighborOffsets) do
                local idx = roomDesc.GridIndex + idxOffset
                local roomNeighbor = level:GetRoomByIdx(idx)
                if idx >= 0 and idx <= 168 and roomNeighbor.GridIndex == -1 and not visitedRooms[idx] then -- room doesn't exist
                    visitedRooms[idx] = true
                    table.insert(roomNeighbors, {roomDesc.GridIndex, idxOffset})
                end
            end
        end
    end

    return roomNeighbors
end

local function pickRoomNeighbor(RandomRooms)
    if #RandomRooms > 0 then
        local choice = rng:RandomInt(#RandomRooms) + 1
        return table.remove(RandomRooms, choice)
    else
        return nil
    end
end

function mod:UseSoulOfPeter(card, player, flag)
    local level = game:GetLevel()
    -- local room = game:GetRoom()
    local roomsList = level:GetRooms()
    -- local door = rng:RandomInt(4)
    -- local doorIndex
    -- if door == 0 then
    --     doorIndex = -1
    -- elseif door == 1 then
    --     doorIndex = -13
    -- elseif door == 2 then
    --     doorIndex = 1
    -- elseif door == 3 then
    --     doorIndex = 13
    -- end
    local randomRooms = getPossibleRoomNeighbors(roomsList, level)
    for _ = 1, 5 do
        local randRoomInfo = pickRoomNeighbor(randomRooms)
        if randRoomInfo then
            local roomIdx, idxOffset = randRoomInfo[1], randRoomInfo[2]
            RoomGenerator(roomIdx, doorMap[idxOffset], roomIdx + idxOffset)
            local NewRoom = level:GetRoomByIdx(roomIdx + idxOffset)
            NewRoom.DisplayFlags = 101
            level:UpdateVisibility()
        end

        -- if randRoom ~= level:GetCurrentRoomDesc().GridIndex then
        --     RoomGenerator(randRoom, door, randRoom+doorIndex)
        --     print("Made room! "..randRoom)
        --     local NewRoomIdx = level:GetRoomByIdx(randRoom+doorIndex)
        --     NewRoomIdx.DisplayFlags = 101
        --     level:UpdateVisibility()
        -- end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfPeter, RUNE_SOUL_OF_PETER)