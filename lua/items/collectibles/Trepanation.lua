local mod = Furtherance
local tearCount = 0

function mod:HaemolacriaTear(tear)
    local player = tear.Parent:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_TREPANATION) and player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN and player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN_B then
        if tearCount > 16 then
            tearCount = 0
        elseif tearCount < 17 then
            tearCount = tearCount + 1
        end
        if (16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TREPANATION, true) < 2 and tearCount == 2) or (tearCount == 16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TREPANATION, true) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TREPANATION, true) < 15) then
            tearCount = -1
            tear:Remove()
            local Haemolacria = player:FireTear(player.Position, tear.Velocity, true, false, true, player, 2):ToTear()
            Haemolacria:AddTearFlags(TearFlags.TEAR_BURSTSPLIT)
            Haemolacria.FallingSpeed = Haemolacria.FallingSpeed - 20
			Haemolacria.FallingAcceleration = Haemolacria.FallingAcceleration + 1
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.HaemolacriaTear)

local InputHeld = 0
function mod:ForgorHaemolacria(player)
    local b_left = Input.GetActionValue(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
    local b_right = Input.GetActionValue(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
    local b_up = Input.GetActionValue(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
    local b_down = Input.GetActionValue(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
    local isAttacking = (b_down + b_right + b_left + b_up) > 0
    if not isAttacking and InputHeld ~= 0 then
        InputHeld = 0
    end
    if isAttacking then
        InputHeld = InputHeld + 1
    end
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_TREPANATION) and (player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN or player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B) then
        if tearCount > 16 then
            tearCount = 0
        elseif tearCount < 17 and InputHeld == 1 then
            tearCount = tearCount + 1
        end
        if (16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TREPANATION, true) < 2 and tearCount == 2) or (tearCount == 16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TREPANATION, true) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TREPANATION, true) < 15) then
            tearCount = -1
            local Haemolacria = player:FireTear(player.Position, (player:GetAimDirection()*10)*player.ShotSpeed, true, false, true, player, 2)
            Haemolacria:AddTearFlags(TearFlags.TEAR_BURSTSPLIT)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ForgorHaemolacria)

function mod:ResetHaemolacria(continued)
    if continued == false then
        tearCount = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetHaemolacria)