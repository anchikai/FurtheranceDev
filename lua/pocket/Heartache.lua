local mod = Furtherance
local game = Game()

function mod:HeartacheUp(pill, player, flags)
    player:AddBrokenHearts(1)
    player:AnimateSad()
end
mod:AddCallback(ModCallbacks.MC_USE_PILL, mod.HeartacheUp, PILLEFFECT_HEARTACHE_UP)

function mod:HeartacheDown(pill, player, flags)
    player:AddBrokenHearts(-1)
    player:AnimateHappy()
end
mod:AddCallback(ModCallbacks.MC_USE_PILL, mod.HeartacheDown, PILLEFFECT_HEARTACHE_DOWN)