local mod = Furtherance
local game = Game()

FractureRoomCount = 6
function mod:FlippingLogic()
    local room = game:GetRoom()
    if room:IsFirstVisit() then
        FractureRoomCount = FractureRoomCount + 1
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.FlippingLogic)

function mod:ResetCounter(continued)
    if continued == false then
        FractureRoomCount = 6
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetCounter)

function mod:AcutalFlippage(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_PETERS_BLOODY_FRACTURE) and FractureRoomCount == 6 then
        FractureRoomCount = 0
        player:UseActiveItem(CollectibleType.COLLECTIBLE_MUDDLED_CROSS, false, false, true, false, -1)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.AcutalFlippage)