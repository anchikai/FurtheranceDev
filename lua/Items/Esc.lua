local mod = Furtherance
local game = Game()

function mod:UseEsc(boi, rng, player, slot, data)
	--if the stage is Home
	local stage = game:GetLevel():GetStage()
	local stageType = game:GetLevel():GetStageType()

	if (stage == LevelStage.STAGE8) then
		player:UseCard(Card.CARD_FOOL)
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_ESC_KEY)
		player:AddCollectible(CollectibleType.COLLECTIBLE_DOGMA)
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_DOGMA)
	else
	--do normal thing
		game:StartRoomTransition(game:GetLevel():QueryRoomTypeIndex(RoomType.ROOM_DEFAULT, false, RNG()), Direction.NO_DIRECTION ,3)
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_ESC_KEY)
		player:AddCollectible(CollectibleType.COLLECTIBLE_DOGMA)
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_DOGMA)
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseEsc, CollectibleType.COLLECTIBLE_ESC_KEY)