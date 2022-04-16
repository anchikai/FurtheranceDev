local mod = further
local game = Game()

function mod:PyramidShots(EntityTear)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT)) then -- double check the tear belongs to a player	
			if EntityTear.FrameCount == 1 and EntityTear.Parent and EntityTear.Parent:ToPlayer() and not EntityTear:GetData().isExtraEntityTear then
				if player:GetFireDirection() == 0 then
					local left1 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(20,5), EntityTear.Velocity, true, false, true, player, 1) 
					local left2 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(20,-5), EntityTear.Velocity, true, false, true, player, 1)
					local left3 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(30,-10), EntityTear.Velocity, true, false, true, player, 1)
					local left4 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(30,10), EntityTear.Velocity, true, false, true, player, 1)
					local left5 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(30,0), EntityTear.Velocity, true, false, true, player, 1)
					left1:GetData().isExtraEntityTear = true
					left2:GetData().isExtraEntityTear = true
					left3:GetData().isExtraEntityTear = true
					left4:GetData().isExtraEntityTear = true
					left5:GetData().isExtraEntityTear = true
				elseif player:GetFireDirection() == 1 then
					local up1 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-5,20), EntityTear.Velocity, true, false, true, player, 1) 
					local up2 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(5,20), EntityTear.Velocity, true, false, true, player, 1)
					local up3 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(10,30), EntityTear.Velocity, true, false, true, player, 1)
					local up4 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-10,30), EntityTear.Velocity, true, false, true, player, 1)
					local up5 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(0,30), EntityTear.Velocity, true, false, true, player, 1)
					up1:GetData().isExtraEntityTear = true
					up2:GetData().isExtraEntityTear = true
					up3:GetData().isExtraEntityTear = true
					up4:GetData().isExtraEntityTear = true
					up5:GetData().isExtraEntityTear = true
				elseif player:GetFireDirection() == 2 then
					local right1 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-20,-5), EntityTear.Velocity, true, false, true, player, 1) 
					local right2 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-20,5), EntityTear.Velocity, true, false, true, player, 1)
					local right3 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-30,10), EntityTear.Velocity, true, false, true, player, 1)
					local right4 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-30,-10), EntityTear.Velocity, true, false, true, player, 1)
					local right5 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-30,0), EntityTear.Velocity, true, false, true, player, 1)
					right1:GetData().isExtraEntityTear = true
					right2:GetData().isExtraEntityTear = true
					right3:GetData().isExtraEntityTear = true
					right4:GetData().isExtraEntityTear = true
					right5:GetData().isExtraEntityTear = true
				elseif player:GetFireDirection() == 3 then
					local down1 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(5,-20), EntityTear.Velocity, true, false, true, player, 1) 
					local down2 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-5,-20), EntityTear.Velocity, true, false, true, player, 1)
					local down3 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(-10,-30), EntityTear.Velocity, true, false, true, player, 1)
					local down4 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(10,-30), EntityTear.Velocity, true, false, true, player, 1)
					local down5 = EntityTear.Parent:ToPlayer():FireTear(EntityTear.Position+Vector(0,-30), EntityTear.Velocity, true, false, true, player, 1)
					down1:GetData().isExtraEntityTear = true
					down2:GetData().isExtraEntityTear = true
					down3:GetData().isExtraEntityTear = true
					down4:GetData().isExtraEntityTear = true
					down5:GetData().isExtraEntityTear = true
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.PyramidShots)

function mod:PyramidLasers(EntityLaser)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT)) then -- double check the laser belongs to a player
			if EntityLaser.FrameCount == 1 and player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then -- brimstone synergy
				if player:GetHeadDirection() == 0 then
					player:FireBrimstone(player:GetAimDirection()+Vector(-90,45), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(-90,-45), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(-90,22.5), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(-90,-22.5), player, 1)
				elseif player:GetHeadDirection() == 1 then
					player:FireBrimstone(player:GetAimDirection()+Vector(-45,-90), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(45,-90), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(-22.5,-90), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(22.5,-90), player, 1)
				elseif player:GetHeadDirection() == 2 then
					player:FireBrimstone(player:GetAimDirection()+Vector(90,-45), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(90,45), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(90,-22.5), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(90,22.5), player, 1)
				elseif player:GetHeadDirection() == 3 then
					player:FireBrimstone(player:GetAimDirection()+Vector(45,90), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(-45,90), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(22.5,90), player, 1)
					player:FireBrimstone(player:GetAimDirection()+Vector(-22.5,90), player, 1)
				end
			end
			if EntityLaser.FrameCount == 1 and (player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X)) then -- tech 1, tech 2 & tech x synergy
				if player:GetHeadDirection() == 0 then
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-90,45), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-90,-45), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-90,22.5), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-90,-22.5), false, false, player, 1)
				elseif player:GetHeadDirection() == 1 then
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-45,-90), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(45,-90), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-22.5,-90), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(22.5,-90), false, false, player, 1)
				elseif player:GetHeadDirection() == 2 then
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(90,45), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(90,-45), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(90,22.5), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(90,-22.5), false, false, player, 1)
				elseif player:GetHeadDirection() == 3 then
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-45,90), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(45,90), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(-22.5,90), false, false, player, 1)
					player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, player:GetAimDirection()+Vector(22.5,90), false, false, player, 1)
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, mod.PyramidLasers)

function mod:PyramidBombs(EntityBomb)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT)) then -- double check the bomb belongs to a player	
			if player:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) then
				if player:GetFireDirection() == 0 then
					player:FireTear(EntityBomb.Position+Vector(-30,0), EntityBomb.Velocity, true, false, true, player, 1) 
				elseif player:GetFireDirection() == 1 then
					player:FireTear(EntityBomb.Position+Vector(0,-30), EntityBomb.Velocity, true, false, true, player, 1)
				elseif player:GetFireDirection() == 2 then
					player:FireTear(EntityBomb.Position+Vector(30,0), EntityBomb.Velocity, true, false, true, player, 1) 
				elseif player:GetFireDirection() == 3 then
					player:FireTear(EntityBomb.Position+Vector(0,30), EntityBomb.Velocity, true, false, true, player, 1)
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, mod.PyramidBombs)

function mod:GetPharohCat(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) then
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 20
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetPharohCat)