local mod = Furtherance
local game = Game()
local rng = RNG()

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

local function pickRandomRoom(roomsList, level, room)
    local RandomRooms = {}
    for i = 0, #roomsList - 1 do
        local roomDesc = roomsList:Get(i)
        for d = 0, 3 do
            if (room:IsDoorSlotAllowed(d) and room:GetDoor(d) == nil) and roomDesc.Data.GridIndex ~= level:GetCurrentRoomIndex() then
                table.insert(RandomRooms, roomDesc)
            end
        end
    end

    if #RandomRooms > 0 then
        local choice = rng:RandomInt(#RandomRooms) + 1
        return RandomRooms[choice].GridIndex
    end
end

function mod:UseSoulOfPeter(card, player, flag)
    local level = game:GetLevel()
    local room = game:GetRoom()
    local roomsList = level:GetRooms()
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
    for _ = 1, 5 do
        local RandRoom = pickRandomRoom(roomsList, level, room)
        mod.RoomGenerator(RandRoom, door, RandRoom+doorIndex)
        print("Made room! "..RandRoom)
        local NewRoomIdx = level:GetRoomByIdx(RandRoom+doorIndex)
        NewRoomIdx.DisplayFlags = 101
        level:UpdateVisibility()
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfPeter, RUNE_SOUL_OF_PETER)