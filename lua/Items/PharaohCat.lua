local mod = Furtherance
local game = Game()

-- positional offset from original tear when shot to the right
local TearPositions = {
	Vector(-20, -5),
	Vector(-20, 5),
	Vector(-30, 10),
	Vector(-30, -10),
	Vector(-30, 0),
}

local function firePharaohCatTears(player, tear)
	local data = mod:GetData(tear)
	local direction = tear.Velocity:GetAngleDegrees()
	for _, position in ipairs(TearPositions) do
		local extraTear = player:FireTear(tear.Position + position:Rotated(direction), tear.Velocity, true, false, true, player, 1)
		extraTear:SetColor(tear.Color, 0, 0, false, false)

		local extraData = mod:GetData(extraTear)
		extraData.AppliedTearFlags.PharaohCat = true
		extraData.AppliedTearFlags.Flux = data.AppliedTearFlags.Flux
	end
end

function mod:PyramidTears(tear)
	local data = mod:GetData(tear)
	if data.AppliedTearFlags == nil then
		data.AppliedTearFlags = {}
	end
	if tear.FrameCount ~= 1 or not data.FiredByPlayer or data.AppliedTearFlags.PharaohCat then return end

	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) then return end

	data.AppliedTearFlags.PharaohCat = true

	firePharaohCatTears(player, tear)
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.PyramidTears)

---@param player EntityPlayer
function mod:ForgorCat(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_PHARAOH_CAT) and player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN and player:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN_B then return end

	local b_left = Input.GetActionValue(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
	local b_right = Input.GetActionValue(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
	local b_up = Input.GetActionValue(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
	local b_down = Input.GetActionValue(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
	local isAttacking = (b_down + b_right + b_left + b_up) > 0

	if not isAttacking then return end

	local currentFired = game:GetFrameCount()
	local data = mod:GetData(player)
	if data.LastFired == nil then
		data.LastFired = -math.huge
	end

	if currentFired - data.LastFired < player.MaxFireDelay then return end
	data.LastFired = currentFired

	player:FireTear(player.Position, player:GetAimDirection() * 10 * player.ShotSpeed, true, false, true, player, 1)
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ForgorCat)

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
