local mod = Furtherance

local possibleCards = {
    Card.CARD_CREDIT,
    Card.CARD_HUMANITY,
    Card.CARD_GET_OUT_OF_JAIL,
    Card.CARD_HOLY,
    Card.CARD_WILD,
    Card.CARD_EMERGENCY_CONTACT,
    Card.CARD_DICE_SHARD,
    Card.CARD_CRACKED_KEY
}

function mod:SetDadsWalletData(player)
    local data = mod:GetData(player)
    data.OldDadsWalletCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DADS_WALLET)
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.SetDadsWalletData)

function mod:GiveCardsOnPickUp(player)
    if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then
        return
    end
    local data = mod:GetData(player)
    local newDadsWalletCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DADS_WALLET)
    if data.OldDadsWalletCount == nil then
        data.OldDadsWalletCount = newDadsWalletCount
        return
    end
    if data.OldDadsWalletCount == newDadsWalletCount then return end

    local delta = newDadsWalletCount - data.OldDadsWalletCount
    data.OldDadsWalletCount = newDadsWalletCount

    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_DADS_WALLET)
    for _ = 1, delta do
        local choice1 = rng:RandomInt(#possibleCards) + 1
        local card1 = table.remove(possibleCards, choice1)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, card1, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)

        local choice2 = rng:RandomInt(#possibleCards) + 1
        local card2 = possibleCards[choice2]
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TAROTCARD, card2, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)

        table.insert(possibleCards, card1)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.GiveCardsOnPickUp)