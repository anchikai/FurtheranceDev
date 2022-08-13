local mod = Furtherance

function mod:UseEssenceOfBravery(card, player, flag)
    
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOf, RUNE_ESSENCE_OF_BRAVERY)