local mod = Furtherance
local game = Game()

function mod:UseApocalypse(_, _, player)
    local data = player:GetData()
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_APOCALYPSE)
    if player:GetCollectibleCount() > 0 then
        data.ApocalypseItem = 0
        for i = 1, CollectibleType.NUM_COLLECTIBLES do
            while player:HasCollectible(i) do
                player:RemoveCollectible(i, false, ActiveSlot.SLOT_PRIMARY, true)
                data.ApocalypseItem = data.ApocalypseItem + 1
            end
        end
        print("Removed All Items")
        print(data.ApocalypseItem)
    end

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseApocalypse, CollectibleType.COLLECTIBLE_APOCALYPSE)
