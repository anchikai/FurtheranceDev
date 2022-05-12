local mod = Furtherance
local game = Game()

function mod:UseSoulOfMiriam(card, player, flag)
	RainTimer = 1200
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfMiriam, RUNE_SOUL_OF_MIRIAM)

function mod:Rain(player)
    if RainTimer == nil then
        RainTimer = 0
	elseif RainTimer > 0 then
        RainTimer = RainTimer - 1
        if game:GetFrameCount()%15 == 0 then
            for i, entity in ipairs(Isaac.GetRoomEntities()) do
                if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
                    entity:TakeDamage(player.Damage*0.33, 0, EntityRef(player), 0)
                end
            end
        end
    end
    print(RainTimer)
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.Rain)