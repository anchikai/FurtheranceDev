local mod = Furtherance
local game = Game()
local WhereAmI = Isaac.GetChallengeIdByName("Where am I?")

function mod:RandomStage(player)
    local level = game:GetLevel()
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ALTERNATE_REALITY)
    local sprite = player:GetSprite()
    if Isaac.GetChallenge() == WhereAmI then
        if sprite:IsPlaying("Trapdoor") and sprite:GetFrame() == 15 then
            level:SetStage(rng:RandomInt(7)+1, rng:RandomInt(3))
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mod.RandomStage)