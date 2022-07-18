local mod = Furtherance
local game = Game()

mod:SavePlayerData({
	ShiftDamageBonus = 0
})

function mod:UseShift(_, _, player)
	mod:GetData(player).ShiftDamageBonus = 15
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseShift, CollectibleType.COLLECTIBLE_SHIFT_KEY)

function mod:ShiftUpdate(player)
	local data = mod:GetData(player)
	if data.ShiftDamageBonus == nil then
		data.ShiftDamageBonus = 0
		return
	end
	if data.ShiftDamageBonus <= 0 then return end

	-- every 0.5 seconds
	if game:GetFrameCount() % 15 == 0 then
		data.ShiftDamageBonus = math.max(data.ShiftDamageBonus - 0.125, 0)
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ShiftUpdate)

function mod:ShiftBuffs(player, flag)
	local data = mod:GetData(player)
	if data.ShiftDamageBonus == nil or data.ShiftDamageBonus <= 0 then return end

	if flag == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage + data.ShiftDamageBonus
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.ShiftBuffs)