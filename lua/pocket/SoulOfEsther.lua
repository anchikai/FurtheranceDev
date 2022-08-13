local mod = Furtherance
local game = Game()

function mod:UseSoulOfEsther(card, player, flag)
	
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfEsther, RUNE_SOUL_OF_ESTHER)