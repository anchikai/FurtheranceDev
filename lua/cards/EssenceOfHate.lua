local mod = Furtherance
local game = Game()

function mod:UseEssenceOfHate(card, player, flag)
    
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfHate, OBJ_ESSENCE_OF_HATE)