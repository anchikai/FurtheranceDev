local mod = Furtherance
local game = Game()

local usedCowardice = false
function mod:UseEssenceOfCowardice(card, player, flag)
    local level = game:GetLevel()
    Isaac.ExecuteCommand("goto s.treasure")
    level.LeaveDoor = -1
    game:StartRoomTransition(-3, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
    usedCowardice = true
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfCowardice, RUNE_ESSENCE_OF_COWARDICE)

function mod:APIcanLigma(player)
    local room = game:GetRoom()
    local sprite = player:GetSprite()
    if sprite:IsPlaying("TeleportDown") and sprite:GetFrame() == 1 and usedCowardice and room:GetType() == RoomType.ROOM_TREASURE then
        usedCowardice = false
        game:ShowHallucination(0, BackdropType.GEHENNA)
        SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.APIcanLigma)

function mod:DevilPool(pool, decrease, seed)
	if usedCowardice then
		if Rerolled ~= true then
			Rerolled = true
			return game:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false, seed, CollectibleType.COLLECTIBLE_NULL)
		end
		Rerolled = false
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.DevilPool)