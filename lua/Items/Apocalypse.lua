local mod = Furtherance
local game = Game()

function mod:UseApocalypse(_, _, player)
    local data = player:GetData()
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_APOCALYPSE)
    if player:GetCollectibleCount() > 0 then
        data.ApocalypseItemCount = 0
        data.ApocalypseItem = 0
        repeat
            if player:HasCollectible(data.ApocalypseItemCount) then
                repeat
                    player:RemoveCollectible(data.ApocalypseItemCount, false, ActiveSlot.SLOT_PRIMARY, true)
                until
                    player:HasCollectible(data.ApocalypseItemCount) == false
                end
                data.ApocalypseItem = data.ApocalypseItem + 1
            end
            data.ApocalypseItemCount = data.ApocalypseItemCount + 1
        until data.ApocalypseItemCount == Isaac.GetItemConfig():GetCollectibles().Size -1
            print("Removed All Items")
            print(data.ApocalypseItem)
        end
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseApocalypse, CollectibleType.COLLECTIBLE_APOCALYPSE)