local mod = Furtherance
local game = Game()

function mod:NewRoom()
    local room = game:GetRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasTrinket(TrinketType.TRINKET_BRAZEN_SEA) and not room:IsClear() then
            local rng = player:GetTrinketRNG(TrinketType.TRINKET_BRAZEN_SEA)
            if rng:RandomFloat() <= 0.02 then
                player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.NewRoom)