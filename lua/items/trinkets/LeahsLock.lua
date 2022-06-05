local mod = Furtherance
local game = Game()
local BrokenHeartbeatSound = Isaac.GetSoundIdByName("BrokenHeartbeat")

mod:SavePlayerData({
	LeahsLockTears = 0
})

function mod:LeahsLock()
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		local rng = player:GetTrinketRNG(TrinketType.TRINKET_LEAHS_LOCK)
		if player:HasTrinket(TrinketType.TRINKET_LEAHS_LOCK) and room:IsFirstVisit() then
			if rng:RandomFloat() < 0.5 and player:GetBrokenHearts() > 0 then
				SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
				player:AddBrokenHearts(-1)
				data.LeahsLockTears = data.LeahsLockTears - 1
			elseif player.MaxFireDelay > 2 then
				SFXManager():Play(BrokenHeartbeatSound)
				player:AddBrokenHearts(1)
				data.LeahsLockTears = data.LeahsLockTears + 1
			end
		end
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
		player:EvaluateItems()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.LeahsLock)

function mod:llStats(player, flag)
	local data = mod:GetData(player)
	if data.LeahsLockTears == nil then return end
	if player:HasTrinket(TrinketType.TRINKET_LEAHS_LOCK) then
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - (data.LeahsLockTears * 0.9)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.llStats)