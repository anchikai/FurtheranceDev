local mod = Furtherance
local game = Game()

local SplitTearFlags = TearFlags.TEAR_SPLIT | TearFlags.TEAR_QUADSPLIT | TearFlags.TEAR_BURSTSPLIT

-- positional offset from original tear when shot to the right
local TearPositions = {
	Vector(-20, -5),
	Vector(-20, 5),
	Vector(-30, 10),
	Vector(-30, -10),
	Vector(-30, 0),
}

function mod:PyramidTears(tear)
	if tear.FrameCount ~= 1 or mod:GetData(tear).isExtraEntityTear then return end

	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) then return end

	local direction = tear.Velocity:GetAngleDegrees()
	for _, position in ipairs(TearPositions) do
		local extraTear = player:FireTear(tear.Position + position:Rotated(direction), tear.Velocity, true, false, true, player, 1)
		extraTear:ClearTearFlags(SplitTearFlags)
		mod:GetData(extraTear).isExtraEntityTear = true
	end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.PyramidTears)

-- directional offset from original direction when shot to the right
local LaserDirections = {
	Vector(4, 2),
	Vector(4, -2),
	Vector(4, 1),
	Vector(4, -1),
}

function mod:PyramidLasers(laser)
	if laser.FrameCount ~= 1 then return end

	local player = laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer()
	if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) then return end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_BRIMSTONE) then -- brimstone synergy
		for _, direction in ipairs(LaserDirections) do
			player:FireBrimstone(direction:Rotated(laser.AngleDegrees), player, 1)
		end
	elseif (player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) or player:HasCollectible(CollectibleType.COLLECTIBLE_TECH_X)) then -- tech 1, tech 2 & tech x synergy
		for _, direction in ipairs(LaserDirections) do
			player:FireTechLaser(player.Position, LaserOffset.LASER_TECH1_OFFSET, direction:Rotated(laser.AngleDegrees), false, false, player, 1)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, mod.PyramidLasers)

function mod:PyramidBombs(bomb)
	local player = bomb.SpawnerEntity and bomb.SpawnerEntity:ToPlayer()
	if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) then return end

	if player:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) then
		local direction = bomb.Velocity:GetAngleDegrees()
		player:FireTear(bomb.Position + Vector(30, 0):Rotated(direction), bomb.Velocity, true, false, true, player, 1)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_BOMB_INIT, mod.PyramidBombs)

function mod:PharaohCatDebuff(player, cacheFlag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) then
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 20
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.PharaohCatDebuff)
