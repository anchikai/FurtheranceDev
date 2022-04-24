local mod = Furtherance
local rng = RNG()
local game = Game()

function mod:UseSpaceBar(boi, rng, player)
	--if the stage is Blue Womb, Dark Room, Chest, The Void, Home, or Corpse II
	local level = game:GetLevel()
	local stage = level:GetStage()
	local stageType = level:GetStageType()
	if (stage == LevelStage.STAGE4_3) or (stage == LevelStage.STAGE6) or (stage == LevelStage.STAGE7) or (stage == LevelStage.STAGE8) or (stage == LevelStage.STAGE7_GREED) or ((stage == LevelStage.STAGE4_2) and (stageType == StageType.STAGETYPE_REPENTANCE)) then
		mod:playFailSound()
		player:AnimateSad()
	else
	--do normal thing
		game:StartRoomTransition(game:GetLevel():QueryRoomTypeIndex(RoomType.ROOM_ERROR, false, RNG()), Direction.NO_DIRECTION ,3)
	end
	if rng:RandomInt(100) <= 8 then
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_SPACEBAR_KEY)
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseSpaceBar, CollectibleType.COLLECTIBLE_SPACEBAR_KEY)