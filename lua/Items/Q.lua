local mod = Furtherance
local game = Game()

function mod:UseQ(_, _, player)
	--if you use ? card
	if (player:GetCard(0) == Card.CARD_QUESTIONMARK) then
		player:SetCard(0, Card.CARD_NULL)
		game:StartRoomTransition(game:GetLevel():QueryRoomTypeIndex(RoomType.ROOM_ERROR, false, RNG()), Direction.NO_DIRECTION ,3)
	else	
	--do normal thing
	player:UseActiveItem(CollectibleType.COLLECTIBLE_PLACEBO, false, false, true, false, 0)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_BLANK_CARD, false, false, true, false, 0)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_CLEAR_RUNE, false, false, true, false, 0)
	player:UseActiveItem(player:GetActiveItem(2), false, false, true, false, 0)
	end
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseQ, CollectibleType.COLLECTIBLE_Q_KEY)