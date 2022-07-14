local mod = Furtherance
local game = Game()

function mod:PostNewRoom()
    local room = game:GetRoom()
    for p = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(p)
        if room:IsFirstVisit() and player:HasCollectible(CollectibleType.COLLECTIBLE_PALLIUM) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PALLIUM)
            for _, entity in ipairs(Isaac.GetRoomEntities()) do
                if rng:RandomFloat() <= 0.2 and entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() and entity:IsBoss() == false then
                    entity:AddCharmed(EntityRef(player), -1)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.PostNewRoom)