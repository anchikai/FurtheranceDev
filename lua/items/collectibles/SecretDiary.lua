local mod = Furtherance
local game = Game()

function mod:UseSecretDiary(_, _, player)
    -- No effect yet, come back later
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseSecretDiary, CollectibleType.COLLECTIBLE_SECRET_DIARY)