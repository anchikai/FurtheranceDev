local mod = Furtherance
local game = Game()
local StaffActivate = Isaac.GetSoundIdByName("CaduceusActivate")

local Multiplier = 0.01
function mod:CaduceusDamage(entity)
    local player = entity:ToPlayer()
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_CADUCEUS_STAFF)
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_CADUCEUS_STAFF) then
        Multiplier = Multiplier * 2
        if rng:RandomFloat() <= Multiplier then
            Multiplier = 0.01
            SFXManager():Play(StaffActivate, 4)
            player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER)
            player:ResetDamageCooldown()
            player:SetMinDamageCooldown(60)
            return false
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.CaduceusDamage, EntityType.ENTITY_PLAYER)

function mod:ResetCounter(continued)
    if continued == false then
        Multiplier = 0.01
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetCounter)