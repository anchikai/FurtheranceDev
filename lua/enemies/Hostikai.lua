local mod = Furtherance
local rng = RNG()

function mod:Hostikai(entity)
	local sprite = entity:GetSprite()
	if rng:RandomFloat() <= 0.1 then
		sprite:ReplaceSpritesheet(0, "gfx/monsters/hostikai.png")
		sprite:LoadGraphics()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_INIT, mod.Hostikai, EntityType.ENTITY_HOST)