local mod = Furtherance
local game = Game()
local rng = RNG()

local function isCard(num)
    return (num < 32 or num > 41) and num ~= 55 and num ~= 78 and num ~= 80
        and num ~= RUNE_SOUL_OF_MIRIAM and num ~= RUNE_SOUL_OF_LEAH and num ~= RUNE_SOUL_OF_PETER
        and num ~= OBJ_ESSENCE_OF_LOVE and num ~= OBJ_ESSENCE_OF_HATE
        and num ~= OBJ_ESSENCE_OF_LIFE and num ~= OBJ_ESSENCE_OF_DEATH
        and num ~= OBJ_ESSENCE_OF_PROSPERITY and num ~= OBJ_ESSENCE_OF_DROUGHT

end

local allCards = {}
for i = 1, Isaac.GetItemConfig():GetCards().Size do
    if isCard(i) then
        table.insert(allCards, i)
    end
end

local function pickCard()
    return allCards[rng:RandomInt(#allCards) + 1]
end

local processedCards = {}

function mod:SpawnGoldenCard(entityType, variant, subtype, _, _, spawner, seed)
    local room = game:GetRoom()
    if isCard(subtype) and entityType == EntityType.ENTITY_PICKUP and variant == PickupVariant.PICKUP_TAROTCARD
    and (spawner == nil or spawner.Type ~= EntityType.ENTITY_PLAYER) and processedCards[seed] == nil and room:IsFirstVisit() then
        processedCards[seed] = true
        if rng:RandomFloat() <= 0.025 then
            return { entityType, variant, CARD_GOLDEN, seed }
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.SpawnGoldenCard)

function mod:ResetProcessedCards()
    for seed in pairs(processedCards) do
        processedCards[seed] = nil
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ResetProcessedCards)

function mod:UseGoldCard(card, player, flags)
    if rng:RandomFloat() <= 0.5 then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BLANK_CARD) == false then
            player:AddCard(CARD_GOLDEN)
        end
    end
    player:UseCard(pickCard(), UseFlag.USE_NOANIM)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseGoldCard, CARD_GOLDEN)