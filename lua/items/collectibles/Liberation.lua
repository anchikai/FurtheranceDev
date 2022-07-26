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
            if data.LiberationCanFly == false then
                player:UseActiveItem(CollectibleType.COLLECTIBLE_DADS_KEY, false, false, true, false, -1)
            end
            data.LiberationCanFly = true
            player:AddCacheFlags(CacheFlag.CACHE_FLYING)
            player:EvaluateItems()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.LibKill)

function mod:LibNewRoom()
    for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
        local data = mod:GetData(player)
        data.LiberationCanFly = false
        player:AddCacheFlags(CacheFlag.CACHE_FLYING)
        player:EvaluateItems()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.LibNewRoom)

function mod:LibCache(player, flag)
    local data = mod:GetData(player)
	if data.LiberationCanFly then
		player.CanFly = true
    else
        player.CanFly = false
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.LibCache, CacheFlag.CACHE_FLYING)