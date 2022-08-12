local mod = Furtherance
local game = Game()
local WaterLoop = Isaac.GetSoundIdByName("FixYourFuckingAPI")

function mod:UseSoulOfMiriam(card, player, flag)
	RainTimer = 1200
    SFXManager():SetAmbientSound(WaterLoop, 1, 1)
    mod:PlaySND(RUNE_SOUL_OF_MIRIAM_SFX)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfMiriam, RUNE_SOUL_OF_MIRIAM)

function mod:Rain(player)
    local level = game:GetLevel()
    if RainTimer == nil then
        RainTimer = 0
	elseif RainTimer > 0 then
        RainTimer = RainTimer - 1
        if game:GetFrameCount()%15 == 0 then
            for i, entity in ipairs(Isaac.GetRoomEntities()) do
                if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
                    entity:TakeDamage(1+level:GetStage(), 0, EntityRef(player), 0)
                end
            end
        end
        --[[if game:GetFrameCount()%150 == 0 then
            SFXManager():Play(WaterLoop, 1, 2, true)
            print("Loop")
        end]]
        local room = game:GetRoom()
        Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.RAIN_DROP, 0, room:GetRandomPosition(0), Vector.Zero, nil)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.Rain)

function mod:ResetSoul(continued)
    if continued == false then
        RainTimer = 0
    end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetSoul)