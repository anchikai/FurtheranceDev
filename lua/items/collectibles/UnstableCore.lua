local mod = Furtherance
local game = Game()

function mod:HasCore(_, _, player, useFlags)
	local room = game:GetRoom()
	if player:HasCollectible(CollectibleType.COLLECTIBLE_UNSTABLE_CORE) and useFlags == UseFlag.USE_OWNED then
		game:Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TEAR_POOF_A, player.Position, Vector.Zero, nil, 23, room:GetSpawnSeed())
		SFXManager():Play(SoundEffect.SOUND_LASERRING_WEAK)
		for _, enemies in pairs(Isaac.FindInRadius(player.Position, 66)) do
			if enemies:IsVulnerableEnemy() and enemies:IsActiveEnemy() and EntityRef(enemies).IsCharmed == false then
				enemies:AddBurn(EntityRef(enemies), 90, 5)
				return true
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.HasCore)