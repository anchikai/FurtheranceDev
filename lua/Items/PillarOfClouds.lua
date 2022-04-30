local mod = Furtherance
local game = Game()

function mod:RoomSkip()
    for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
        local level = game:GetLevel()
        local room = game:GetRoom()
        if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_CLOUDS)) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)
            if rng:RandomInt(2) < 2 then
                local leaveDoor = room:GetDoor(level.LeaveDoor)
                if leaveDoor ~= nil and leaveDoor:IsLocked() == false then
                    if leaveDoor:ToDoor().Slot == DoorSlot.LEFT0 or leaveDoor:ToDoor().Slot == DoorSlot.LEFT1 then
                        xOffset = -60
                        yOffset = 0
                    elseif leaveDoor:ToDoor().Slot == DoorSlot.UP0 or leaveDoor:ToDoor().Slot == DoorSlot.UP1 then
                        xOffset = 0
                        yOffset = -60
                    elseif leaveDoor:ToDoor().Slot == DoorSlot.RIGHT0 or leaveDoor:ToDoor().Slot == DoorSlot.RIGHT1 then
                        xOffset = 60
                        yOffset = 0
                    elseif leaveDoor:ToDoor().Slot == DoorSlot.DOWN0 or leaveDoor:ToDoor().Slot == DoorSlot.DOWN1 then
                        xOffset = 0
                        yOffset = 60
                    end
                    leaveDoor:Open()
                    player.Position = Vector(leaveDoor.Position.X+xOffset, leaveDoor.Position.Y+yOffset)
                end
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RoomSkip)