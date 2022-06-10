local mod = Furtherance

function mod:GlitchedPennyProc(coin, collider)
    local player = collider:ToPlayer()
    if player == nil or not player:HasTrinket(TrinketType.TRINKET_GLITCHED_PENNY) then return end

    local rng = player:GetTrinketRNG(TrinketType.TRINKET_GLITCHED_PENNY)
    if rng:RandomFloat() <= 0.25 and coin.SubType ~= CoinSubType.COIN_STICKYNICKEL then
        local ID
        repeat
            ID = player:GetDropRNG():RandomInt(Isaac.GetItemConfig():GetCollectibles().Size - 1) + 1
            local itemConfig = Isaac.GetItemConfig():GetCollectible(ID)
        until (itemConfig ~= nil and itemConfig.Type == ItemType.ITEM_ACTIVE and itemConfig.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST)
        player:UseActiveItem(ID, false, false, false, false)
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.GlitchedPennyProc, PickupVariant.PICKUP_COIN)