local mod = Furtherance
local game = Game()

function mod:UseAlternateReality(_, _, player)
    local level = game:GetLevel()
    local data = mod:GetData(player)
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ALTERNATE_REALITY)
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_ALTERNATE_REALITY)
    level:SetStage(rng:RandomInt(11)+1, rng:RandomInt(3))
    player:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW, false, false, true, false, -1)
    data.ObervsUni = true
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseAlternateReality, CollectibleType.COLLECTIBLE_ALTERNATE_REALITY)

function mod:NewReality()
    local level = game:GetLevel()
    local room = game:GetRoom()
    for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        if data.ObervsUni == true then
            data.ObervsUni = false
            level.LeaveDoor = -1
            game:ChangeRoom(level:GetRandomRoomIndex(false, room:GetSpawnSeed()))
            level:ShowMap()
            level:ApplyBlueMapEffect()
            level:ApplyCompassEffect()
            level:ApplyMapEffect()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.NewReality)