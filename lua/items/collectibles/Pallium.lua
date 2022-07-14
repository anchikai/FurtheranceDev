local mod = Furtherance
local game = Game()

local runContinued = false
function mod:FuckYouAPI(continued)
    if continued then
        runContinued = true
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.FuckYouAPI)

function mod:StillFuckYouAPI(entity)
    if runContinued and entity.SubType == 100 then
        runContinued = false
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.StillFuckYouAPI, FamiliarVariant.MINISAAC)

function mod:ClearRoom()
    for p = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(p)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_PALLIUM) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PALLIUM)
            local rngMinisaac = rng:RandomInt(3) + 1
            for _ = 1, rngMinisaac do
                PalliumMinisaac = player:AddMinisaac(player.Position, true)
                PalliumMinisaac.SubType = 100
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.ClearRoom)

function mod:NewLevel()
    if not runContinued then
        for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.MINISAAC, 100)) do
            entity:Remove()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewLevel)