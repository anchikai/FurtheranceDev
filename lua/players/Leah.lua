local mod = Furtherance
local game = Game()
local rng = RNG()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

normalLeah = Isaac.GetPlayerTypeByName("Leah", false)
taintedLeah = Isaac.GetPlayerTypeByName("LeahB", true)

COSTUME_LEAH_A_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_001_Leah_Hair.anm2")
COSTUME_LEAH_B_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_001b_Leah_Hair.anm2")

local function IsEnemyNear(player) -- Enemy detection
	for _, enemies in pairs(Isaac.FindInRadius(player.Position, 100)) do
		if enemies:IsVulnerableEnemy() and enemies:IsActiveEnemy() then
			return true
		end
	end
	return false
end

function mod:OnInit(player)
	local data = mod:GetData(player)
	data.Init = true
	if player:GetName() == "Leah" then -- If the player is Leah it will apply her hair
		player:AddNullCostume(COSTUME_LEAH_A_HAIR)
		data.leahkills = 0
		--player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, ActiveSlot.SLOT_POCKET, false)
	elseif player:GetName() == "LeahB" then -- Apply different hair for her tainted variant
		--player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_SHATTERED_HEART, ActiveSlot.SLOT_POCKET, false)
		player:AddNullCostume(COSTUME_LEAH_B_HAIR)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:OnUpdate(player)
	local room = game:GetRoom()
	local data = mod:GetData(player)
	if player:GetName() == "Leah" then
		if player.FrameCount == 1 and data.Init then
			if not mod.isLoadingData then
				player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, ActiveSlot.SLOT_POCKET, false)
			end
		elseif player.FrameCount > 1 and data.Init then
			mod.isLoadingData = false
			data.Init = nil
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and data.BR ~= 2 then -- Add 3 Broken Hearts when taking Birthright & reset kill count to prevent softlocks
			data.BR = 1
			player:AddBrokenHearts(3)
			player:AddCacheFlags(CacheFlag.CACHE_RANGE)
			player:EvaluateItems()
			data.leahkills = 0
			data.BR = 2
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false and data.BR ~= 0 then -- If the player for some reason loses Birthright
			data.BR = 0
		end
	elseif player:GetName() == "LeahB" then
		if player.FrameCount < 10 and (not mod.isLoadingData and data.Init) then
			player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_SHATTERED_HEART, ActiveSlot.SLOT_POCKET, false)
		elseif player.FrameCount >= 10 and data.Init then
			data.Init = nil
		end
		if data.LeahbPower < 0 then
			data.LeahbPower = 0
		end
		if player:GetMaxHearts() > 0 then
			local conv = player:GetMaxHearts()
			player:AddMaxHearts(-conv)
			player:AddBlackHearts(conv)
		end
		player:AddHearts(-player:GetHearts())
		if not IsEnemyNear(player) then
			data.LeahbPower = data.LeahbPower - 1
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		end
		if player:GetBrokenHearts() == 0 then
			data.LeahSpeed = false
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		elseif player:GetBrokenHearts() > 0 then
			data.LeahSpeed = true
			player:AddCacheFlags(CacheFlag.CACHE_SPEED)
			player:EvaluateItems()
		end
		if not IsEnemyNear(player) and player:GetBrokenHearts() ~= 11 and not player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			if game:GetFrameCount() % 120 == 0 then
				SFXManager():Play(bhb)
				player:AddBrokenHearts(1)
			end
		elseif not IsEnemyNear(player) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			if game:GetFrameCount() % 120 == 0 then
				if player:GetBrokenHearts() < 6 then
					SFXManager():Play(bhb)
					player:AddBrokenHearts(1)
				elseif player:GetBrokenHearts() > 6 then
					SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
					player:AddBrokenHearts(-1)
				end
			end
		elseif IsEnemyNear(player) then
			if player.MaxFireDelay <= 40 then
				data.LeahbPower = data.LeahbPower + 1
				player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
				player:EvaluateItems()
			end
			if game:GetFrameCount() % 30 == 0 then
				SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
				player:AddBrokenHearts(-1)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnUpdate)

function mod:Hearts(entity, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		if player:GetName() == "LeahB" then -- Prevent Tainted Leah from obtaining Red Health
			if entity.SubType == HeartSubType.HEART_DOUBLEPACK or entity.SubType == HeartSubType.HEART_FULL or entity.SubType == HeartSubType.HEART_HALF
				or entity.SubType == HeartSubType.HEART_ROTTEN or entity.SubType == HeartSubType.HEART_SCARED then
				return false
			elseif entity.SubType == HeartSubType.HEART_BLENDED then
				if player:GetSoulHearts() + player:GetBoneHearts() * 2 < 24 then
					entity:GetSprite():Play("Collect", true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
					player:AddSoulHearts(2)
				end
				return false
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.Hearts, PickupVariant.PICKUP_HEART)

function mod:leahStats(player, flag)
	local data = mod:GetData(player)
	if player:GetName() == "Leah" then -- If the player is Leah it will apply her stats
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 1
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage - 0.36
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - 195.6
			player.TearRange = player.TearRange + player:GetBrokenHearts() * 40
		end
	elseif player:GetName() == "LeahB" then -- If the player is Tainted Leah it will apply her stats
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay / 2.5
			if data.LeahbPower == nil then
				data.LeahbPower = 0
			end
			if data.LeahbPower > 0 then
				for power = 1, data.LeahbPower do
					if player.MaxFireDelay <= 40 then
						player.MaxFireDelay = player.MaxFireDelay * 1.01
					end
				end
			end
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage - 2
		end
		if flag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + 0.5
			if data.LeahSpeed == nil then
				data.LeahSpeed = false
			end
			if data.LeahSpeed == true and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false then
				player.MoveSpeed = player.MoveSpeed - (player:GetBrokenHearts() / 20)
			elseif data.LeahSpeed == true and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				player.MoveSpeed = player.MoveSpeed - 0.85
				player.MoveSpeed = player.MoveSpeed + (player:GetBrokenHearts() / 20)
			end
		end
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck - 3
		end
	end
	if data.brokentears == true then
		if flag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_CHARM
			if game:GetFrameCount() % 2 == 0 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACK, 0, player.Position, Vector.Zero, player)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.leahStats)

function mod:LeahKill(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:GetName() == "Leah" then
			local data = mod:GetData(player)
			data.leahkills = data.leahkills + 1
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			local hrRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false then
				if data.leahkills >= 20 then
					data.leahkills = 0
					SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
					player:AddBrokenHearts(-1)
					data.RenovatorDamage = data.RenovatorDamage + 0.5
					player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
					player:AddCacheFlags(CacheFlag.CACHE_RANGE)
					player:EvaluateItems()
				end
			else
				if data.leahkills >= 10 then
					data.leahkills = 0
					SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
					player:AddBrokenHearts(-1)
					data.RenovatorDamage = data.RenovatorDamage + 0.5
					player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
					player:AddCacheFlags(CacheFlag.CACHE_RANGE)
					player:EvaluateItems()
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.LeahKill)

function mod:LeahbBrokenTears(tear)
	local player = tear.Parent:ToPlayer()
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART) then -- % Chance to charm enemies based off how many broken hearts you have
		local brokenRoll = rng:RandomInt(100) + 1
		if brokenRoll <= (player:GetBrokenHearts() * 5 + 25) then
			data.brokentears = true
			tear.Color = Color(1, 0.588, 0.686, 1, 0, 0, 0)
			player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
			player:EvaluateItems()
		else
			data.brokentears = false
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and player:GetName() == "LeahB" then -- +20% Chance if you have Birthright
			if brokenRoll <= (player:GetBrokenHearts() * 5 + 45) then
				data.brokentears = true
				tear.Color = Color(1, 0.588, 0.686, 1, 0, 0, 0)
				player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
				player:EvaluateItems()
			else
				data.brokentears = false
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.LeahbBrokenTears)

function mod:ClickerFix(_, _, player)
	if player:GetName() == "Leah" then
		player:TryRemoveNullCostume(COSTUME_LEAH_A_HAIR)
		player:AddNullCostume(COSTUME_LEAH_A_HAIR)
	elseif player:GetName() == "LeahB" then
		player:TryRemoveNullCostume(COSTUME_LEAH_B_HAIR)
		player:AddNullCostume(COSTUME_LEAH_B_HAIR)
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_CLICKER)
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_SHIFT_KEY)
