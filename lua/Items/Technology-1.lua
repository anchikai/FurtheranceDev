local mod = further

function mod:Minus1Shots(EntityTear)
    local player = EntityTear.Parent:ToPlayer()
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1)) then -- double check the tear belongs to a player	
		local FireDir = player:GetAimDirection()
		player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, -FireDir, true, false, player, 1)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.Minus1Shots, CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1)

function mod:Minus1LaserShots(EntityLaser)
    local player = EntityLaser.Parent:ToPlayer()
	if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1)) then -- double check the laser belongs to a player	
		local FireDir = player:GetAimDirection()
		player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, -FireDir, true, false, player, 1)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_INIT, mod.Minus1LaserShots, CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1)