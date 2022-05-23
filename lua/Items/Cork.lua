local mod = Furtherance
local game = Game()
local CorkPop = Isaac.GetSoundIdByName("Cork")
local tearCount = 0

function mod:CorkTear(tear)
    local player = tear.Parent:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_CORK) then
        if tearCount > 16 then
            tearCount = 0
        elseif tearCount < 17 then
            tearCount = tearCount + 1
        end
        if (16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) < 2 and tearCount == 2) or (tearCount == 16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) < 15) then
            tearCount = -1
            tear:Remove()
            local Cork = player:FireTear(player.Position, tear.Velocity * (player.ShotSpeed * 1.25), true, false, true, player, 2)
            SFXManager():Stop(SoundEffect.SOUND_TEARS_FIRE)
            SFXManager():Play(CorkPop, 2)
            Cork.Scale = tear.Scale * 1.5
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.CorkTear)

local InputHeld = 0
function mod:ForgorCork(player)
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
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_CORK) then
        if tearCount > 16 then
            tearCount = 0
        elseif tearCount < 17 and InputHeld == 1 then
            tearCount = tearCount + 1
        end
        if (16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) < 2 and tearCount == 2) or (tearCount == 16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) < 15) then
            tearCount = -1
            local Cork = player:FireTear(player.Position, player:GetAimDirection()*10 * (player.ShotSpeed * 1.25), true, false, true, player, 2)
            SFXManager():Stop(SoundEffect.SOUND_TEARS_FIRE)
            SFXManager():Play(CorkPop, 2)
            Cork.Scale = 1.5
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ForgorCork)

function mod:ResetCork(continued)
    if continued == false then
        tearCount = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetCork)
