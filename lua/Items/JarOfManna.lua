local mod = Furtherance
local game = Game()

local MannaStatObjs = {
	{
		Name = "Damage",
		Flag = CacheFlag.CACHE_DAMAGE,
		Buff = 0.25,
		BaseStat = 3.5,
		Capacity = math.huge,
		Weight = 1,
	},
	{
		Name = "TearRange",
		Flag = CacheFlag.CACHE_RANGE,
		Buff = 0.5 * 40,
		BaseStat = 260,
		Capacity = math.huge,
		Weight = 1 / 40
	},
	{
		Name = "ShotSpeed",
		Flag = CacheFlag.CACHE_SHOTSPEED,
		Buff = 0.25,
		BaseStat = 1,
		Capacity = math.huge,
		Weight = 1
	},
	{
		Name = "MoveSpeed",
		Flag = CacheFlag.CACHE_SPEED,
		Buff = 0.10,
		BaseStat = 1,
		Capacity = 2,
		Weight = 1
	},
	{
		Name = "Luck",
		Flag = CacheFlag.CACHE_LUCK,
		Buff = 0.5,
		BaseStat = 0,
		Capacity = math.huge,
		Weight = 1
	},
	{
		Name = "MaxFireDelay",
		Flag = CacheFlag.CACHE_FIREDELAY,
		Buff = 0.5,
		BaseStat = 2.73,
		Capacity = 120,
		Weight = 1
	}
}

local ALL_MANNA_FLAGS = 0
for _, obj in ipairs(MannaStatObjs) do
	ALL_MANNA_FLAGS = ALL_MANNA_FLAGS | obj.Flag
end

local function getStatValue(player, statObj)
	local statValue = player[statObj.Name]
	if statObj.Flag == CacheFlag.CACHE_FIREDELAY then
		statValue = mod:GetTearsFromFireDelay(statValue)
	end

	return statValue
end

-- Get effect to give
function mod:UseMannaJar(_, _, player)
	local data = mod:GetData(player)
	data.MannaCount = 0

	if not player:HasFullHearts() then
		player:AddHearts(2)
		SFXManager():Play(SoundEffect.SOUND_VAMP_GULP, 1.25)

	elseif player:GetNumCoins() < 15 then
		player:AddCoins(1)
		SFXManager():Play(SoundEffect.SOUND_PENNYPICKUP, 1.5)

	elseif player:GetNumKeys() < 5 then
		player:AddKeys(1)
		SFXManager():Play(SoundEffect.SOUND_KEYPICKUP_GAUNTLET, 1.25)

	elseif player:GetNumBombs() < 5 then
		player:AddBombs(1)
		SFXManager():Play(SoundEffect.SOUND_FETUS_FEET, 1.5)

	else
		local buffs = data.MannaBuffs
		if buffs == nil then
			buffs = {}
			for i = 1, #MannaStatObjs do
				buffs[i] = 0
			end
			data.MannaBuffs = buffs
		end

		-- Give stats

		-- get the lowest relative stat
		local lowestStatValue = math.huge
		for _, stat in ipairs(MannaStatObjs) do
			local statValue = getStatValue(player, stat)
			local statWeight = stat.Weight * (statValue - stat.BaseStat)
			if statValue < stat.Capacity and statWeight < lowestStatValue then
				lowestStatValue = statWeight
			end
		end

		-- get a list of stats to randomly pick from if multiple are the lowest
		local possibleBuffs = {}
		for i, stat in ipairs(MannaStatObjs) do
			local statValue = getStatValue(player, stat)
			local statWeight = stat.Weight * (statValue - stat.BaseStat)
			if statValue < stat.Capacity and statWeight <= lowestStatValue then
				table.insert(possibleBuffs, i)
			end
		end

		-- pick one of the lowest stats
		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_JAR_OF_MANNA)
		local possibleChoice = rng:RandomInt(#possibleBuffs) + 1
		local buffChoice = possibleBuffs[possibleChoice]
		buffs[buffChoice] = buffs[buffChoice] + 1

		SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER, 1.25)
		player:AddCacheFlags(ALL_MANNA_FLAGS)
		player:EvaluateItems()
	end

	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseMannaJar, CollectibleType.COLLECTIBLE_JAR_OF_MANNA)

-- Stats --
function mod:MannaBuffs(player, flag)
	local data = mod:GetData(player)
	if data.MannaBuffs == nil then return end

	if flag == CacheFlag.CACHE_FIREDELAY then
		local tears = mod:GetTearsFromFireDelay(player.MaxFireDelay)
		tears = tears + MannaStatObjs[6].Buff * data.MannaBuffs[6]
		player.MaxFireDelay = mod:GetFireDelayFromTears(tears)
		return
	end

	for i, buffCount in ipairs(data.MannaBuffs) do
		local stat = MannaStatObjs[i]

		if stat.Flag == flag then
			player[stat.Name] = player[stat.Name] + buffCount * stat.Buff
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.MannaBuffs)


-- Spawn manna --
function mod:SpawnMana(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)

		if player:HasCollectible(CollectibleType.COLLECTIBLE_JAR_OF_MANNA) then
			if not data.MannaCount then
				data.MannaCount = 0
			end
			if data.MannaCount < 20 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, 7888, 0, entity.Position, Vector.Zero, player):ToEffect():SetTimeout(75)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.SpawnMana)

-- Effects --
function mod:MannaPickup(effect)
	local sprite = effect:GetSprite()
	local collectible = true

	if effect.Timeout <= 0 then
		collectible = false
		if not sprite:IsPlaying("Collect") then
			sprite:Play("Collect", true)
		end
		if sprite:GetFrame() == 7 then
			effect:Remove()
		end

	elseif effect.Timeout < 30 then
		if not sprite:IsPlaying("Blink") then
			sprite:SetAnimation("Blink", false)
		end
	end


	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)

		-- Collect soul
		if collectible == true and effect.Position:DistanceSquared(player.Position) < 1200 then
			effect.Timeout = 0
			data.manna = true
		end

		-- Get charge from manna
		if data.manna == true then
			local slot = nil
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_JAR_OF_MANNA then
				slot = ActiveSlot.SLOT_PRIMARY
			elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_JAR_OF_MANNA then
				slot = ActiveSlot.SLOT_SECONDARY
			elseif player:GetActiveItem(ActiveSlot.SLOT_POCKET) == CollectibleType.COLLECTIBLE_JAR_OF_MANNA then
				slot = ActiveSlot.SLOT_POCKET
			end

			if slot ~= nil then
				if data.MannaCount < 20 then
					data.MannaCount = data.MannaCount + 1

					if data.MannaCount == 20 then
						player:SetActiveCharge(1, slot)
						game:GetHUD():FlashChargeBar(player, slot)
						SFXManager():Play(SoundEffect.SOUND_BEEP)
						SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
					end
				else
					game:GetHUD():FlashChargeBar(player, slot)
					SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
				end

				player:SetColor(Color(1, 1, 1, 1, 0.25, 0.25, 0.25), 5, 1, true, false)
				SFXManager():Play(SoundEffect.SOUND_SOUL_PICKUP)
			end

			data.manna = false
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.MannaPickup, 7888)