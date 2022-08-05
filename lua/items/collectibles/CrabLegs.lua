local mod = Furtherance

function mod:OnMove(player)
	local data = mod:GetData(player)
	local inputPlayer = player
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B then
		inputPlayer = player:GetOtherTwin()
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_CRAB_LEGS) then
		local movementDirection = inputPlayer:GetMovementDirection()
		local isMovingSideways = movementDirection == Direction.LEFT or movementDirection == Direction.RIGHT
		if data.CrabSpeed ~= isMovingSideways then
			data.CrabSpeed = isMovingSideways
		else
			return
		end
	elseif data.CrabSpeed == true then
		data.CrabSpeed = false
	else
		return
	end
	
	player:AddCacheFlags(CacheFlag.CACHE_SPEED)
	player:EvaluateItems()
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnMove)

function mod:CrabCacheEval(player)
	local data = mod:GetData(player)
	if data.CrabSpeed == nil then
		data.CrabSpeed = false
	end
	if data.CrabSpeed == true then
		player.MoveSpeed = player.MoveSpeed + 0.2
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.CrabCacheEval, CacheFlag.CACHE_SPEED)