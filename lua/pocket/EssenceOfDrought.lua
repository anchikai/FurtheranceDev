local mod = Furtherance
local game = Game()

function mod:UseEssenceOfDrought(card, player, flag)
    local room = game:GetRoom()
    room:StopRain()
    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() and entity:IsBoss() == false then
            entity:AddEntityFlags(EntityFlag.FLAG_BLEED_OUT | EntityFlag.FLAG_ICE)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfDrought, OBJ_ESSENCE_OF_DROUGHT)