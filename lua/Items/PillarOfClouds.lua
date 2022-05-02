local mod = Furtherance
local game = Game()

function mod:RoomSkip()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local level = game:GetLevel()
        local room = game:GetRoom()
        if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_CLOUDS)) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)
            if rng:RandomInt(10) == 0 then
                local leaveDoor = room:GetDoor(level.LeaveDoor)
                local enterDoor = room:GetDoor(level.EnterDoor)
                if room:IsFirstVisit() and room:IsClear() == false then
                    if leaveDoor ~= nil and leaveDoor:IsLocked() == false then
                        leaveDoor:Open()
                        player.Position = room:GetDoorSlotPosition(leaveDoor.Slot)
                    elseif room:IsDoorSlotAllowed((enterDoor.Slot - 2) % 4) then
                        level:MakeRedRoomDoor(level:GetCurrentRoomIndex(), (enterDoor.Slot - 2) % 4)
                        player.Position = room:GetDoorSlotPosition((enterDoor.Slot - 2) % 4)
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RoomSkip)
