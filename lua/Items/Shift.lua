local mod = Furtherance
local game = Game()

function mod:UseShift(_, _, player)
	local data = mod:GetData(player)
	data.ShiftKeyPressed = true
	data.ShiftMultiplier = 15
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseShift, CollectibleType.COLLECTIBLE_SHIFT_KEY)

function mod:ShiftCache(player, flag)
	local data = mod:GetData(player)
	if data.ShiftMultiplier == nil or data.ShiftKeyPressed == false then
		data.ShiftMultiplier = 0
	end
	if flag == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage + data.ShiftMultiplier
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.ShiftCache)

function mod:ShiftTears(player)
	local data = mod:GetData(player)
	if data.ShiftKeyPressed == true then
		if game:GetFrameCount()%15 == 0 then
			data.ShiftMultiplier = data.ShiftMultiplier - 0.125
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
		if data.ShiftMultiplier == 0 then
			data.ShiftKeyPressed = false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ShiftTears)