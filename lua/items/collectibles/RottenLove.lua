local mod = Furtherance

function mod:SetRottenLoveData(player)
    local data = mod:GetData(player)
    data.OldRottenLoveCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ROTTEN_LOVE)
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.SetRottenLoveData)

function mod:GiveHeartsOnPickUp(player)
    if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then
        return
    end
    local data = mod:GetData(player)
    local newRottenLoveCount = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ROTTEN_LOVE)
    if data.OldRottenLoveCount == nil then
        data.OldRottenLoveCount = newRottenLoveCount
        return
    end

    if data.OldRottenLoveCount == newRottenLoveCount then return end

    local delta = newRottenLoveCount - data.OldRottenLoveCount
    data.OldRottenLoveCount = newRottenLoveCount

    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ROTTEN_LOVE)
    for _ = 1, delta do
        for _ = 1, rng:RandomInt(2)+2 do
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BONE, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
        end
        for _ = 1, rng:RandomInt(2)+2 do
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_ROTTEN, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.GiveHeartsOnPickUp)