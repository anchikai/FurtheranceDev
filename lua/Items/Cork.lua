local mod = Furtherance
local game = Game()
local CorkPop = Isaac.GetSoundIdByName("Cork")

function mod:CorkTear(tear)
    local player = tear.Parent:ToPlayer()
	if player and player:HasCollectible(CollectibleType.COLLECTIBLE_CORK) then
        if tearCount == nil or tearCount > 16 then
            tearCount = 0
        elseif tearCount < 17 then
            tearCount = tearCount + 1
        end
        if (16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) < 2 and tearCount == 2) or (tearCount == 16 - player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CORK, true) < 15) then
            tearCount = 0
            tear:Remove()
            local Cork = player:FireTear(player.Position, tear.Velocity*(player.ShotSpeed*1.25), true, false, true, player, 2)
            tearCount = tearCount - 1
            SFXManager():Stop(SoundEffect.SOUND_TEARS_FIRE)
            SFXManager():Play(CorkPop, 2)
            Cork.Scale = tear.Scale * 1.5
            local sprite = Cork:GetSprite()
        end
        print(tearCount)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.CorkTear)

function mod:ResetCork(continued)
	if continued == false then
		tearCount = 0
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetCork)