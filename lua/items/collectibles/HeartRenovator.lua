local mod = Furtherance
local game = Game()

mod:SavePlayerData({
	HeartCount = 0,
	RenovatorDamage = 0
})

function mod:LeahHeartCount(isContinued)
	if isContinued then return end
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == PlayerType.PLAYER_LEAH then
			mod:GetData(player).HeartCount = 2
		end
	end
end
mod:AddCallback(mod.CustomCallbacks.MC_POST_LOADED, mod.LeahHeartCount)

local BrokenHeartbeatSound = Isaac.GetSoundIdByName("BrokenHeartbeat")

local ChargeBar = Sprite()
ChargeBar:Load("gfx/chargebar.anm2",true)
ChargeBar:LoadGraphics()

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

	local player = collider:ToPlayer()
	if player == nil then return end
	local data = mod:GetData(player)

	-- Leah's Heart Counter Gimmick
	if not player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then return end

	local MaximumCount = 99
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
		MaximumCount = 999
	end

	if data.HeartCount >= MaximumCount or entity:IsShopItem() then return end

	for subtype, amount in pairs(heartCounter) do
		if entity.SubType == subtype then
			local emptyHearts = player:GetEffectiveMaxHearts() - player:GetHearts()
			local fullHearts = player:GetHearts() + player:GetSoulHearts() + player:GetBrokenHearts() * 2
			if emptyHearts <= amount then
				if subtype ~= HeartSubType.HEART_BLENDED then
					data.HeartCount = data.HeartCount + amount - emptyHearts
				elseif fullHearts == 24 then
					data.HeartCount = data.HeartCount + 2
				elseif fullHearts == 23 then
					data.HeartCount = data.HeartCount + 1
				end

				if not player:CanPickRedHearts() then
					entity:GetSprite():Play("Collect",true)
					entity:Die()
					SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
				elseif player:CanPickRedHearts() and RepentancePlusMod then
					if entity.SubType == CustomPickups.TaintedHearts.HEART_HOARDED then
						entity:GetSprite():Play("Collect",true)
						entity:Die()
						SFXManager():Play(SoundEffect.SOUND_BOSS2_BUBBLES, 1, 0, false)
						player:AddHearts(emptyHearts)
					end
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.Hearts, PickupVariant.PICKUP_HEART)

function mod:RenovatorDmg(player, flag)
	local data = mod:GetData(player)
	if flag == CacheFlag.CACHE_DAMAGE then
		if player:GetPlayerType() == PlayerType.PLAYER_LEAH and player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			player.Damage = player.Damage + data.RenovatorDamage * 0.2
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
			player.Damage = player.Damage + data.RenovatorDamage * 0.1
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.RenovatorDmg)

function mod:RenovatorOnKill(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
			local hrRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
			if entity:IsActiveEnemy(false) then
				if hrRNG:RandomInt(16) == 0 then
					Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SCARED, entity.Position, Vector.Zero, player)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.RenovatorOnKill)

local wasPressed = false
local numPresses = 0
local pressCd = 0
local SnailSpeed = 0
function mod:OnUpdate(player)
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) and data.HeartCount >= 2 then
		local isPressed = Input.IsActionPressed(ButtonAction.ACTION_DROP, player.ControllerIndex)
		if Furtherance.LeahDoubleTapSpeed == 5 then
			SnailSpeed = 15
		else
			SnailSpeed =  0
		end
		if isPressed then
			if not wasPressed then
				numPresses = numPresses + 1
			end
			pressCd = 3 * (Furtherance.LeahDoubleTapSpeed + SnailSpeed)
		elseif pressCd > 0 then
			pressCd = pressCd - 1
		elseif pressCd == 0 then
			numPresses = 0
		end
		if not wasPressed and isPressed and numPresses >= 2 then
			data.HeartCount = data.HeartCount - 2
			player:AddBrokenHearts(1)
			SFXManager():Play(BrokenHeartbeatSound)
			player:AddCacheFlags(CacheFlag.CACHE_RANGE)
			player:EvaluateItems()
		end
		wasPressed = isPressed
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
	local transparency = 1
	if EID and EID.lastDescriptionEntity then
		transparency = 0.25
	end

	local offset = Options.HUDOffset * Vector(20, 12)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
			if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
				-- Cap hearts at 999 with Birthright
				data.HeartCount = math.min(data.HeartCount, 999)
			else
				-- Cap hearts at 99
				data.HeartCount = math.min(data.HeartCount, 99)
			end

			local kcolour = KColor(1, 1, 1, transparency)
			if data.HeartCount > 1 and player:GetBrokenHearts() < 11 then
				kcolour = KColor(0, 1, 0, transparency)
			end

			local charoffset = 12 * i

			local f = Font()
			f:Load("font/pftempestasevencondensed.fnt")
			f:DrawString("P" .. (i + 1) .. ":", 37 + offset.X,33 + offset.Y + charoffset, KColor(1, 1, 1, transparency), 0, true)
			f:DrawString(data.HeartCount, 63 + offset.X, 33 + offset.Y + charoffset, kcolour, 0, true)

			local counter = Sprite()
			counter:Load("gfx/heartcounter.anm2", true)
			counter:Play("Idle", true)
			counter.Color = Color(1, 1, 1, transparency)
			counter:Render(Vector(48 + offset.X, 32.5 + offset.Y + charoffset), Vector.Zero, Vector.Zero)
		end
	end
end)