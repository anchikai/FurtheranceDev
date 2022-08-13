local mod = Furtherance

function mod:UseEssenceOfLife(card, player, flag)
	for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
    	    player:AddMinisaac(entity.Position, true)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseEssenceOfLife, RUNE_ESSENCE_OF_LIFE)