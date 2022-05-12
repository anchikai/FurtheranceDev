local mod = Furtherance

-- tear positions offset from original tear when shot to the right
local pharaohCatPositions = {
	Vector(0, 0),
	Vector(-20, -5),
	Vector(-20, 5),
	Vector(-30, 10),
	Vector(-30, -10),
	Vector(-30, 0),
}

function mod:IXShots(tear)
	local player = tear.Parent and tear.Parent:ToPlayer()
	if player == nil then return end

	if ((player:HasCollectible(CollectibleType.COLLECTIBLE_POLYPHEMUS) or player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA)) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- [[BIG SHOT]] synergies
		player:FireTechXLaser(tear.Position, tear.Velocity, 40, player, 0.66)
		tear:Remove()
	elseif (player:HasCollectible(CollectibleType.COLLECTIBLE_VESTA) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- Vesta Synergy
		player:FireTechXLaser(tear.Position, tear.Velocity, 1, player, 0.66)
		tear:Remove()
	elseif (player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) and player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- Pharaoh Cat Synergy
		local direction = tear.Velocity:GetAngleDegrees()
		player:FireTechXLaser(tear.Position, tear.Velocity, 10, player, 0.66)
		for _, position in ipairs(pharaohCatPositions) do
			player:FireTechXLaser(tear.Position + position:Rotated(direction), tear.Velocity, 10, player, 0.66)
		end
		tear:Remove()
	elseif (player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX)) then -- double check the tear belongs to a player
		player:FireTechXLaser(tear.Position, tear.Velocity, 10, player, 0.66)
		tear:Remove()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.IXShots)

function mod:TechIXDebuff(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_IX) then
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 5
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.TechIXDebuff)

function mod:TechIXColor(laser)
	local sprite = laser:GetSprite()
	sprite.Color = Color(0, 1, 0, 1, 0, 1, 0.6)
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_RENDER, mod.TechIXColor, 2)
