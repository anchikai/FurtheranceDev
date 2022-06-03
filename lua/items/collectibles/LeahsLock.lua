local mod = Furtherance
local game = Game()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

mod:SavePlayerData({
	LeahsLockTears = 0
})

function mod:LeahsLock()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		local llRNG = player:GetTrinketRNG(TrinketType.TRINKET_LEAHS_LOCK):RandomInt(2)
		local room = game:GetRoom()
		if player:HasTrinket(TrinketType.TRINKET_LEAHS_LOCK) then
			if room:IsFirstVisit() then
				if llRNG == 0 then
					if player.MaxFireDelay > 2 then
						SFXManager():Play(bhb)
						player:AddBrokenHearts(1)
						data.LeahsLockTears = data.LeahsLockTears + 1
					end
				elseif llRNG == 1 then
					if player:GetBrokenHearts() > 0 then
						SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
						player:AddBrokenHearts(-1)
						data.LeahsLockTears = data.LeahsLockTears - 1
					else
						if player.MaxFireDelay > 2 then
							SFXManager():Play(bhb)
							player:AddBrokenHearts(1)
							data.LeahsLockTears = data.LeahsLockTears + 1
						end
					end
				end
			end
		end
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
		player:EvaluateItems()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.LeahsLock)

function mod:llStats(player, flag)
	local data = mod:GetData(player)
	if player:HasTrinket(TrinketType.TRINKET_LEAHS_LOCK) then
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - (data.LeahsLockTears * 0.9)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.llStats)