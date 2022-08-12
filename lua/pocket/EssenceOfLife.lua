local mod = Furtherance

function mod:UseEssenceOfLife(card, player, flag)
    mod:PlaySND(OBJ_ESSENCE_OF_LIFE_SFX)
	for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
    	    player:AddMinisaac(entity.Position, true)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfLife, OBJ_ESSENCE_OF_LIFE)