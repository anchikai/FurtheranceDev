local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:UseReverseHope(card, player, flag)
	local level = game:GetLevel()
	Isaac.ExecuteCommand("goto s.challenge."..rng:RandomInt(25))
	level.LeaveDoor = -1
    game:StartRoomTransition(-3, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseReverseHope, CARD_REVERSE_HOPE)