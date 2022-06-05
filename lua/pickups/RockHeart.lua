local mod = Furtherance
local game = Game()
local sfx = SFXManager()
local RockSFX = Isaac.GetSoundIdByName("MoonHeartPickup")
local screenHelper = require("lua.screenhelper")
local rng = RNG()

local RockHeart = Sprite()
RockHeart:Load("gfx/ui/ui_rockheart.anm2", true)

mod:SavePlayerData({
	RockHeart = 0,
})

-- API functions --

function Furtherance.AddRockHearts(player, amount)
	if player:CanPickBlackHearts() or amount < 0 then
		player:AddBlackHearts(amount)
	end
	local data = mod:GetData(player)

	data.RockHeart = data.RockHeart + amount
end

function Furtherance.GetRockHearts(player)
	return mod:GetData(player).RockHeart
end

local function CanOnlyHaveSoulHearts(player)
	if player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY
		or player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY_B or player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS
		or player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B or player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B
		or player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B or player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
		return true
	end
	return false
end

function mod:RockHeartCollision(entity, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then
			player = player:GetMainTwin()
		end
		local data = mod:GetData(player)
		if data.RockHeart < (player:GetHeartLimit() - player:GetEffectiveMaxHearts()) and data.RockHeart < 24 then
			if entity.SubType == HeartSubType.HEART_ROCK then
				if player:GetPlayerType() == PlayerType.PLAYER_BETHANY or player:GetName() == "PeterB" then
					return false
				elseif player:GetPlayerType() ~= PlayerType.PLAYER_THELOST and player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B then
					Furtherance.AddRockHearts(player, 2)
				end
				entity.Velocity = Vector.Zero
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				entity:GetSprite():Play("Collect", true)
				entity:Die()
				sfx:Play(RockSFX, 1, 0)
				return true
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.RockHeartCollision, PickupVariant.PICKUP_HEART)

function mod:shouldDeHook()
	local reqs = {
		not game:GetHUD():IsVisible(),
		game:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD),
		game:GetLevel():GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN ~= 0
	}
	return reqs[1] or reqs[2] or reqs[3]
end

local function playersHeartPos(playerIndex, hearts, hpOffset, isForgotten)
	if playerIndex == 1 then -- player 1
		return Options.HUDOffset * Vector(20, 12)
			+ Vector(hearts * 6 + hpOffset + 36, 12)
			+ Vector(0, 10) * isForgotten
	elseif playerIndex == 2 then -- player 2
		return screenHelper.GetScreenTopRight(0)
			+ Vector(hearts * 6 + hpOffset - 123, 12)
			+ Options.HUDOffset * Vector(-20 * 1.2, 12)
			+ Vector(0, 20) * isForgotten
	elseif playerIndex == 3 then -- player 3
		return screenHelper.GetScreenBottomLeft(0)
			+ Vector(hearts * 6 + hpOffset + 46, -27)
			+ Options.HUDOffset * Vector(20 * 1.1, -12 * 0.5)
			+ Vector(0, 20) * isForgotten
	elseif playerIndex == 4 then -- player 4
		return screenHelper.GetScreenBottomRight(0)
			+ Vector(hearts * 6 + hpOffset - 131, -27)
			+ Options.HUDOffset * Vector(-20 * 0.8, -12 * 0.5)
			+ Vector(0, 20) * isForgotten
	elseif playerIndex == 5 then -- esau
		return screenHelper.GetScreenBottomRight(0) 
			+ Vector((-hearts) * 6 + hpOffset - 36, -27) 
			+ Options.HUDOffset * Vector(-20 * 0.8, -12 * 0.5)
	end
	return nil
end

local function renderingHearts(player, playeroffset)
	local data = mod:GetData(player)
	local pType = player:GetPlayerType()
	local isForgotten = pType == PlayerType.PLAYER_THEFORGOTTEN and 1 or 0
	local transperancy = 1
	if data.RockHeart == nil then return end
	local isTotalEven = data.RockHeart % 2 == 0
	if pType == PlayerType.PLAYER_JACOB2_B or player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) or isForgotten == 1 then
		transperancy = 0.3
	end
	if isForgotten == 1 then
		player = player:GetSubPlayer()
	end
	local heartIndex = math.ceil(data.RockHeart / 2) - 1
	local goldHearts = player:GetGoldenHearts()
	local getMaxHearts = player:GetEffectiveMaxHearts() + (player:GetSoulHearts() + player:GetSoulHearts() % 2)
	local eternalHeart = player:GetEternalHearts()
	for i = 0, heartIndex do
		local hearts = ((CanOnlyHaveSoulHearts(player) and player:GetBoneHearts() * 2 or player:GetEffectiveMaxHearts()) + player:GetSoulHearts()) - (i * 2)
		local hpOffset = hearts % 2 ~= 0 and (playeroffset == 5 and -6 or 6) or 0
		local offset = playersHeartPos(playeroffset, hearts, hpOffset, isForgotten)
		if offset == nil then return end
		local offsetCol = (playeroffset == 1 or playeroffset == 5) and 13 or 7
		offset.X = offset.X - math.floor(hearts / offsetCol) * (playeroffset == 5 and (-72) or (playeroffset == 1 and 72 or 36))
		offset.Y = offset.Y + math.floor(hearts / offsetCol) * 10
		local anim = "RockHeartFull"
		if not isTotalEven then
			if i == 0 then
				anim = "RockHeartHalf"
			end
		end
		if player:GetEffectiveMaxHearts() == 0 and i == (math.ceil(player:GetSoulHearts() / 2) - 1)
			and eternalHeart > 0 then
			anim = anim .. "Eternal"
		end
		if goldHearts - i > 0 then
			anim = anim .. "Gold"
		end
		if i == 0 and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
			and getMaxHearts == player:GetHeartLimit() and not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE)
			and pType ~= PlayerType.PLAYER_JACOB2_B then
			anim = anim .. "Mantle"
		end

		RockHeart.Color = Color(1, 1, 1, transperancy)
		--[[local rendering = RockHeart.Color.A > 0.1 or game:GetFrameCount() < 1
		if game:IsPaused() then
			pauseColorTimer = pauseColorTimer + 1
			if pauseColorTimer >= 20 and pauseColorTimer <= 30 and rendering then
				RockHeart.Color = Color.Lerp(RockHeart.Color,Color(1,1,1,0.1),0.1)
			end
		else
			pauseColorTimer = 0
			RockHeart.Color = Color(1,1,1,transperancy)
		end]]
		RockHeart:Play(anim, true)
		RockHeart:LoadGraphics()
		RockHeart.FlipX = playeroffset == 5
		RockHeart:Render(Vector(offset.X, offset.Y), Vector(0, 0), Vector(0, 0))
	end
end

function mod:onRender(shadername)
	if shadername ~= "Rock Hearts" then return end
	if mod:shouldDeHook() then return end
	local isJacobFirst = false
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		if i == 0 and player:GetPlayerType() == PlayerType.PLAYER_JACOB then
			isJacobFirst = true
		end

		if (player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B) then
			local otherTwin = player:GetOtherTwin()
			if otherTwin then
				if data.MoonHeart_i and data.MoonHeart_i == i then
					data.MoonHeart_i = nil
				end
				if not data.MoonHeart_i then
					local otherData = mod:GetData(otherTwin)
					otherData.MoonHeart_i = i
				end
			elseif data.MoonHeart_i then
				data.MoonHeart_i = nil
			end
		end
		if player:GetPlayerType() ~= PlayerType.PLAYER_THESOUL_B and not player.Parent and not data.MoonHeart_i then
			if player:GetPlayerType() == PlayerType.PLAYER_ESAU and isJacobFirst then
				renderingHearts(player, 5)
			elseif player:GetPlayerType() ~= PlayerType.PLAYER_ESAU then
				renderingHearts(player, i + 1)
			end
		end
	end

end

mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, mod.onRender)

function mod:RockDamage(entity, damage, flag, source, cooldown)
	local player = entity:ToPlayer()
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then return nil end
	local data = mod:GetData(player)
	player = player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B and player:GetOtherTwin() or player
	if data.RockHeart > 0 and damage > 0 then
		if not data.RockTakeDmg and source.Type ~= EntityType.ENTITY_DARK_ESAU then
			if flag & DamageFlag.DAMAGE_FAKE == 0 then
				if not ((flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS or player:HasTrinket(TrinketType.TRINKET_CROW_HEART)) and player:GetHearts() > 0) then
					local isLastRock = data.RockHeart == 1 and player:GetSoulHearts() == 1 and player:GetEffectiveMaxHearts() == 0 and player:GetEternalHearts() > 0
					local NumSoulHearts = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2)
					if (data.RockHeart % 2 ~= 0) and not isLastRock then
						player:RemoveBlackHeart(NumSoulHearts)
					end
					--Checking for Half Rock and Eternal heart
					if not isLastRock then
						data.RockHeart = data.RockHeart - 1
						player:UseActiveItem(CollectibleType.COLLECTIBLE_WAIT_WHAT, false, false, true, false, -1)
						SFXManager():Stop(SoundEffect.SOUND_FART)
					end
					data.RockTakeDmg = true
					player:TakeDamage(1, flag | DamageFlag.DAMAGE_NO_MODIFIERS, source, cooldown)
					if data.RockHeart > 0 then
						local cd = isLastRock and cooldown or 60
						player:ResetDamageCooldown()
						player:SetMinDamageCooldown(cd)
						if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B or player:GetPlayerType() == PlayerType.PLAYER_ESAU
							or player:GetPlayerType() == PlayerType.PLAYER_JACOB then
							player:GetOtherTwin():ResetDamageCooldown()
							player:GetOtherTwin():SetMinDamageCooldown(cd)
						end
					end
					for _, fart in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.FART)) do
						fart:Remove()
					end
					return false
				end
			end
		else
			data.RockTakeDmg = nil
		end
	else
		data.RockTakeDmg = nil
	end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.RockDamage, EntityType.ENTITY_PLAYER)

function mod:HeartHandling(player)
	if player.FrameCount == 0 then return end
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
		player = player:GetSubPlayer()
	end

	local data = mod:GetData(player)
	if data.RockHeart and data.RockHeart > 0 then
		data.RockHeart = data.RockHeart > player:GetSoulHearts() and player:GetSoulHearts() or data.RockHeart
		local heartIndex = math.ceil(data.RockHeart / 2) - 1
		for i = 0, heartIndex do
			local ExtraHearts = math.ceil(player:GetSoulHearts() / 2) + player:GetBoneHearts() - i
			local imHeartLastIndex = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2) - i * 2
			if (player:IsBoneHeart(ExtraHearts - 1)) or not player:IsBlackHeart(player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2) - i * 2) then
				for j = imHeartLastIndex, imHeartLastIndex - (heartIndex + 1) * 2, -2 do
					player:RemoveBlackHeart(j)
				end
				player:AddSoulHearts(-data.RockHeart)
				player:AddBlackHearts(data.RockHeart)
			end
			if player:GetEffectiveMaxHearts() + player:GetSoulHearts() == player:GetHeartLimit() and data.RockHeart == 1 then
				player:AddSoulHearts(-1)
			end
		end
		if player:GetSoulHearts() % 2 == 0 then
			if Furtherance.GetRockHearts(player) % 2 ~= 0 then
				data.RockHeart = data.RockHeart + 1
			end
		end
		if player:GetSoulHearts() % 2 ~= 0 then
			if Furtherance.GetRockHearts(player) % 2 == 0 then
				player:AddSoulHearts(1)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.HeartHandling)

local processedHearts = {}

function mod:MorphHeart(entityType, variant, subType, position, velocity, spawner, seed)
	if entityType == EntityType.ENTITY_PICKUP and variant == PickupVariant.PICKUP_HEART and processedHearts[seed] == nil then
		if subType == HeartSubType.HEART_ETERNAL or subType == HeartSubType.HEART_GOLDEN then
			processedHearts[seed] = true
			rng:SetSeed(seed, 1)
			if rng:RandomFloat() <= 0.293 then
				return { entityType, variant, HeartSubType.HEART_ROCK, seed }
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.MorphHeart)

function mod:ResetProcessedHearts()
	for seed in pairs(processedHearts) do
		processedHearts[seed] = nil
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ResetProcessedHearts)
