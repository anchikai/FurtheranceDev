local mod = Furtherance

function mod:UseHope(card, player, flag)
	
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseHope, CARD_HOPE)