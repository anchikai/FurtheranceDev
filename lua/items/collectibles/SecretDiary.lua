local mod = Furtherance

function mod:UseSecretDiary(_, _, player)
    local BirthrightWisp = player:AddItemWisp(CollectibleType.COLLECTIBLE_BIRTHRIGHT, Vector(999999, 999999), false)
    BirthrightWisp.Target = player
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseSecretDiary, CollectibleType.COLLECTIBLE_SECRET_DIARY)

function mod:RemoveWisp()
    for _, wisp in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)) do
        if wisp.Target == player then
            wisp:Remove()
            wisp:Kill()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RemoveWisp)