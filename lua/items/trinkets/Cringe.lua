local mod = Furtherance
local game = Game()
local bruh = Isaac.GetSoundIdByName("Bruh")

function mod:CringeDMG(entity)
	local player = entity:ToPlayer()
	if player:HasTrinket(TrinketType.TRINKET_CRINGE, false) then
		SFXManager():Play(bruh)
		for e, entities in ipairs(Isaac.GetRoomEntities()) do
			entities:AddFreeze(EntityRef(player), 10)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.CringeDMG, EntityType.ENTITY_PLAYER)

function mod:HurtSound()
	if SFXManager():IsPlaying(bruh) == true then
		SFXManager():Stop(SoundEffect.SOUND_ISAAC_HURT_GRUNT)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.HurtSound)