local mod = Furtherance

function mod:UseEssenceOfBravery(card, player, flag)
    local data = mod:GetData(player)
    data.OldMoveSpeed = 1
    data.UsedBravery = true
    data.BraveryBuff = 1.5
    local AriesWisp = player:AddItemWisp(CollectibleType.COLLECTIBLE_ARIES, Vector(999999, 999999), false)
    AriesWisp.Target = AriesWisp
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfBravery, RUNE_ESSENCE_OF_BRAVERY)

function mod:BraverySpeed(player)
    local data = mod:GetData(player)
    player:EvaluateItems()
    if data.UsedBravery then
        player.MoveSpeed = data.OldMoveSpeed + data.BraveryBuff
        data.BraveryBuff = data.BraveryBuff - 0.001
    end
    if data.BraveryBuff and data.BraveryBuff <= 0 then
        data.UsedBravery = false
        data.BraveryBuff = nil
        player.MoveSpeed = data.OldMoveSpeed
        for _, wisp in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)) do
            if wisp.Target ~= nil then
                wisp:Remove()
                wisp:Kill()
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BraverySpeed)