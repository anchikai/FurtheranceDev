local mod = Furtherance

function mod:UseEssenceOfDeath(card, player, flag)
    local Killed = 0
    mod:PlaySND(OBJ_ESSENCE_OF_DEATH_SFX)
    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() and entity:IsBoss() == false then
            entity:Kill()
            Killed = Killed + 1
        end
    end
    for i = 1, Killed do
        player:AddSwarmFlyOrbital(player.Position)
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfDeath, OBJ_ESSENCE_OF_DEATH)