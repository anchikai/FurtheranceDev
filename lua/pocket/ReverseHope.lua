local mod = Furtherance
local rng = RNG()

function mod:UseReverseHope(card, player, flag)
	Isaac.ExecuteCommand("goto s.challenge."..rng:RandomInt(25))
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseReverseHope, CARD_REVERSE_HOPE)