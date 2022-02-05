local mod = further
local game = Game()
local rng = RNG()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

normalLeah = Isaac.GetPlayerTypeByName("Leah", false)
taintedLeah = Isaac.GetPlayerTypeByName("LeahB", true)

COSTUME_LEAH_A_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_001_Leah_Hair.anm2")
COSTUME_LEAH_B_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_001b_Leah_Hair.anm2")

function IsEnemyNear(player) -- Enemy detection
	local data = player:GetData()
	for _, enemies in pairs(Isaac.FindInRadius(player.Position, 100)) do
		if enemies:IsVulnerableEnemy() and enemies:IsActiveEnemy() then
			return true
		end
	end
	return false
end

function mod:HeartFix(IsContinued)
    for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:GetName() == "Leah" then
			if i == 0 and IsContinued == false then
				player:AddBrokenHearts(-1)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.HeartFix)

function mod:OnInit(player)
	local data = mod:GetData(player)
	if player:GetName() == "Leah" then -- If the player is Leah it will apply her hair
		player:AddNullCostume(COSTUME_LEAH_A_HAIR)
		costumeEquipped = true
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, ActiveSlot.SLOT_POCKET, false)
		data.leahkills = 0
		data.HeartCount = 2
	elseif player:GetName() == "LeahB" then -- Apply different hair for her tainted variant
		player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_SHATTERED_HEART, ActiveSlot.SLOT_POCKET, false)
		player:AddNullCostume(COSTUME_LEAH_B_HAIR)
		costumeEquipped = true
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:OnUpdate(player)
	local room = game:GetRoom()
	local data = mod:GetData(player)
	if player:GetName() == "Leah" then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and data.BR ~= 2 then -- Add 3 Broken Hearts when taking Birthright & reset kill count to prevent softlocks
			data.BR = 1
			player:AddBrokenHearts(3)
			data.leahkills = 0
			data.BR = 2
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false and data.BR ~= 0 then -- If the player for some reason loses Birthright
			data.BR = 0
		end
		local drop = Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex)
		if data.dropcooldown == nil and not drop then
			data.dropcooldown = 0
		else
			if Game():GetRoom():GetFrameCount() == 1 then
				data.chargeBar = nil
				data.dropcooldown = 0
			end
			if not data.chargeBar and drop and data.HeartCount >= 2 then
				mod:SpawnChargeBar(player)
			end
		end
		if room:GetFrameCount() == 1 then
			data.chargeBar = nil
			data.dropcooldown = 0
		end
		if drop and data.HeartCount >= 2 and player:GetBrokenHearts() < 11 and data.chargeBar then -- press drop button to remove 2 hearts and add a broken heart
			if data.dropcooldown == 30 then
				data.HeartCount = data.HeartCount - 2
				player:AddBrokenHearts(1)
				SFXManager():Play(bhb)
				if player.MaxFireDelay > 1 then
					local hrRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
					if hrRNG:RandomInt(2) == 0 then
						data.PermshD = data.PermshD + 1
						player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
					else
						data.PermshT = data.PermshT + 1
						player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
					end
					player:EvaluateItems()
				else
					data.PermshD = data.PermshD + 1
					player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
					player:EvaluateItems()
				end
			end
		end
	elseif player:GetName() == "LeahB" then
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
			if game:GetFrameCount()%120 == 0 then
				SFXManager():Play(bhb)
				player:AddBrokenHearts(1)
			end
		elseif not IsEnemyNear(player) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			if game:GetFrameCount()%120 == 0 then
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
			if game:GetFrameCount()%30 == 0 then
				SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
				player:AddBrokenHearts(-1)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.OnUpdate)

function mod:Hearts(entity, collider)
	local heartCounter = {
		[HeartSubType.HEART_FULL] = 2,
		[HeartSubType.HEART_SCARED] = 2,
		[HeartSubType.HEART_DOUBLEPACK] = 4,
		[HeartSubType.HEART_HALF] = 1,
		[HeartSubType.HEART_BLENDED] = 2,
	}
	if RepentancePlusMod then
		heartCounter[CustomPickups.TaintedHearts.HEART_HOARDED] = 8
	end
	if collider.Type == EntityType.ENTITY_PLAYER then
		local collider = collider:ToPlayer()
		local data = mod:GetData(collider)
		if collider:GetName() == "Leah" then -- Leah's Heart Counter Gimmick
			--[[if collider:CanPickRedHearts() == false and data.HeartCount < 99 then
				if entity.SubType == HeartSubType.HEART_FULL or entity.SubType == HeartSubType.HEART_SCARED then
					data.HeartCount = data.HeartCount + 2
					entity:GetSprite():Play("Collect",true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
				elseif entity.SubType == HeartSubType.HEART_DOUBLEPACK then
					data.HeartCount = data.HeartCount + 4
					entity:GetSprite():Play("Collect",true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
				elseif entity.SubType == HeartSubType.HEART_HALF then
					data.HeartCount = data.HeartCount + 1
					entity:GetSprite():Play("Collect",true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
				elseif RepentancePlusMod then
					if entity.SubType == CustomPickups.TaintedHearts.HEART_HOARDED then
						data.HeartCount = data.HeartCount + 8
						entity:GetSprite():Play("Collect",true)
						entity:Die()
						SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
					end
				end
			elseif collider:CanPickRedHearts() and RepentancePlusMod then
				if entity.SubType == CustomPickups.TaintedHearts.HEART_HOARDED then
					data.HeartCount = data.HeartCount - 8
				end
			end]]
			if data.HeartCount < 99 and entity:IsShopItem() == false then
				for subtype, amount in pairs (heartCounter) do
					if entity.SubType == subtype then
						local emptyHearts = collider:GetEffectiveMaxHearts() - collider:GetHearts()
						local fullHearts = collider:GetHearts() + collider:GetSoulHearts() + collider:GetBrokenHearts() * 2
						if emptyHearts <= amount then
							if subtype ~= HeartSubType.HEART_BLENDED then
								data.HeartCount = data.HeartCount + amount - emptyHearts
							else
								if fullHearts == 24 then
									data.HeartCount = data.HeartCount + 2
								elseif fullHearts == 23 then
									data.HeartCount = data.HeartCount + 1
								end
							end
							if not collider:CanPickRedHearts() then
								entity:GetSprite():Play("Collect",true)
								entity:Die()
								SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
							elseif collider:CanPickRedHearts() and RepentancePlusMod then
								if entity.SubType == CustomPickups.TaintedHearts.HEART_HOARDED then
									entity:GetSprite():Play("Collect",true)
									entity:Die()
									SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
									collider:AddHearts(emptyHearts)
								end
							end
						end
					end
				end
			end
		end
		if collider:GetName() == "LeahB" then -- Prevent Tainted Leah from obtaining Red Health
			if entity.SubType == HeartSubType.HEART_DOUBLEPACK or entity.SubType == HeartSubType.HEART_FULL or entity.SubType == HeartSubType.HEART_HALF 
			or entity.SubType == HeartSubType.HEART_ROTTEN or entity.SubType == HeartSubType.HEART_SCARED then
				return false
			elseif entity.SubType == HeartSubType.HEART_BLENDED then
				if collider:GetSoulHearts() + collider:GetBoneHearts() * 2 < 24 then
					entity:GetSprite():Play("Collect",true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
					collider:AddSoulHearts(2)
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
		if data.PermshD == nil or data.PermshT == nil then
			data.PermshD = 0
			data.PermshT = 0
		end
		if flag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 1
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false then
				player.MaxFireDelay = player.MaxFireDelay - (data.PermshT * 0.4)
			else
				player.MaxFireDelay = player.MaxFireDelay - (data.PermshT * 0.8)
			end
		end
		if flag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage - 0.36
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) == false then
				player.Damage = player.Damage + data.PermshD * 0.25
			else
				player.Damage = player.Damage + data.PermshD * 0.5
			end
		end
	elseif player:GetName() == "LeahB" then -- If the player is Tainted Leah it will apply her stats
		if flag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
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
		if flag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage - 2
		end
		if flag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
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
		if flag & CacheFlag.CACHE_LUCK == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck - 3
		end
	end
	if data.brokentears == true then
		if flag & CacheFlag.CACHE_TEARFLAG == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_CHARM
			if game:GetFrameCount()%2 == 0 then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_BLACK, 0, player.Position, Vector(0,0), player)
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
				if data.leahkills == 20 then
					data.leahkills = 0
					SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
					player:AddBrokenHearts(1)
					if player.MaxFireDelay > 1 then
						if hrRNG:RandomInt(2) == 0 then
							data.PermshD = data.PermshD + 1
							player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
						else
							data.PermshT = data.PermshT + 1
							player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
						end
						player:EvaluateItems()
					else
						data.PermshD = data.PermshD + 1
						player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
						player:EvaluateItems()
					end
				end
			else
				if data.leahkills == 10 then
					data.leahkills = 0
					SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
					player:AddBrokenHearts(1)
					if player.MaxFireDelay > 1 then
						if hrRNG:RandomInt(2) == 0 then
							data.PermshD = data.PermshD + 1
							player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
						else
							data.PermshT = data.PermshT + 1
							player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
						end
						player:EvaluateItems()
					else
						data.PermshD = data.PermshD + 1
						player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
						player:EvaluateItems()
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.LeahKill)

function mod:RoomClearLeah()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:GetName() == "Leah" then
			local hrRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
			if hrRNG:RandomInt(4) == 0 then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SCARED, Isaac.GetFreeNearPosition(player.Position, 20), Vector(0, 0), player)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.RoomClearLeah)

function mod:LeahbBrokenTears(tear)
    local player = tear.Parent:ToPlayer()
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART) then -- % Chance to charm enemies based off how many broken hearts you have
		local brokenRoll = rng:RandomInt(100)+1
		if brokenRoll <= (player:GetBrokenHearts()*5+25) then
			data.brokentears = true
			tear.Color = Color(1, 0.588, 0.686, 1, 0, 0, 0)
			player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
			player:EvaluateItems()
		else
			data.brokentears = false
		end
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) and player:GetName() == "LeahB" then -- +20% Chance if you have Birthright
			if brokenRoll <= (player:GetBrokenHearts()*5+45) then
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

function mod:TwoOfHearts(card, player, flags)
	local data = mod:GetData(player)
	if player:GetName() == "Leah" then
		if player:CanPickRedHearts() == false then
			data.HeartCount = data.HeartCount * 2
		end
	end
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.TwoOfHearts, Card.CARD_HEARTS_2)

function mod:shouldDeHook()
	local reqs = {
	  not game:GetHUD():IsVisible(),
	  game:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)
	}
	return reqs[1] or reqs[2]
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function() -- The actual heart counter for Leah
	if mod:shouldDeHook() then return end
	local charoffset=0
	local offset = Options.HUDOffset * Vector(20, 12)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:GetName() == "Leah" then
			if data.HeartCount > 99 then -- Cap hearts at 99
				data.HeartCount = 99
			end
			local f = Font()
			f:Load("font/pftempestasevencondensed.fnt")
			f:DrawString("P"..(player.ControllerIndex+1)..":",37 + offset.X,33 + offset.Y + charoffset, KColor(1, 1, 1, 1, 0, 0, 0), 0, true)
			local kcolour = KColor(1, 1, 1, 1, 0, 0, 0)
			if data.HeartCount > 1 and player:GetBrokenHearts() < 11 then
				kcolour = KColor(0, 1, 0, 1, 0, 0, 0)
			end
			f:DrawString(data.HeartCount, 63 + offset.X, 33 + offset.Y + charoffset, kcolour, 0, true)
			local counter = Sprite()
			counter:Load("gfx/heartcounter.anm2", true)
			counter:Play("Idle", true)
			counter:Render(Vector(48 + offset.X, 32.5 + offset.Y + charoffset), Vector(0, 0), Vector(0, 0))
			charoffset = charoffset + 12
		end
	end
end
)

function mod:SpawnChargeBar(player)
	local data =mod:GetData(player)
	local chargebar = Isaac.Spawn(Isaac.GetEntityTypeByName("Further Charge Bar"), 0, 0, player.Position, Vector.Zero, player):ToNPC()
	chargebar.Parent = player
	data.chargeBar = chargebar
	chargebar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NONE
	chargebar:ClearEntityFlags(EntityFlag.FLAG_APPEAR) --Skip spawning animations
	chargebar.CanShutDoors = false --Its not an enemy
	chargebar.DepthOffset = 255
	chargebar:GetSprite():SetFrame("Charging", 0)
	chargebar.Visible = false
end
  
function mod:ChargeBarUpdateRender(chargebar)
	if mod:shouldDeHook() then return nil end
	if not chargebar.Parent or not chargebar.Parent:Exists() then
		chargebar:Remove()
		return nil
	end
	if chargebar.Variant ~= 0 then
		return nil
	end
	local player = chargebar.Parent:ToPlayer()
	local data = mod:GetData(player)
	chargebar.Position = player.Position:__add(Vector(2, -65))
	chargebar.Velocity = player.Velocity
	
	local sprite = chargebar:GetSprite()
	
	local charge = (data.dropcooldown / 30) * 100
	
	local roundedCharge = math.floor(charge)
	if roundedCharge > 5 then
		chargebar.Visible = true
	end
	local drop = Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex)
	if sprite:IsPlaying("Disappear") then
		data.dropcooldown = 0
	elseif sprite:IsFinished("Disappear") then
		data.chargeBar = nil
		data.dropcooldown = 0
		chargebar:Remove()
	elseif roundedCharge <= 100 and sprite:GetAnimation() == "Charging" and drop then
		sprite:SetFrame("Charging",roundedCharge)
		data.dropcooldown = data.dropcooldown + 1
	elseif roundedCharge > 100 and sprite:GetAnimation() ~= "StartCharged" and sprite:GetAnimation() ~= "Disappear" then
		sprite:Play("StartCharged",true)
	elseif sprite:IsFinished("StartCharged") or not drop and sprite:GetAnimation() ~= "Disappear" then
		sprite:Play("Disappear",true)
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.ChargeBarUpdateRender, Isaac.GetEntityTypeByName("Further Charge Bar"))