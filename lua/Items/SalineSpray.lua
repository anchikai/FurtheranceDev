local mod = Furtherance
local game = Game()

---@param tear EntityTear
function mod:FireSalineSprayTear(tear)
    local player = tear.Parent:ToPlayer()
    if player and player:HasTrinket(TrinketType.TRINKET_SALINE_SPRAY) then
        local rng = player:GetTrinketRNG(TrinketType.TRINKET_SALINE_SPRAY)
        if rng:RandomFloat() <= 0.05 then
            tear.TearFlags = tear.TearFlags | TearFlags.TEAR_ICE
            tear:ChangeVariant(TearVariant.ICE)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireSalineSprayTear)