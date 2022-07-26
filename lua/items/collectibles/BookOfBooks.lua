local mod = Furtherance

function mod:UseBookOfBooks(_, _, player)
	for i = 1, Isaac.GetItemConfig():GetCollectibles().Size - 1 do
		if i ~= 43 and i ~= 61 and i ~= 235 and i ~= 587 and i ~= 613 and i ~= 620 and i ~= 630 and i ~= 648 and i ~= 662 and i ~= 666 and i ~= 718 and i ~= CollectibleType.COLLECTIBLE_BOOK_OF_BOOKS then
			if Isaac.GetItemConfig():GetCollectible(i).Tags & ItemConfig.TAG_BOOK == ItemConfig.TAG_BOOK then
				player:UseActiveItem(i, false, false, true, true, -1)
			end
		end
	end
	if GiantBookAPI then
		GiantBookAPI.playGiantBook("Appear", "books.png", Color(1, 1, 1, 1, 0, 0, 0), Color(1, 1, 1, 1, 0, 0, 0), Color(1, 1, 1, 1, 0, 0, 0), SoundEffect.SOUND_BOOK_PAGE_TURN_12, false)
	end
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBookOfBooks, CollectibleType.COLLECTIBLE_BOOK_OF_BOOKS)