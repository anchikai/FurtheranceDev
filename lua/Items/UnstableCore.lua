local mod = Furtherance

function mod:HasCore(boi, rng, player, useFlags, slot, data)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_UNSTABLE_CORE) and useFlags == UseFlag.USE_OWNED then
		Game():Spawn(1000, 12, player.Position, Vector(0, 0), nil, 23, Game():GetRoom():GetSpawnSeed())
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