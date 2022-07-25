local mod = Furtherance

function mod:RandomRune(entity)
    local player = entity:ToPlayer()
    if player:HasCollectible(CollectibleType.COLLECTIBLE_MOLTEN_GOLD) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MOLTEN_GOLD)
        if rng:RandomFloat() <= 0.25 then
            player:UseCard(rng:RandomInt(8)+32, 771)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.RandomRune, EntityType.ENTITY_PLAYER)