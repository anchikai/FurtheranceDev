local mod = Furtherance
local game = Game()

function mod:UseEssenceOfLove(card, player, flag)
    for i, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() and entity:IsBoss() == false then
            entity:AddCharmed(EntityRef(player), -1)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfLove, OBJ_ESSENCE_OF_LOVE)