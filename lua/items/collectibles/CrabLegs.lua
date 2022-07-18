local mod = Furtherance

function mod:OnMove(player)
	local data = mod:GetData(player)
	local inputPlayer = player
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B then
		inputPlayer = player:GetOtherTwin()
	end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_CRAB_LEGS) then
		local movementDirection = inputPlayer:GetMovementDirection()
		if data.CrabSpeed == false and (movementDirection == Direction.LEFT or movementDirection == Direction.RIGHT) then
			data.CrabSpeed = true
		elseif data.CrabSpeed == true and not (movementDirection == Direction.LEFT or movementDirection == Direction.RIGHT) then
			data.CrabSpeed = false
		end
	elseif data.CrabSpeed == true then
		data.CrabSpeed = false
	end
	player:AddCacheFlags(CacheFlag.CACHE_SPEED)
	player:EvaluateItems()
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnMove)

function mod:Crab_CacheEval(player, flag)
	local data = mod:GetData(player)
	if data.CrabSpeed == nil then
		data.CrabSpeed = false
	end
	if data.CrabSpeed == true then
		player.MoveSpeed = player.MoveSpeed + 0.2
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Crab_CacheEval, CacheFlag.CACHE_SPEED)