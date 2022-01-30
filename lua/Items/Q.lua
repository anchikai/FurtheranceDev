local mod = further

function mod:UseQ(boi, rng, player, slot, data)
	--if you use ? card
	if (player:GetCard(0) == Card.CARD_QUESTIONMARK) then
		player:SetCard(0, Card.CARD_NULL)
		Game():StartRoomTransition(Game():GetLevel():QueryRoomTypeIndex(RoomType.ROOM_ERROR, false, RNG()), Direction.NO_DIRECTION ,3)
	else	
	--do normal thing
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_Q_KEY, "UseItem", "PlayerPickup")
	player:UseActiveItem(CollectibleType.COLLECTIBLE_PLACEBO, false, false, true, false, 0)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_BLANK_CARD, false, false, true, false, 0)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_CLEAR_RUNE, false, false, true, false, 0)
	player:UseActiveItem(player:GetActiveItem(2), false, false, true, false, 0)
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseQ, CollectibleType.COLLECTIBLE_Q_KEY)