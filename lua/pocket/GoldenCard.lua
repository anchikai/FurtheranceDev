local mod = Furtherance
local game = Game()

local allCards = {
	Card.CARD_FOOL,
	Card.CARD_MAGICIAN,
	Card.CARD_HIGH_PRIESTESS,
	Card.CARD_EMPRESS,
	Card.CARD_EMPEROR,
	Card.CARD_HIEROPHANT,
	Card.CARD_LOVERS,
	Card.CARD_CHARIOT,
	Card.CARD_JUSTICE,
	Card.CARD_HERMIT,
	Card.CARD_WHEEL_OF_FORTUNE,
	Card.CARD_STRENGTH,
	Card.CARD_HANGED_MAN,
	Card.CARD_DEATH,
	Card.CARD_TEMPERANCE,
	Card.CARD_DEVIL,
	Card.CARD_TOWER,
	Card.CARD_STARS,
	Card.CARD_MOON,
	Card.CARD_SUN,
	Card.CARD_JUDGEMENT,
	Card.CARD_WORLD,
	Card.CARD_CLUBS_2,
	Card.CARD_DIAMONDS_2,
	Card.CARD_SPADES_2,
	Card.CARD_HEARTS_2,
	Card.CARD_ACE_OF_CLUBS,
	Card.CARD_ACE_OF_DIAMONDS,
	Card.CARD_ACE_OF_SPADES,
	Card.CARD_ACE_OF_HEARTS,
	Card.CARD_JOKER,
	Card.CARD_CHAOS,
	Card.CARD_CREDIT,
	Card.CARD_RULES,
	Card.CARD_HUMANITY,
	Card.CARD_SUICIDE_KING,
	Card.CARD_GET_OUT_OF_JAIL,
	Card.CARD_QUESTIONMARK,
	Card.CARD_EMERGENCY_CONTACT,
	Card.CARD_HOLY,
	Card.CARD_HUGE_GROWTH,
	Card.CARD_ANCIENT_RECALL,
	Card.CARD_ERA_WALK,
	Card.CARD_REVERSE_FOOL,
	Card.CARD_REVERSE_MAGICIAN,
	Card.CARD_REVERSE_HIGH_PRIESTESS,
	Card.CARD_REVERSE_EMPRESS,
	Card.CARD_REVERSE_EMPEROR,
	Card.CARD_REVERSE_HIEROPHANT,
	Card.CARD_REVERSE_LOVERS,
	Card.CARD_REVERSE_CHARIOT,
	Card.CARD_REVERSE_JUSTICE,
	Card.CARD_REVERSE_HERMIT,
	Card.CARD_REVERSE_WHEEL_OF_FORTUNE,
	Card.CARD_REVERSE_STRENGTH,
	Card.CARD_REVERSE_HANGED_MAN,
	Card.CARD_REVERSE_DEATH,
	Card.CARD_REVERSE_TEMPERANCE,
	Card.CARD_REVERSE_DEVIL,
	Card.CARD_REVERSE_TOWER,
	Card.CARD_REVERSE_STARS,
	Card.CARD_REVERSE_MOON,
	Card.CARD_REVERSE_SUN,
	Card.CARD_REVERSE_JUDGEMENT,
	Card.CARD_REVERSE_WORLD,
	Card.CARD_QUEEN_OF_HEARTS,
	Card.CARD_WILD,

	-- Furtherance Cards
	CARD_TWO_OF_SHIELDS,
	CARD_ACE_OF_SHIELDS,
	CARD_TRAP,
	CARD_KEY,
	CARD_GOLDEN,
	CARD_HOPE,
	CARD_REVERSE_HOPE,
	CARD_FAITH,
	CARD_REVERSE_FAITH,
	CARD_CHARITY,
	CARD_REVERSE_CHARITY,
}

local allCardsSet = {}
for _, card in ipairs(allCardsSet) do
    allCardsSet[card] = true
end

local function pickCard(rng)
    return allCards[rng:RandomInt(#allCards) + 1]
end

local processedCards = {}

local skullGridIndex = nil
function mod:SpawnGoldenCard(entityType, variant, subtype, position, _, spawner, seed)
    if processedCards[seed] then return end
    -- has to be a card that is a tarot card
    if entityType ~= EntityType.ENTITY_PICKUP or variant ~= PickupVariant.PICKUP_TAROTCARD or not allCardsSet[subtype] then return end

    -- spawner cannot be the player
    if spawner ~= nil and spawner.Type == EntityType.ENTITY_PLAYER then return end

    local room = game:GetRoom()
    local index = room:GetGridIndex(position)
    if index == skullGridIndex then return end

    local rng = RNG()
    rng:SetSeed(seed, 1)
    if rng:RandomFloat() <= 0.025 then
        processedCards[seed] = true
        return { entityType, variant, CARD_GOLDEN, seed }
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.SpawnGoldenCard)

function mod:ClearProcessedCards()
    for k in pairs(processedCards) do
        processedCards[k] = nil
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ClearProcessedCards)

function mod:UseGoldCard(card, player, flags)
    local rng = player:GetCardRNG(CARD_GOLDEN)
    if rng:RandomFloat() <= 0.5 then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_BLANK_CARD) == false then
            player:AddCard(CARD_GOLDEN)
        end
    end
    player:UseCard(pickCard(rng), UseFlag.USE_NOANIM)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseGoldCard, CARD_GOLDEN)

function mod:CheckForFoolCard()
    -- only check in depths II
    if game:GetLevel():GetStage() ~= LevelStage.STAGE3_2 then return end

    local room = Game():GetRoom()
    for i = 1, room:GetGridSize() do
        local gridEntity = room:GetGridEntity(i)
        if gridEntity ~= nil and gridEntity:GetType() == GridEntityType.GRID_ROCK_ALT2 then
            skullGridIndex = i
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.CheckForFoolCard)