local mod = Furtherance
local game = Game()

function Shuffle(list)
	local size, shuffled  = #list, list
    for i = size, 2, -1 do
		local j = math.random(i)
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end
    return shuffled
end

function GetMaxCollectibleID()
    return Isaac.GetItemConfig():GetCollectibles().Size - 1
end

function mod:Duplicate(entity)
    local player = entity:ToPlayer()
    if player and player:HasTrinket(TrinketType.TRINKET_NIL_NUM) then
        local rng = player:GetTrinketRNG(TrinketType.TRINKET_NIL_NUM)
        if rng:RandomFloat() <= 0.02 then
            if player:GetCollectibleCount() > 0 then
                local playersItems = {}
                for item = 1, GetMaxCollectibleID() do
                    local itemConf = Isaac.GetItemConfig():GetCollectible(item)
                    if player:HasCollectible(item) and (itemConf.Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST) then
                        for i = 1, player:GetCollectibleNum(item, true) do
                            table.insert(playersItems, item)
                        end
                    end
                end
                playersItems = Shuffle(playersItems)
                if #playersItems > 0 then
                    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, playersItems[rng:RandomInt(#playersItems)+1], Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
                    player:TryRemoveTrinket(TrinketType.TRINKET_NIL_NUM)
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.Duplicate, EntityType.ENTITY_PLAYER)