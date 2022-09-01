local mod = Furtherance
local game = Game()

function mod:SukkotNewRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        if player:HasTrinket(TrinketType.TRINKET_ROOTS_OF_SUKKOT) then
            local rng = player:GetTrinketRNG(TrinketType.TRINKET_ROOTS_OF_SUKKOT)
            data.RootsOfSukkotChoice = rng:RandomInt(4)+1
            player:AddCacheFlags(CacheFlag.CACHE_SPEED)
            player:AddCacheFlags(CacheFlag.CACHE_RANGE)
            player:AddCacheFlags(CacheFlag.CACHE_SHOTSPEED)
            player:AddCacheFlags(CacheFlag.CACHE_LUCK)
            player:EvaluateItems()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.SukkotNewRoom)

function mod:GetSukkot(player, flag)
    local data = mod:GetData(player)
	if player:HasTrinket(TrinketType.TRINKET_ROOTS_OF_SUKKOT) then
        if flag == CacheFlag.CACHE_SPEED then
		    if data.RootsOfSukkotChoice == 1 then
		    	player.MoveSpeed = player.MoveSpeed + 0.2
		    end
        end
        if flag == CacheFlag.CACHE_RANGE then
		    if data.RootsOfSukkotChoice == 2 then
			    player.TearRange = player.TearRange + 20
		    end
        end
        if flag == CacheFlag.CACHE_SHOTSPEED then
            if data.RootsOfSukkotChoice == 3 then
                player.ShotSpeed = player.ShotSpeed + 0.2
		    end
		end
        if flag == CacheFlag.CACHE_LUCK then
            if data.RootsOfSukkotChoice == 4 then
			    player.Luck = player.Luck + 0.5
	    	end
        end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetSukkot)