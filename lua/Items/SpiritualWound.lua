local mod = Furtherance
local game = Game()

local EffectVariantTarget = Isaac.GetEntityVariantByName("Spiritual Wound Target")

local SpiritualWoundSoundStart = Isaac.GetSoundIdByName("SpiritualWoundStart")
local SpiritualWoundSoundLoop = Isaac.GetSoundIdByName("SpiritualWoundLoop")

local function pureLerp(v1, v2, a)
	return v1 * (1 - a) + v2 * a
end

---@param player EntityPlayer
---@return boolean
local function hasItem(player)
	return player ~= nil and (player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND) or player:GetName() == "MiriamB")
end

---@param player EntityPlayer
---@param canShoot boolean
local function setCanShoot(player, canShoot) -- Funciton Credit: im_tem
	local oldchallenge = game.Challenge

	game.Challenge = canShoot and Challenge.CHALLENGE_NULL or Challenge.CHALLENGE_SOLAR_SYSTEM
	player:UpdateCanShoot()
	game.Challenge = oldchallenge
end

---@param player EntityPlayer
function mod:GetSpiritualWound(player)
	if hasItem(player) then
		setCanShoot(player, false)
	else
		setCanShoot(player, true)
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetSpiritualWound)

local LaserHomingType = {
	NORMAL = 0,
	FREEZE = 1,
	FREEZE_HEAD = 2
}

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
	BLUE_LASER = 10,
	BIG_BRIMSTONE = 11,
	DIARRHEASTONE = 12,
	MEGA_BRIMTECH = 13,
	BIG_BRIMTECH = 14,
	BIGGER_BRIMTECH = 15,
}

---@param source Entity
---@param targetPos Vector
local function fireSpiritualWoundLaser(source, targetPos)
	local room = game:GetRoom()
	-- Set laser start and end position
	local sourcePos = source.Position
	local laser = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, sourcePos, ((targetPos - sourcePos):GetAngleDegrees()), 0, Vector(0, source.SpriteScale.Y * -32), source)
	laser:SetMaxDistance(sourcePos:Distance(targetPos) + 50)

	local color = Color(1, 1, 1, 1, 0, 0, 0)
	color:SetOffset(1, 0, 0)
	laser:SetColor(color, 0, 1)

	-- Extra parameters
	laser.SpriteScale = Vector.One * 0.3
	laser.Mass = 0
	laser:AddTearFlags(TearFlags.TEAR_HOMING)
	laser.CollisionDamage = 0.01 -- they still do 0.1 damage........
	mod:GetData(laser).IsSpiritualWound = true

	return laser
end

---@param laser EntityLaser
function mod:SpiritualWoundUpdate(laser)
	local data = mod:GetData(laser)
	if data.IsSpiritualWound then
		SFXManager():Stop(SoundEffect.SOUND_ANGEL_BEAM)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, mod.SpiritualWoundUpdate)

---@param laser EntityLaser
function mod:SpiritualWoundRender(laser)
	local data = mod:GetData(laser)
	if data.IsSpiritualWound then
		laser.SpriteScale = Vector.One * 0.3
	end
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_RENDER, mod.SpiritualWoundRender)

---@param player EntityPlayer
function mod:EnemyTethering(player)
	local data = mod:GetData(player)
	local room = game:GetRoom()

	if not hasItem(player) then return end

	local itemData = data.SpiritualWound
	if not itemData then
		itemData = {}
		data.SpiritualWound = itemData
	end
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)

	-- Target (credit to lambchop_is_ok for the base for this)
	local b_left = Input.GetActionValue(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
	local b_right = Input.GetActionValue(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
	local b_up = Input.GetActionValue(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
	local b_down = Input.GetActionValue(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
	local isAttacking = (b_down + b_right + b_left + b_up) > 0

	-- Create target
	if isAttacking and not itemData.Target then
		---@type EntityEffect
		local target = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariantTarget, 0, player.Position, Vector.Zero, player):ToEffect()
		itemData.Target = target

		target.Parent = player
		target.SpawnerEntity = player
		target.DepthOffset = -100
		target:GetSprite():Play("Blink", true)
		target.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
	end

	-- If target exists
	if not itemData.Target then return end
	if not itemData.Target:Exists() then
		itemData.Target = nil
		return
	end

	local target = itemData.Target
	local targetData = mod:GetData(target)
	targetData.snapCooldown = nil

	-- Movement
	targetData.vector = Vector(b_right - b_left, b_down - b_up)

	-- Snap to closest enemy if player isn't moving target
	if not isAttacking then
		if targetData.cooldown <= 0 and targetData.enemyTarget and mod:GetData(targetData.enemyTarget).spiritualWound then
			--target.Position = targetData.enemyTarget.Position
			if target.Position:Distance(targetData.enemyTarget.Position) > 10 then
				target.Velocity = (target.Velocity + ((targetData.enemyTarget.Position - target.Position):Normalized() * 75 - target.Velocity) * 0.25)
			else
				target.Velocity = targetData.enemyTarget.Velocity
				target.Position = targetData.enemyTarget.Position
			end
		else
			targetData.cooldown = targetData.cooldown - 1
		end
	else
		targetData.cooldown = 15
	end

	target.Velocity = (target.Velocity + (targetData.vector * (player.ShotSpeed * 6.25) - target.Velocity) * 0.5)

	if room:GetAliveBossesCount() + room:GetAliveEnemiesCount() <= 0 then return end

	-- Damaging

	-- Detect which enemy is the closest to the target
	local closestEnemyDistance = player.TearRange ^ 2
	local closestEnemy
	for _, entity in ipairs(Isaac.FindInRadius(target.Position, player.TearRange, EntityPartition.ENEMY)) do
		if entity:IsVulnerableEnemy() and entity.Type ~= EntityType.ENTITY_FIREPLACE and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT) then
			local distance = entity.Position:DistanceSquared(target.Position)
			if distance < closestEnemyDistance then
				closestEnemy = entity
				closestEnemyDistance = distance
			end
		end
	end

	-- increments/decrements a count of items targeting this entity
	-- Only used to work with multiplayer
	if targetData.enemyTarget and targetData.enemyTarget:Exists() then
		local oldEnemyData = mod:GetData(targetData.enemyTarget)
		oldEnemyData.spiritualWound = oldEnemyData.spiritualWound and oldEnemyData.spiritualWound > 1 and oldEnemyData.spiritualWound - 1 or nil
		if oldEnemyData.spiritualWound ~= nil then
			if oldEnemyData.spiritualWound > 1 then
				oldEnemyData.spiritualWound = oldEnemyData.spiritualWound - 1
			else
				oldEnemyData.spiritualWound = nil
			end
		end
	end

	if closestEnemy then
		local newEnemyData = mod:GetData(closestEnemy)
		newEnemyData.spiritualWound = (newEnemyData.spiritualWound or 0) + 1
		targetData.enemyTarget = closestEnemy

		if not itemData.Lasers then
			itemData.Lasers = {} ---@type EntityLaser[]
			for i = 1, 3 do -- 3 of them at the same time look the best
				local positionOffset = 150 * Vector(rng:RandomFloat() - 0.5, rng:RandomFloat() - 0.5)
				itemData.Lasers[i] = fireSpiritualWoundLaser(player, closestEnemy.Position + positionOffset)
			end

			SFXManager():Play(SpiritualWoundSoundLoop, nil, nil, true)
			SFXManager():Play(SpiritualWoundSoundStart)
		end

		if game:GetFrameCount() % 2 == 0 then
			for _, laser in ipairs(itemData.Lasers) do
				local endpoint = laser:GetEndPoint()
				local positionOffset = 150 * Vector(rng:RandomFloat() - 0.5, rng:RandomFloat() - 0.5)
				local newGoal = pureLerp(endpoint, closestEnemy.Position + positionOffset, 0.4)
				local delta = newGoal - player.Position
				laser:SetMaxDistance(delta:Length() + 50)
				laser.AngleDegrees = delta:GetAngleDegrees() + 40 * (rng:RandomFloat() - 0.5)
				local newEndPoint = EntityLaser.CalculateEndPoint(player.Position, delta, Vector.Zero, player, 0)
				laser.EndPoint = newEndPoint
				laser.TearFlags = laser.TearFlags | TearFlags.TEAR_HOMING
			end
		end
	elseif itemData.Lasers then
		for _, laser in ipairs(itemData.Lasers) do
			laser:Die()
		end
		SFXManager():Stop(SpiritualWoundSoundLoop)
		itemData.Lasers = nil
	end

	-- Damage the closest enemy every (player fire delay) frames with 0.33x of the players damage
	if targetData.enemyTarget ~= nil and game:GetFrameCount() % math.floor(player.MaxFireDelay + 0.5) == 0 then
		targetData.enemyTarget:TakeDamage(player.Damage * 0.33, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
		targetData.enemyTarget:SetColor(Color(1, 0, 0, 1, 0, 0, 0), 12, 1, false, false)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.EnemyTethering)

function mod:ResetSpiritualWoundTarget()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		local itemData = data.SpirtualWound
		if itemData and itemData.Target and not itemData.Target:Exists() then
			itemData.Target = nil
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ResetSpiritualWoundTarget)

---@param entity Entity
function mod:SpiritualKill(entity)
	local data = mod:GetData(entity)
	if data.spiritualWound == nil then return end

	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)

		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
		if hasItem(player) and rng:RandomFloat() <= 0.05 then
			SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
			player:AddHearts(1)
		end
	end

	data.spiritualWound = nil
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.SpiritualKill)
