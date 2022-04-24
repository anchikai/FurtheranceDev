local mod = Furtherance

function mod:OnMove(player)
    local game = Game()
	local data = mod:GetData(player)
	
	if player:HasCollectible(CollectibleType.COLLECTIBLE_CRAB_LEGS) then
		if data.CrabSpeed == false and (player:GetMovementDirection() == Direction.LEFT or player:GetMovementDirection() == Direction.RIGHT) then
			data.CrabSpeed = true
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		elseif data.CrabSpeed == true and not (player:GetMovementDirection() == Direction.LEFT or player:GetMovementDirection() == Direction.RIGHT) then
			data.CrabSpeed = false
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		end
	elseif data.CrabSpeed == true then
		data.CrabSpeed = false
		player:AddCacheFlags(CacheFlag.CACHE_SPEED)
		player:EvaluateItems()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnMove)

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