local mod = Furtherance

function mod:UseEssenceOfBravery(card, player, flag)
    local data = mod:GetData(player)
    data.BraveryBuff = 1.25
    local AriesWisp = player:AddItemWisp(CollectibleType.COLLECTIBLE_ARIES, Vector(999999, 999999), false)
    local wispData = mod:GetData(AriesWisp)
    wispData.IsBraveryWisp = true
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfBravery, RUNE_ESSENCE_OF_BRAVERY)

function mod:BraverySpeed(player)
    local data = mod:GetData(player)
    if data.BraveryBuff == nil then return end

    player:AddCacheFlags(CacheFlag.CACHE_SPEED)
    player:EvaluateItems()

    data.BraveryBuff = math.max(data.BraveryBuff - 0.001, -0.25)
    if data.BraveryBuff > -0.25 then
        player.MoveSpeed = player.MoveSpeed + data.BraveryBuff
    else
        data.BraveryBuff = nil
        for _, wisp in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)) do
            local wispData = mod:GetData(wisp)
            if wispData.IsBraveryWisp then
                wisp:Remove()
                wisp:Kill()
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BraverySpeed)

function mod:MakeWispsGoToAlternateDimensionWhereYourMother()
    for _, wisp in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)) do
        local wispData = mod:GetData(wisp)
        if wispData.IsBraveryWisp then
            wisp.Position = Vector(999999, 999999)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.MakeWispsGoToAlternateDimensionWhereYourMother)