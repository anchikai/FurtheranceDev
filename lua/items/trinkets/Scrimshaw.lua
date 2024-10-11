local mod = Furtherance
local game = Game()

function mod:EnterRoom()
	local room = game:GetRoom()
    if room:IsFirstVisit() then
        for p = 0, game:GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(p)
			if player:HasTrinket(TrinketType.TRINKET_SCRIMSHAW) and room:GetType() ~= RoomType.ROOM_DEFAULT then
				local data = mod:GetData(player)
				if data.ScrimshawDMG == nil then
					data.ScrimshawDMG = 0
				end
				data.ScrimshawDMG = data.ScrimshawDMG + 5
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
				player:EvaluateItems()
			end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.EnterRoom)

function mod:ScrimshawDamage(player)
    local data = mod:GetData(player)
    if data.ScrimshawDMG == nil then return end

    player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
    player:EvaluateItems()

    data.ScrimshawDMG = math.max(data.ScrimshawDMG - 0.01, 0)
    if data.ScrimshawDMG > 0 then
        player.Damage = player.Damage + data.ScrimshawDMG
    else
        data.ScrimshawDMG = nil
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ScrimshawDamage)