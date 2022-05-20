local mod = Furtherance
local game = Game()

function mod:Rapturing()
    local room = game:GetRoom()
    if room:IsFirstVisit() then
        RoomCount = RoomCount + 1
    end
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player and player:HasCollectible(CollectibleType.COLLECTIBLE_PETERS_HEADBAND) then
            if RoomCount >= 12 then
                RoomCount = 0
                player:UseActiveItem(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, false, false, true, false, -1)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.Rapturing)

function mod:ResetCounter(continued)
    if continued == false then
        RoomCount = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetCounter)
