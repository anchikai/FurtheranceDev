local mod = further
local game = Game()

function mod:WormEffect(EntityTear)
    for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:HasTrinket(TrinketType.TRINKET_SLICK_WORM, false) then
			
		end
		player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
		player:EvaluateItems()
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.WormEffect)

function mod:Slick_CacheEval(player, flag)
	if player:HasTrinket(TrinketType.TRINKET_SLICK_WORM, false) then
		if flag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_BOUNCE
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Slick_CacheEval)