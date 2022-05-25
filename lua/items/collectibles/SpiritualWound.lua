local mod = Furtherance
local game = Game()

local EffectVariantTarget = Isaac.GetEntityVariantByName("Spiritual Wound Target")
local EffectVariantImpact = Isaac.GetEntityVariantByName("Spiritual Wound Impact")

local SpiritualWoundSoundStart = Isaac.GetSoundIdByName("SpiritualWoundStart")
local SpiritualWoundSoundLoop = Isaac.GetSoundIdByName("SpiritualWoundLoop")


---@param vector1 Vector
---@param vector2 Vector
---@param alpha number -- between 0-1
local function pureLerp(vector1, vector2, alpha)
	return vector1 * (1 - alpha) + vector2 * alpha
end

---@param player EntityPlayer
---@return boolean
local function hasItem(player)
	return player ~= nil and (player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND) or player:GetPlayerType() == MiriamB)
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

---@param player EntityPlayer
---@param targetPosition Vector
---@param woundVariant integer
local function spawnLaser(player, targetPosition, woundVariant)
	local room = game:GetRoom()
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

---@param player EntityPlayer
---@param targetPosition Vector
---@return EntityLaser[]
local function spawnLasers(player, targetPosition)
	local data = mod:GetData(player)
	local itemData = data.SpiritualWound
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)

	local lasers = {}
	for i = 1, 3 do -- 3 of them at the same time look the best
		local positionOffset = 150 * Vector(rng:RandomFloat() - 0.5, rng:RandomFloat() - 0.5)
		lasers[i] = spawnLaser(player, targetPosition + positionOffset, itemData.LaserVariant)
	end

	SFXManager():Play(SpiritualWoundSoundLoop, nil, nil, true)
	SFXManager():Play(SpiritualWoundSoundStart)

	return lasers
end

---@param player EntityPlayer
---@param laser EntityLaser
---@param targetPosition Vector
---@param angleOffset number
local function updateLaser(laser, player, targetPosition, angleOffset)
	local newGoal = pureLerp(laser:GetEndPoint(), targetPosition, 0.4)
	local delta = newGoal - player.Position

	laser:SetMaxDistance(delta:Length() + 50)
	laser.AngleDegrees = delta:GetAngleDegrees() + angleOffset
	laser.EndPoint = EntityLaser.CalculateEndPoint(player.Position, delta, Vector(0, player.SpriteScale.Y * -32), player, 0)
	laser.TearFlags = laser.TearFlags | TearFlags.TEAR_HOMING
end

---@param lasers EntityLaser[]
---@param player EntityPlayer
---@param target Entity
---@return EntityLaser[]
local function updateLasers(lasers, player, target)
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
	local data = mod:GetData(player)
	local itemData = data.SpiritualWound
	local woundVariant = itemData.LaserVariant
	local oldWoundVariant = itemData.OldLaserVariant

	if woundVariant == oldWoundVariant then
		for _, laser in ipairs(lasers) do
			local positionOffset = 150 * Vector(rng:RandomFloat() - 0.5, rng:RandomFloat() - 0.5)
			local angleOffset = 40 * (rng:RandomFloat() - 0.5)
			updateLaser(laser, player, target.Position + positionOffset, angleOffset)
		end

		return lasers
	else
		for _, laser in ipairs(lasers) do
			laser:Kill()
		end

		itemData.OldLaserVariant = woundVariant
		return spawnLasers(player, target.Position)
	end


end

---@param laser EntityLaser
function mod:SpiritualWoundUpdate(laser)
	local data = mod:GetData(laser)
	if data.IsSpiritualWound then
		SFXManager():Stop(SoundEffect.SOUND_BLOOD_LASER)
		SFXManager():Stop(SoundEffect.SOUND_BLOOD_LASER_LOOP)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, mod.SpiritualWoundUpdate)

---@param entityType integer
---@param variant integer
---@param spawner Entity
function mod:ReplaceBrimstoneSplash(entityType, variant, _, _, _, spawner)
	if spawner == nil then return end
	local laserSpawner = spawner.SpawnerEntity and spawner.SpawnerEntity:ToPlayer()

	if entityType == EntityType.ENTITY_EFFECT and variant == EffectVariant.LASER_IMPACT and hasItem(laserSpawner) then
		return { EntityType.ENTITY_EFFECT, EffectVariantImpact }
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.ReplaceBrimstoneSplash)

---@param laser EntityLaser
function mod:SpiritualWoundRender(laser)
	local data = mod:GetData(laser)
	if data.IsSpiritualWound then
		if laser.Variant == SpiritualWoundVariant.NORMAL then
			laser.SpriteScale = Vector.One * 0.3
		elseif laser.Variant == SpiritualWoundVariant.POLARITY_SHIFT then
			laser.SpriteScale = Vector.One * 2
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_LASER_RENDER, mod.SpiritualWoundRender)

local function getNewTarget(position, maxDistance)
	maxDistance = maxDistance ^ 2
	local newEnemy
	for _, entity in ipairs(Isaac.FindInRadius(position, maxDistance, EntityPartition.ENEMY)) do
		if entity:IsVulnerableEnemy() and entity.Type ~= EntityType.ENTITY_FIREPLACE and not entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY | EntityFlag.FLAG_PERSISTENT) then
			local distance = entity.Position:DistanceSquared(position)
			if distance < maxDistance then
				newEnemy = entity
				maxDistance = distance
			end
		end
	end

	return newEnemy
end

---@param player EntityPlayer
local function updateTarget(player)
	local data = mod:GetData(player)
	local itemData = data.SpiritualWound
	if itemData == nil then return end

	local targetEffect = itemData.Target
	if targetEffect == nil then return end

	local targetData = mod:GetData(targetEffect)

	local oldEnemy = targetData.enemyTarget
	local newEnemy = getNewTarget(targetEffect.Position, player.TearRange)
	if oldEnemy == nil and newEnemy == nil then
		return nil
	end

	if oldEnemy ~= nil and newEnemy ~= nil and GetPtrHash(newEnemy) == GetPtrHash(oldEnemy) or oldEnemy == nil and newEnemy == nil then
		return oldEnemy
	end

	targetData.enemyTarget = newEnemy

	-- increments/decrements a count of items targeting this entity
	-- Only used to work with multiplayer
	if oldEnemy and oldEnemy:Exists() then
		local oldEnemyData = mod:GetData(oldEnemy)
		if oldEnemyData.spiritualWound ~= nil then
			if oldEnemyData.spiritualWound > 1 then
				oldEnemyData.spiritualWound = oldEnemyData.spiritualWound - 1
			else
				oldEnemyData.spiritualWound = nil
			end
		end
	end

	if newEnemy and newEnemy:Exists() then
		local newEnemyData = mod:GetData(newEnemy)
		newEnemyData.spiritualWound = (newEnemyData.spiritualWound or 0) + 1

		if not itemData.Lasers then
			itemData.OldLaserVariant = itemData.LaserVariant
			itemData.Lasers = spawnLasers(player, targetEffect.Position)
		end
	elseif itemData.Lasers then
		for _, laser in ipairs(itemData.Lasers) do
			laser:Die()
		end
		SFXManager():Stop(SpiritualWoundSoundLoop)
		itemData.OldLaserVariant = nil
		itemData.Lasers = nil
	end

	return newEnemy
end

local function snapTargetEffect(targetEffect)
	local targetData = mod:GetData(targetEffect)
	if targetData.cooldown <= 0 and targetData.enemyTarget and mod:GetData(targetData.enemyTarget).spiritualWound then
		--target.Position = targetData.enemyTarget.Position
		if targetEffect.Position:Distance(targetData.enemyTarget.Position) > 10 then
			targetEffect.Velocity = (targetEffect.Velocity + ((targetData.enemyTarget.Position - targetEffect.Position):Normalized() * 75 - targetEffect.Velocity) * 0.25)
		else
			targetEffect.Velocity = targetData.enemyTarget.Velocity
			targetEffect.Position = targetData.enemyTarget.Position
		end
	else
		targetData.cooldown = targetData.cooldown - 1
	end
end

---@param player EntityPlayer
function mod:EnemyTethering(player)
	if not hasItem(player) then return end

	local data = mod:GetData(player)
	local room = game:GetRoom()

	local itemData = data.SpiritualWound
	if not itemData then
		itemData = {
			HitCount = 0,
			LaserVariant = SpiritualWoundVariant.NORMAL,
		}
		data.SpiritualWound = itemData
	end

	-- Target (credit to lambchop_is_ok for the base for this)
	local b_left = Input.GetActionValue(ButtonAction.ACTION_SHOOTLEFT, player.ControllerIndex)
	local b_right = Input.GetActionValue(ButtonAction.ACTION_SHOOTRIGHT, player.ControllerIndex)
	local b_up = Input.GetActionValue(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
	local b_down = Input.GetActionValue(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
	local isAttacking = (b_down + b_right + b_left + b_up) > 0

	-- Create target
	if isAttacking and not itemData.Target then
		---@type EntityEffect
		local targetEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariantTarget, 0, player.Position, Vector.Zero, player):ToEffect()
		itemData.Target = targetEffect

		targetEffect.Parent = player
		targetEffect.SpawnerEntity = player
		targetEffect.DepthOffset = -100
		targetEffect:GetSprite():Play("Blink", true)
		targetEffect.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
	end

	-- If target exists
	if not itemData.Target then return end
	if not itemData.Target:Exists() then
		itemData.Target = nil
		return
	end

	local targetEffect = itemData.Target
	local targetData = mod:GetData(targetEffect)
	targetData.snapCooldown = nil

	-- Movement
	local targetVelocity = Vector(b_right - b_left, b_down - b_up)

	-- Snap to closest enemy if player isn't moving target
	if isAttacking then
		targetData.cooldown = 15
	else
		snapTargetEffect(targetEffect)
	end

	targetEffect.Velocity = (targetEffect.Velocity + (targetVelocity * (player.ShotSpeed * 6.25) - targetEffect.Velocity) * 0.5)

	if room:GetAliveBossesCount() + room:GetAliveEnemiesCount() <= 0 then return end

	-- Damaging
	-- Detect which enemy is the closest to the target
	---@type Entity
	local targetEnemy = updateTarget(player)

	-- update the lasers every other frame
	if targetEnemy ~= nil and itemData.Lasers ~= nil and game:GetFrameCount() % 2 == 0 then
		itemData.Lasers = updateLasers(itemData.Lasers, player, targetEnemy)
	end

	-- Damage the closest enemy every (player fire delay) frames with 0.33x of the players damage
	local roundedFireDelay = math.floor(player.MaxFireDelay + 0.5)
	if targetEnemy ~= nil and game:GetFrameCount() % roundedFireDelay == 0 then
		itemData.HitCount = (itemData.HitCount or 0) + 1

		local damageMultiplier = 0.33
		if itemData.GetDamageMultiplier then
			damageMultiplier = itemData:GetDamageMultiplier()
		end
		print(damageMultiplier)

		targetEnemy:TakeDamage(player.Damage * damageMultiplier, DamageFlag.DAMAGE_NO_MODIFIERS, EntityRef(player), 1)
		targetEnemy:SetColor(Color(1, 0, 0, 1, 0, 0, 0), 12, 1, false, false)

		if targetEnemy:HasMortalDamage() then
			itemData.HitCount = 0
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.EnemyTethering)

function mod:ResetSpiritualWoundTarget()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		local itemData = data.SpiritualWound
		if hasItem(player) and itemData then
			itemData.HitCount = 0
			itemData.LaserVariant = SpiritualWoundVariant.NORMAL
			itemData.OldLaserVariant = nil
			itemData.GetDamageMultiplier = nil
			if itemData.Target and not itemData.Target:Exists() then
				itemData.Target = nil
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ResetSpiritualWoundTarget)

---@param player EntityPlayer
local function addActiveCharge(player, amount, activeSlot)
	local polShiftConfig = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_POLARITY_SHIFT)
	player:SetActiveCharge(math.min(player:GetActiveCharge(activeSlot) + amount, polShiftConfig.MaxCharges), activeSlot)
end

---@param entity Entity
function mod:SpiritualKill(entity)
	local enemyData = mod:GetData(entity)
	if enemyData.spiritualWound == nil then return end

	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)

		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
		if hasItem(player) and rng:RandomFloat() <= 1 then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_POLARITY_SHIFT) and (player:HasFullHearts() or data.UsedPolarityShift) then
				for _, activeSlot in pairs(ActiveSlot) do
					if player:GetActiveItem(activeSlot) == CollectibleType.COLLECTIBLE_POLARITY_SHIFT then
						addActiveCharge(player, 1, activeSlot)
						game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_PRIMARY)
						if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) < 6 then
							SFXManager():Play(SoundEffect.SOUND_BEEP)
						else
							SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
							SFXManager():Play(SoundEffect.SOUND_ITEMRECHARGE)
						end
					end
				end
				print("added a charge")
			elseif not data.UsedPolarityShift then
				print("healed")
				SFXManager():Play(SoundEffect.SOUND_VAMP_GULP)
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position, Vector.Zero, player)
				player:AddHearts(1)
			end

		end
	end

	enemyData.spiritualWound = nil
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.SpiritualKill)
