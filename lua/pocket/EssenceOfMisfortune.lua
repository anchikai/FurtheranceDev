local mod = Furtherance
local game = Game()

local usedMisfortune = false
function mod:UseEssenceOfMisfortune(card, player, flag)
    local level = game:GetLevel()
    Isaac.ExecuteCommand("goto s.treasure")
    level.LeaveDoor = -1
    game:StartRoomTransition(-3, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player, -1)
    usedMisfortune = true
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfMisfortune, OBJ_ESSENCE_OF_MISFORTUNE)

function mod:APIcanLigma(player)
    local room = game:GetRoom()
    if usedMisfortune and room:GetType() == RoomType.ROOM_TREASURE then
        usedMisfortune = false
        game:ShowHallucination(0, BackdropType.GEHENNA)
        SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.APIcanLigma)

function mod:DevilPool(pool, decrease, seed)
	if usedMisfortune then
		if Rerolled ~= true then
			Rerolled = true
			return game:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false, seed, CollectibleType.COLLECTIBLE_NULL)
		end
		Rerolled = false
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.DevilPool)