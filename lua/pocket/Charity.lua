local mod = Furtherance

function mod:UseCharity(card, player, flag)
	for _ = 1, 3 do
        player:UseActiveItem(CollectibleType.COLLECTIBLE_JAR_OF_MANNA, false, false, false, false, -1)
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseCharity, CARD_CHARITY)