local mod = Furtherance
local game = Game()

function mod:UseSoulOfPeter(card, player, flag)
	
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfPeter, RUNE_SOUL_OF_PETER)