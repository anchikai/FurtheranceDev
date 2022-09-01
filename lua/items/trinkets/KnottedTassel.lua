local mod = Furtherance

function mod:FireKnottedTasselTear(tear)
    local player = mod:GetPlayerFromTear(tear)
    if player and player:HasTrinket(TrinketType.TRINKET_KNOTTED_TASSEL) then
        local rng = player:GetTrinketRNG(TrinketType.TRINKET_KNOTTED_TASSEL)

        local chance = 0.05
        if player:HasTrinket(TrinketType.TRINKET_TEARDROP_CHARM) then
            chance = 1 - (1 - chance) ^ 2
        end

        if rng:RandomFloat() <= chance then
            tear.TearFlags = tear.TearFlags | TearFlags.TEAR_BAIT
            tear:SetColor(Color(0.7, 0.14, 0.1, 1, 0.3, 0, 0), 0, 0, false, false)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireKnottedTasselTear)