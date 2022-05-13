local mod = Furtherance
local game = Game()

function mod:UseEssenceOfLove(card, player, flag)
    
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfLove, OBJ_ESSENCE_OF_LOVE)