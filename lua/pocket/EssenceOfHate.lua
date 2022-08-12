local mod = Furtherance

function mod:UseEssenceOfHate(card, player, flag)
    local BrokenHearts = 11 - player:GetBrokenHearts()
    player:AddBrokenHearts(11 - player:GetBrokenHearts())
    mod:PlaySND(OBJ_ESSENCE_OF_HATE_SFX)
    for i = 1, BrokenHearts do
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_NULL, 0, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player) 
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfHate, OBJ_ESSENCE_OF_HATE)