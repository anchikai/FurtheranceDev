local mod = further
local game = Game()

function mod:UseGuidance(_, _, player)
    local data = mod:GetData(player)
    player:UseActiveItem(CollectibleType.COLLECTIBLE_DADS_KEY, false, false, true, false, -1)
	data.Guidance = true
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseGuidance, CollectibleType.COLLECTIBLE_BOOK_OF_GUIDANCE)

function mod:NewRoom()
	local room = game:GetRoom()
	local level = game:GetLevel()
	for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
        local data = mod:GetData(player)
		if data.Guidance == true then
			player:UseActiveItem(CollectibleType.COLLECTIBLE_DADS_KEY, false, false, true, false, -1)
			SFXManager():Stop(SoundEffect.SOUND_GOLDENKEY)
			SFXManager():Stop(SoundEffect.SOUND_UNLOCK00)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.NewRoom)

function mod:RemoveGuidance()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		data.Guidance = false
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.RemoveGuidance)