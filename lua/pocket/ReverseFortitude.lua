local mod = Furtherance

function mod:UseReverseFortitude(card, player, flag)
	player:UseActiveItem(CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS, false, false, false, false, -1)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseReverseFortitude, CARD_REVERSE_FORTITUDE)