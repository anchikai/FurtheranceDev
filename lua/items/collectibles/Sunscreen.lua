local mod = Furtherance

function mod:SunscreenDamage(entity, amount, flag)
    local player = entity:ToPlayer()
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SUNSCREEN)
    if rng:RandomFloat() <= 0.25 and player:HasCollectible(CollectibleType.COLLECTIBLE_SUNSCREEN) and flag & DamageFlag.DAMAGE_FIRE == DamageFlag.DAMAGE_FIRE then
        player:ResetDamageCooldown()
        player:SetMinDamageCooldown(60)
        return false
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.SunscreenDamage, EntityType.ENTITY_PLAYER)