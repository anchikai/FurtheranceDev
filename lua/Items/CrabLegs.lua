local mod = further

function mod:OnMove()
    local game = Game()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		
		if player:HasCollectible(CollectibleType.COLLECTIBLE_CRAB_LEGS) and (player:GetMovementDirection() == Direction.LEFT or player:GetMovementDirection() == Direction.RIGHT) then
			data.CrabSpeed = true
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		else
			data.CrabSpeed = false
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.OnMove)

function mod:Crab_CacheEval(player, cacheFlag)
	local data = mod:GetData(player)
	if data.CrabSpeed == nil then
		data.CrabSpeed = false
	end
	if data.CrabSpeed == true then
		player.MoveSpeed = player.MoveSpeed + 0.2
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Crab_CacheEval, CacheFlag.CACHE_SPEED)