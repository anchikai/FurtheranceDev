local mod = Furtherance
local game = Game()

function mod:PostNewLevel()
    for p = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(p)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BEGINNERS_LUCK) then
            local data = mod:GetData(player)
            if data.BeginnersLuckBonus == nil then
                data.BeginnersLuckBonus = 0
            end
            data.BeginnersLuckBonus = data.BeginnersLuckBonus + 11
            player:AddCacheFlags(CacheFlag.CACHE_LUCK)
            player:EvaluateItems()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.PostNewLevel)

function mod:PostNewRoom()
    local room = game:GetRoom()
    if room:IsFirstVisit() then
        for p = 0, game:GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(p)
            local data = mod:GetData(player)
            if data.BeginnersLuckBonus ~= nil and data.BeginnersLuckBonus > 0 then
                data.BeginnersLuckBonus = data.BeginnersLuckBonus - 1
                player:AddCacheFlags(CacheFlag.CACHE_LUCK)
                player:EvaluateItems()
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.PostNewRoom)

function mod:GetBeginnersLuck(player, flag)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_BEGINNERS_LUCK) then
        local data = mod:GetData(player)
        if flag == CacheFlag.CACHE_LUCK and data.BeginnersLuckBonus ~= nil then
            player.Luck = player.Luck + data.BeginnersLuckBonus
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetBeginnersLuck)