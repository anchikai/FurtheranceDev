local mod = Furtherance
local game = Game()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

local ChargeBar = Sprite()
ChargeBar:Load("gfx/chargebar.anm2",true)
ChargeBar:LoadGraphics()

function mod:OnInit(player)
	local data = mod:GetData(player)
	if data.HeartCount == nil then
		data.HeartCount = 2
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:UseRenovator(_, _, player)
	if player:GetBrokenHearts() > 0 then
		local data = mod:GetData(player)
		SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
		player:AddBrokenHearts(-1)
		data.RenovatorDamage = data.RenovatorDamage + 1
	end
	player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
	player:AddCacheFlags(CacheFlag.CACHE_RANGE)
	player:EvaluateItems()
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseRenovator, CollectibleType.COLLECTIBLE_HEART_RENOVATOR)

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
		if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then -- Leah's Heart Counter Gimmick
			local MaximumCount = 99
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				MaximumCount = 999
			end
			if data.HeartCount < MaximumCount and entity:IsShopItem() == false then
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
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.Hearts, PickupVariant.PICKUP_HEART)

function mod:RenovatorDmg(player, flag)
	local data = mod:GetData(player)
	if data.RenovatorDamage == nil then
		data.RenovatorDamage = 0
	end
	if flag == CacheFlag.CACHE_DAMAGE then
		if player:GetName() == "Leah" and player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			player.Damage = player.Damage + data.RenovatorDamage * 0.2
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
			player.Damage = player.Damage + data.RenovatorDamage * 0.1
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.RenovatorDmg)

function mod:RenovatorOnKill(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
			local hrRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
			if hrRNG:RandomInt(16) == 0 then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SCARED, entity.Position, Vector(0, 0), player)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.RenovatorOnKill)

local dropCooldownSpeed = 150

function mod:OnUpdate(player)
	local room = game:GetRoom()
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
		local drop = Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex)
		local brokenHeart = false
		if data.dropcooldown == nil then
			data.dropcooldown = 0
		elseif not Game():IsPaused() then
			if not ChargeBar:IsPlaying("Disappear") then
				if drop and data.HeartCount >= 2 and data.dropcooldown < dropCooldownSpeed and player:GetBrokenHearts() < 11 then
					if not ChargeBar:IsPlaying("Charging") then
						ChargeBar:Play("Charging")
					else
						data.dropcooldown = data.dropcooldown + 1
						ChargeBar:SetFrame(100 - math.floor(data.dropcooldown*100/dropCooldownSpeed))
					end
					ChargeBar:SetLayerFrame(2,1)
					ChargeBar.Offset = Vector(0,-35)
					ChargeBar:Render(Game():GetRoom():WorldToScreenPosition(player.Position), Vector.Zero, Vector.Zero)
				elseif ChargeBar:IsPlaying("Charging") then
					if (not drop or data.dropcooldown >=dropCooldownSpeed) then
						ChargeBar:Play("Disappear")
					end
					if data.dropcooldown >= dropCooldownSpeed then
						brokenHeart = true
					end
				end
			else
				data.dropcooldown = 0
				if ChargeBar:IsPlaying("Disappear") then
					ChargeBar.PlaybackSpeed = 0.7
					if not ChargeBar:IsFinished("Disappear") then
						ChargeBar:Update()
						ChargeBar.Offset = Vector(0,-35)
						ChargeBar:Render(Game():GetRoom():WorldToScreenPosition(player.Position), Vector.Zero, Vector.Zero)
					end
				else ChargeBar:IsFinished("Disappear")
					ChargeBar:Play("Charging")
				end
			end
		end
		if brokenHeart and data.HeartCount >= 2 and player:GetBrokenHearts() < 11 then -- press drop button to remove 2 hearts and add a broken heart
			data.HeartCount = data.HeartCount - 2
			player:AddBrokenHearts(1)
			SFXManager():Play(bhb)
			player:AddCacheFlags(CacheFlag.CACHE_RANGE)
			player:EvaluateItems()
			data.dropcooldown = 0
			brokenHeart = false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mod.OnUpdate)

function mod:TwoOfHearts(card, player, flags)
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
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
	local charoffset = 0
	local transperancy = 1
	if EID and EID.lastDescriptionEntity then
		transperancy = 0.25
	end
	local offset = Options.HUDOffset * Vector(20, 12)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				if data.HeartCount > 999 then -- Cap hearts at 999 with Birthright
					data.HeartCount = 999
				end
			else
				if data.HeartCount > 99 then -- Cap hearts at 99
					data.HeartCount = 99
				end
			end
			local f = Font()
			f:Load("font/pftempestasevencondensed.fnt")
			f:DrawString("P"..player.ControllerIndex-(player.ControllerIndex-1)+i..":",37 + offset.X,33 + offset.Y + charoffset, KColor(1, 1, 1, transperancy), 0, true)
			local kcolour = KColor(1, 1, 1, transperancy)
			if data.HeartCount > 1 and player:GetBrokenHearts() < 11 then
				kcolour = KColor(0, 1, 0, transperancy)
			end
			f:DrawString(data.HeartCount, 63 + offset.X, 33 + offset.Y + charoffset, kcolour, 0, true)
			local counter = Sprite()
			counter:Load("gfx/heartcounter.anm2", true)
			counter:Play("Idle", true)
			counter.Color = Color(1,1,1,transperancy)
			counter:Render(Vector(48 + offset.X, 32.5 + offset.Y + charoffset), Vector(0, 0), Vector(0, 0))
			charoffset = charoffset + 12
		end
	end
end
)
