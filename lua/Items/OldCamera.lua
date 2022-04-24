local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:DataStuff()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		data.CameraSaved = false
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.DataStuff)

function mod:UseCamera(_, _, player)
	local data = mod:GetData(player)
	local level = game:GetLevel()
	local room = game:GetRoom()
	if data.CameraSaved == false then
		data.CameraSaved = true
		data.CurRoomID = level:GetCurrentRoomIndex()
	elseif data.CameraSaved == true then
		game:ChangeRoom(data.CurRoomID)
		data.CameraSaved = false
		player:UseActiveItem(CollectibleType.COLLECTIBLE_D7, false, false, true, false, -1)
	end
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseCamera, CollectibleType.COLLECTIBLE_OLD_CAMERA)

function mod:Forgor()
	for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		data.CameraSaved = false
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.Forgor)