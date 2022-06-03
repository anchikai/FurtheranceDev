local mod = Furtherance
local game = Game()

mod:SavePlayerData({
	UnluckyPennyStat = 0
})

function mod:ResetCounter(player)
	local data = mod:GetData(player)
	data.UnluckyPennyStat = data.UnluckyPennyStat or 0
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.ResetCounter)

function mod:UnluckyPenny(pickup, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		local data = mod:GetData(player)
		if collider.Type == EntityType.ENTITY_PLAYER and pickup.SubType == CoinSubType.COIN_UNLUCKYPENNY then
			SFXManager():Play(SoundEffect.SOUND_LUCKYPICKUP, 1, 2, false, 0.8)
			data.UnluckyPennyStat = data.UnluckyPennyStat + 1
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_LUCK)
			player:EvaluateItems()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.UnluckyPenny, PickupVariant.PICKUP_COIN)

function mod:Lucknt(player, flag)
	local data = mod:GetData(player)
	if data.UnluckyPennyStat == nil then return end

	if flag == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage + (data.UnluckyPennyStat/2)
	end
	if flag == CacheFlag.CACHE_LUCK then
		player.Luck = player.Luck - data.UnluckyPennyStat
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Lucknt)