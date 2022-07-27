local mod = Furtherance

function mod:BlockShots(entity)
    local player = entity.SpawnerEntity:ToPlayer()
    if player:HasTrinket(TrinketType.TRINKET_PARASOL) then
        for _, tear in ipairs(Isaac.FindInRadius(entity.Position, 12, EntityPartition.BULLET)) do
            tear:Die()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.BlockShots)