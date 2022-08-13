local mod = Furtherance
local game = Game()

function mod:RandomTechItem()
    for _, wisp in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.ITEM_WISP)) do
        local data = mod:GetData(wisp)
        if data.IsBI_84Wisp then
            wisp:Remove()
            wisp:Kill()
        end
    end
    for p = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(p)
        if player:HasTrinket(TrinketType.TRINKET_BI_84) then
            local rng = player:GetTrinketRNG(TrinketType.TRINKET_BI_84)
            local goldenbox = player:GetTrinketMultiplier(TrinketType.TRINKET_BI_84)
            if rng:RandomFloat() <= goldenbox * 0.25 then
                local ID
                repeat
                    ID = player:GetDropRNG():RandomInt(Isaac.GetItemConfig():GetCollectibles().Size - 1) + 1
                    local itemConfig = Isaac.GetItemConfig():GetCollectible(ID)
                until (itemConfig ~= nil and itemConfig.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST and itemConfig.Tags & ItemConfig.TAG_TECH == ItemConfig.TAG_TECH)

                local BI_84Wisp = player:AddItemWisp(ID, Vector(999999, 999999), false)
                local data = mod:GetData(BI_84Wisp)
                data.IsBI_84Wisp = true
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RandomTechItem)