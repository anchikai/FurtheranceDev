local mod = Furtherance
local game = Game()

function mod.RoomGenerator(index, slot, newroom)
    local level = game:GetLevel()
    local OldStage, OldStageType, OldChallenge = level:GetStage(), level:GetStageType(), game.Challenge
    -- Set to Basement 1
    level:SetStage(LevelStage.NUM_STAGES, StageType.STAGETYPE_ORIGINAL)
    game.Challenge = Challenge.CHALLENGE_RED_REDEMPTION

    -- Make the room
    print(level:MakeRedRoomDoor(index, slot))

    RedRoom = level:GetRoomByIdx(newroom, 0)
    RedRoom.Flags = 0
    RedRoom.DisplayFlags = 0

    -- Revert Back to normal
    level:SetStage(OldStage, OldStageType)
    game.Challenge = OldChallenge
    level:UpdateVisibility()
end

function mod:GenerateArk()
    local level = game:GetLevel()
    local room = game:GetRoom()
    if level:GetCurrentRoomIndex() == -10 then
	    level:MakeRedRoomDoor(-10, DoorSlot.RIGHT0)
        SFXManager():Stop(SoundEffect.SOUND_UNLOCK00)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.GenerateArk)

function mod:Update(player)
    local level = game:GetLevel()
    local room = game:GetRoom()
    if level:GetCurrentRoomIndex() == -10 then
        if player.Position.X >= 592.5 then
            Isaac.ExecuteCommand("goto s.teleporter.0")
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.Update)

function mod:FamiliarItems(pool, decrease, seed)
	local level = game:GetLevel()
	local room = game:GetRoom()
	if level:GetCurrentRoomIndex() == -3 then
        return game:GetItemPool():GetCollectible(ItemPoolType.POOL_BABY_SHOP, false, seed, CollectibleType.COLLECTIBLE_NULL)
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.FamiliarItems)