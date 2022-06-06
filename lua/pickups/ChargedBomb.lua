local mod = Furtherance
local rng = RNG()
local processedBombs = {}

function mod:SpawnGoldenSack(entityType, variant, subType, _, _, _, seed)
    if entityType == EntityType.ENTITY_PICKUP and variant == PickupVariant.PICKUP_BOMB and subType == BombSubType.BOMB_NORMAL and processedBombs[seed] == nil then
        processedBombs[seed] = true
        if rng:RandomFloat() <= 0.02 then
            return { entityType, variant, BombSubType.BOMB_CHARGED, seed }
        end
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.SpawnGoldenSack)

function mod:ResetProcessedBombs()
    for seed in pairs(processedBombs) do
        processedBombs[seed] = nil
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ResetProcessedBombs)

function mod:ChargedBomb(pickup, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		if pickup.SubType == BombSubType.BOMB_CHARGED then
			pickup:GetSprite():Play("Collect", true)
			pickup:Die()
			SFXManager():Play(SoundEffect.SOUND_FETUS_FEET, 1, 0, false)
			player:AddBombs(1)
			player:FullCharge(ActiveSlot.SLOT_PRIMARY, false)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.ChargedBomb, PickupVariant.PICKUP_BOMB)