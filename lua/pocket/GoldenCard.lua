local mod = Furtherance
local game = Game()
local rng = RNG()

local function isCard(num)
    return num < 32 or (num > 41 and num ~= 55 and num <= 80)
end

local allCards = {}
for i = 1, 80 do
    if isCard(i) then
        table.insert(allCards, i)
    end
end

local function pickCard()
    return allCards[rng:RandomInt(#allCards) + 1]
end

function mod:UseGoldCard(card, player, flags)
    if rng:RandomFloat() <= 0.5 then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BLANK_CARD) then
            player:SetCard(0, 0)
        else
            player:AddCard(CARD_GOLDEN)
        end
    end
    player:UseCard(pickCard(), UseFlag.USE_NOANIM)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseGoldCard, CARD_GOLDEN)