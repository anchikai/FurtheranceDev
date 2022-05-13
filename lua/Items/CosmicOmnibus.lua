local mod = Furtherance
local game = Game()

function mod:UseOmnibus(_, _, player)
    local level = game:GetLevel()
    local roomsList = level:GetRooms()
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_COSMIC_OMNIBUS)

    -- 30% chance of teleporting to a planetarium
    if rng:RandomInt(10) <= 2 then
        Isaac.ExecuteCommand("goto s.planetarium." .. rng:RandomInt(7))
        level.LeaveDoor = -1
        game:StartRoomTransition(-3, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
        return true
    end

    local nonNormalRooms = {}
    for i = 0, #roomsList - 1 do
        local roomDesc = roomsList:Get(i)
        if roomDesc.Data.Type ~= RoomType.ROOM_DEFAULT and roomDesc.Data.Type ~= RoomType.ROOM_ULTRASECRET and roomDesc.VisitedCount == 0 then
            table.insert(nonNormalRooms, roomDesc)
        end
    end

    if #nonNormalRooms > 0 then -- teleport to a random non-normal room
        local choice = rng:RandomInt(#nonNormalRooms) + 1
        local chosenRoom = nonNormalRooms[choice]
        level.LeaveDoor = -1
        game:StartRoomTransition(chosenRoom.GridIndex, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
    else -- go to a planetarium
        Isaac.ExecuteCommand("goto s.planetarium." .. rng:RandomInt(7))
        level.LeaveDoor = -1
        game:StartRoomTransition(-3, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
    end

    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseOmnibus, CollectibleType.COLLECTIBLE_COSMIC_OMNIBUS)