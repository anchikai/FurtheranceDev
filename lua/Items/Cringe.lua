local mod = Furtherance
local game = Game()
local bruh = Isaac.GetSoundIdByName("Bruh")

function mod:CringeDMG()
	for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
		if player:HasTrinket(TrinketType.TRINKET_CRINGE, false) then
			SFXManager():Play(bruh)
			for e, entity in ipairs(Isaac.GetRoomEntities()) do
				entity:AddFreeze(EntityRef(player), 10)
			end
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