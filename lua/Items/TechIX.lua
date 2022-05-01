local mod = Furtherance

function mod:IXShots(EntityTear)
    local player = EntityTear.Parent:ToPlayer()
    if (player and (player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) or player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA)) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- [[BIG SHOT]] synergies
		player:FireTechXLaser(EntityTear.Position, EntityTear.Velocity, 40, player, 0.66)
		EntityTear:Remove()
	elseif (player and player:HasCollectible(CollectibleType.COLLECTIBLE_VESTA) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- Vesta Synergy
		player:FireTechXLaser(EntityTear.Position, EntityTear.Velocity, 1, player, 0.66)
		EntityTear:Remove()
	elseif (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- Pharoh Cat Synergy
		if player:GetFireDirection() == 0 then
			player:FireTechXLaser(EntityTear.Position, EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(20,5), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(20,-5), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(30,-10), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(30,10), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(30,0), EntityTear.Velocity, 10, player, 0.66)
			EntityTear:Remove()
		elseif player:GetFireDirection() == 1 then
			player:FireTechXLaser(EntityTear.Position, EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-5,20), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(5,20), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(10,30), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-10,30), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(0,30), EntityTear.Velocity, 10, player, 0.66)
			EntityTear:Remove()
		elseif player:GetFireDirection() == 2 then
			player:FireTechXLaser(EntityTear.Position, EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-20,-5), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-20,5), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-30,10), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-30,-10), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-30,0), EntityTear.Velocity, 10, player, 0.66)
			EntityTear:Remove()
		elseif player:GetFireDirection() == 3 then
			player:FireTechXLaser(EntityTear.Position, EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(5,-20), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-5,-20), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(-10,-30), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(10,-30), EntityTear.Velocity, 10, player, 0.66)
			player:FireTechXLaser(EntityTear.Position+Vector(0,-30), EntityTear.Velocity, 10, player, 0.66)
			EntityTear:Remove()
		end
	elseif (player and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- double check the tear belongs to a player	
		player:FireTechXLaser(EntityTear.Position, EntityTear.Velocity, 10, player, 0.66)
		EntityTear:Remove()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.IXShots)

function mod:GetTechIX(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX) then
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 5
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetTechIX)