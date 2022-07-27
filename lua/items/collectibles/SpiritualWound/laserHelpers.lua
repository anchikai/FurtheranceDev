local mod = Furtherance
local game = Game()

local SpiritualWoundSoundStart = Isaac.GetSoundIdByName("SpiritualWoundStart")
local SpiritualWoundSoundLoop = Isaac.GetSoundIdByName("SpiritualWoundLoop")

local function pureLerp(vector1, vector2, alpha)
	return vector1 * (1 - alpha) + vector2 * alpha
end

local LaserVariant = {
	BRIMSTONE = 1,
	TECHNOLOGY = 2,
	SHOOP_DA_WHOOP = 3,
	PRIDE = 4,
	LIGHT_BEAM = 5,
	MEGA_BLAST = 6,
	TRACTOR_BEAM = 7,
	LIGHT_RING = 8, -- crashes if you run this with homing
	BRIMTECH = 9,
	JACOBS_LADDER = 10,
	BIG_BRIMSTONE = 11,
	DIARRHEASTONE = 12,
	MEGA_BRIMTECH = 13,
	BIG_BRIMTECH = 14,
	BIGGER_BRIMTECH = 15,
}

local SpiritualWoundVariant = {
	NORMAL = LaserVariant.BRIMTECH,
	POLARITY_SHIFT = LaserVariant.JACOBS_LADDER
}

local laserHelpers = {}

local function spawnLaser(player, targetPosition)
	local data = mod:GetData(player)
	local itemData = data.SpiritualWound
	local woundVariant = itemData.LaserVariant

	-- Set laser start and end position
	local sourcePos = player.Position
	local laser = EntityLaser.ShootAngle(woundVariant, sourcePos, ((targetPosition - sourcePos):GetAngleDegrees()), 0, Vector(0, player.SpriteScale.Y * -32), player)
	laser:SetMaxDistance(sourcePos:Distance(targetPosition) + 50)


	if woundVariant == SpiritualWoundVariant.NORMAL then
		local color = Color(1, 1, 1, 1, 0, 0, 0)
		color:SetColorize(1, 1, 1, 1)
		color:SetOffset(0.5, 0.8, 1)
		laser:SetColor(color, 0, 1)
		laser.SpriteScale = Vector.One * 0.3
	elseif woundVariant == SpiritualWoundVariant.POLARITY_SHIFT then
		laser.SpriteScale = Vector.One * 2
	end

	laser.Mass = 0
	laser:AddTearFlags(TearFlags.TEAR_HOMING)
	laser.CollisionDamage = 0 -- they still do 0.1 damage...
	mod:GetData(laser).IsSpiritualWound = true

	return laser
end

function laserHelpers.spawnLasers(player, targetPosition, amount)
	local data = mod:GetData(player)
	local itemData = data.SpiritualWound
	itemData.OldLaserVariant = itemData.LaserVariant

	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)

	local lasers = {}
	for i = 1, amount do
		local positionOffset = 150 * Vector(rng:RandomFloat() - 0.5, rng:RandomFloat() - 0.5)
		lasers[i] = spawnLaser(player, targetPosition + positionOffset, itemData.LaserVariant)
	end

	return lasers
end

function laserHelpers.playLaserSounds()
    SFXManager():Play(SpiritualWoundSoundLoop, nil, nil, true)
	SFXManager():Play(SpiritualWoundSoundStart)
end

function laserHelpers.stopLaserSounds()
	SFXManager():Stop(SpiritualWoundSoundLoop)
end

local function updateLaser(player, laser, targetPosition, angleOffset)
	local newGoal = pureLerp(laser:GetEndPoint(), targetPosition, 0.4)
	local delta = newGoal - player.Position

	laser:SetMaxDistance(delta:Length() + 50)
	laser.AngleDegrees = delta:GetAngleDegrees() + angleOffset
	laser.EndPoint = EntityLaser.CalculateEndPoint(player.Position, delta, Vector(0, player.SpriteScale.Y * -32), player, 0)
	laser.TearFlags = laser.TearFlags | TearFlags.TEAR_HOMING
end

function laserHelpers.updateLasers(player, lasers, targetPosition)
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
	local data = mod:GetData(player)
	local itemData = data.SpiritualWound
	local laserVariant = itemData.LaserVariant

	if targetPosition == nil then
		error("arg 'targetPosition' is nil", 2)
	end

	if laserVariant == itemData.OldLaserVariant then -- update old lasers
		for _, laser in ipairs(lasers) do
			local positionOffset = 150 * Vector(rng:RandomFloat() - 0.5, rng:RandomFloat() - 0.5)
			local angleOffset = 40 * (rng:RandomFloat() - 0.5)
			updateLaser(player, laser, targetPosition + positionOffset, angleOffset)
		end

		return lasers
	else -- respawn lasers
		for _, laser in ipairs(lasers) do
			laser:Kill()
		end

		return laserHelpers.spawnLasers(player, targetPosition)
	end
end

function laserHelpers.stopLasers(lasers)
    for _, laser in ipairs(lasers) do
        laser:Die()
    end
    SFXManager():Stop(SpiritualWoundSoundLoop)
end

return laserHelpers