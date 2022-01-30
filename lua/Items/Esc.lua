local mod = further

function mod:UseEsc(boi, rng, player, slot, data)
	--if the stage is Home
	local stage = Game():GetLevel():GetStage()
	local stageType = Game():GetLevel():GetStageType()

	if (stage == LevelStage.STAGE8) then
		player:UseCard(Card.CARD_FOOL)
		player:AnimateCollectible(CollectibleType.COLLECTIBLE_ESC_KEY, "UseItem", "PlayerPickup")
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_ESC_KEY)
		player:AddCollectible(CollectibleType.COLLECTIBLE_DOGMA)
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_DOGMA)
	else
	--do normal thing
		Game():StartRoomTransition(Game():GetLevel():QueryRoomTypeIndex(RoomType.ROOM_DEFAULT, false, RNG()), Direction.NO_DIRECTION ,3)
		player:AnimateCollectible(CollectibleType.COLLECTIBLE_ESC_KEY, "UseItem", "PlayerPickup")
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_ESC_KEY)
		player:AddCollectible(CollectibleType.COLLECTIBLE_DOGMA)
		player:RemoveCollectible(CollectibleType.COLLECTIBLE_DOGMA)
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseEsc, CollectibleType.COLLECTIBLE_ESC_KEY)