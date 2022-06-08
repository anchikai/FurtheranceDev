local mod = Furtherance
local game = Game()

function mod:FireSalineSprayTear(tear)
    local player = tear.Parent:ToPlayer()
    if player and player:HasTrinket(TrinketType.TRINKET_SALINE_SPRAY) then
        local rng = player:GetTrinketRNG(TrinketType.TRINKET_SALINE_SPRAY)

        local chance = 0.05
        if player:HasTrinket(TrinketType.TRINKET_TEARDROP_CHARM) then
            chance = 1 - (1 - chance) ^ 2
        end

        if rng:RandomFloat() <= chance then
            tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ICE
            tear:ChangeVariant(TearVariant.ICE)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireSalineSprayTear)