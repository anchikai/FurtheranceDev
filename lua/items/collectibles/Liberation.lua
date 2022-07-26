local mod = Furtherance
local game = Game()

function mod:SetLiberationData(player)
    local data = mod:GetData(player)
    data.LiberationCanFly = false
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.SetRottenLoveData)

function mod:LibKill(entity)
    for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
        local data = mod:GetData(player)
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LIBERATION)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_LIBERATION) and rng:RandomFloat() <= 10.05 then
            if data.ActivatedLiberation == false then
                player:UseActiveItem(CollectibleType.COLLECTIBLE_BIBLE, false, false, true, true, -1)
                player:UseActiveItem(CollectibleType.COLLECTIBLE_DADS_KEY, false, false, true, false, -1)
            end
            data.ActivatedLiberation = true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.LibKill)

function mod:LibNewRoom()
    for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
        local data = mod:GetData(player)
        data.ActivatedLiberation = false
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.LibNewRoom)