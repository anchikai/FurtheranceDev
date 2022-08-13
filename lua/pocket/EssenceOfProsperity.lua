local mod = Furtherance
local game = Game()

function mod:UseEssenceOfProsperity(card, player, flag)
	RainDamage = 15
    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
            Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RAIN_DROP, 0, entity.Position, Vector.Zero, player)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfProsperity, RUNE_ESSENCE_OF_PROSPERITY)

function mod:RainDmg(player)
    local level = game:GetLevel()
    if RainDamage == nil then
        RainDamage = -1
	elseif RainDamage > -1 then
        RainDamage = RainDamage - 1
        for i, entity in ipairs(Isaac.GetRoomEntities()) do
            if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() and RainDamage == 0 then
                entity:TakeDamage(player.Damage*0.66, 0, EntityRef(player), 0)
                entity:AddSlowing(EntityRef(player), 150, 0.5, Color(0, 0.5, 1, 1, 0, 0.04, 0.2))
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.RainDmg)

function mod:ResetProsperity(continued)
    if continued == false then
        RainDamage = -1
    end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetProsperity)