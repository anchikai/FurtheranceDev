local mod = Furtherance
local game = Game()

local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

---@param player EntityPlayer
function mod:UsePurim(_, _, player)
    local level = game:GetLevel()
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_BOOK_OF_PURIM)
    local chance = (player.Luck * 2) / 100

    if rng:RandomFloat() <= clamp(chance, -math.huge, 0.2) then -- (luck * 2)% chance of teleporting to a boss challenge
        Isaac.ExecuteCommand("goto s.challenge."..rng:RandomInt(25))
    else
        Isaac.ExecuteCommand("goto s.challenge."..rng:RandomInt(25))
    end

    level.LeaveDoor = -1
    game:StartRoomTransition(-3, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UsePurim, CollectibleType.COLLECTIBLE_BOOK_OF_PURIM)