local mod = Furtherance
local game = Game()
local WhereAmI = Isaac.GetChallengeIdByName("Where am I?")

local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

function mod:RandomStage(player)
    local level = game:GetLevel()
    local room = game:GetRoom()
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ALTERNATE_REALITY)
    if Isaac.GetChallenge() == WhereAmI then
       if room:GetType() == RoomType.ROOM_BOSS and room:IsClear() and level:GetStage() < LevelStage.STAGE4_2 then
            if player.Position.X == clamp(player.Position.X, 297, 343) and player.Position.Y == clamp(player.Position.Y, 177, 223) and player:IsHoldingItem() == false then
                level:SetStage(rng:RandomInt(7)+1, rng:RandomInt(3))
            end
       end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.RandomStage)