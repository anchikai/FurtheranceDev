local mod = Furtherance
local game = Game()

mod:SavePlayerData({
	CameraSaved = false,
	CurRoomID = mod.SaveNil
})

function mod:RespawnEnemies(player)
	local data = mod:GetData(player)
	local room = game:GetRoom()
	if data.UsedOldCamera and game:IsPaused() == false then
		room:RespawnEnemies()
		data.UsedOldCamera = false
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.RespawnEnemies)

function mod:UseCamera(_, _, player)
	local data = mod:GetData(player)
	local level = game:GetLevel()
	if data.CameraSaved == false then
		data.CameraSaved = true
		data.CurRoomID = level:GetCurrentRoomIndex()
	elseif data.CameraSaved == true then
		--[[ This must be set before every `game:StartRoomTransition()` call
		or else the function can send you to the wrong room ]]
		level.LeaveDoor = -1
		game:StartRoomTransition(data.CurRoomID, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
		data.CameraSaved = false
		data.UsedOldCamera = true
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseCamera, CollectibleType.COLLECTIBLE_OLD_CAMERA)

local newGame = false
function mod:NewGame()
	newGame = true
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.NewGame)

function mod:ForgetOnNewLevel()
	if newGame then
		newGame = false
		return
	end

	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		data.CameraSaved = false
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ForgetOnNewLevel)