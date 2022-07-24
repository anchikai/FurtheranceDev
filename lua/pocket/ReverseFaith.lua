local mod = Furtherance

function mod:UseReverseFaith(card, player, flag)
	
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseReverseFaith, CARD_REVERSE_FAITH)