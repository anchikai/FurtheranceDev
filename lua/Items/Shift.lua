local mod = Furtherance
local game = Game()

function mod:UseShift(_, _, player)
	mod:GetData(player).ShiftMultiplier = 15
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseShift, CollectibleType.COLLECTIBLE_SHIFT_KEY)

function mod:Shift_CacheEval(player, flag)
	if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_SHIFT_KEY) > 0 then
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + mod:GetData(player).ShiftMultiplier
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Shift_CacheEval)

function mod:Shift_Peffect(player)
	if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_SHIFT_KEY) > 0 then
		if game:GetFrameCount() % 15 == 0 then
			local data = mod:GetData(player)
			data.ShiftMultiplier = data.ShiftMultiplier - 0.125
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.Shift_Peffect)