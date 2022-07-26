local mod = Furtherance
local game = Game()
local sfx = SFXManager()
local HeartsSFX = {MoonHeart = Isaac.GetSoundIdByName("MoonHeartPickup"), RockHeart = Isaac.GetSoundIdByName("MoonHeartPickup")}
local screenHelper = require("lua.screenhelper")
local rng = RNG()
local HeartsAnm =  {MoonHeart = Sprite(), RockHeart = Sprite()}
HeartsAnm.MoonHeart:Load("gfx/ui/ui_moonheart.anm2", true)
HeartsAnm.RockHeart:Load("gfx/ui/ui_rockheart.anm2", true)

mod:SavePlayerData({
	MoonHeart = 0,
	RockHeart = 0
})

-- API functions --

function Furtherance.AddHearts(player, amount, type)
	if amount % 2 == 0 then
		if player:GetSoulHearts() % 2 ~= 0 then
			amount = amount - 1 -- if you already have a half heart, a new full moon heart always replaces it instead of adding another heart
		end
	end

	if player:CanPickBlackHearts() or amount < 0 then
		player:AddBlackHearts(amount)
	end
	local data = mod:GetData(player)
	data[type] = data[type] + amount
end

function Furtherance.GetHearts(player,type)
	return mod:GetData(player)[type]
end

---@param player EntityPlayer
function Furtherance.CanPickHearts(player,type)
	return (type == "MoonHeart" and mod.GetHearts(player,type) < 2 or true) and player:CanPickBlackHearts()
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

function mod:MoonHeartCollision(entity, collider)
	local player = collider and collider:ToPlayer()
	if (entity.SubType == HeartSubType.HEART_MOON or entity.SubType == HeartSubType.HEART_ROCK) and player then
		if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then
			player = player:GetMainTwin()
		end
		local type = entity.SubType == HeartSubType.HEART_MOON and "MoonHeart" or "RockHeart"
		local typeLimit = {["MoonHeart"] = 2, ["RockHeart"] = player:GetHeartLimit()}
		local data = mod:GetData(player)
		if data[type] < (player:GetHeartLimit() - player:GetEffectiveMaxHearts() - data.MoonHeart) and data[type] < typeLimit[type] then
			if player:GetPlayerType() == PlayerType.PLAYER_BETHANY or player:GetName() == "PeterB" then
				return false
			elseif player:GetPlayerType() ~= PlayerType.PLAYER_THELOST and player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B then
				Furtherance.AddHearts(player, 2, type)
			end
			entity.Velocity = Vector.Zero
			entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
			entity:GetSprite():Play("Collect", true)
			entity:Die()
			sfx:Play(HeartsSFX[type], 1, 0)
			return true
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.MoonHeartCollision, PickupVariant.PICKUP_HEART)

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
			+ Vector(hearts * 6 + 36 + hpOffset, 12)
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
	if pType == PlayerType.PLAYER_JACOB2_B or player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) or isForgotten == 1 then
		transperancy = 0.3
	end
	if isForgotten == 1 then
		player = player:GetSubPlayer()
	end
	local isMoonPresent = 0
	local goldHearts = player:GetGoldenHearts()
	local getMaxHearts = player:GetEffectiveMaxHearts() + (player:GetSoulHearts() + player:GetSoulHearts() % 2)
	local eternalHeart = player:GetEternalHearts()
	for _,type in ipairs({"MoonHeart","RockHeart"}) do
		if data[type] == nil then goto continue end
		local isTotalEven = data[type] % 2 == 0
		local heartIndex = math.ceil(data[type] / 2) - 1
		for i = isMoonPresent, heartIndex + isMoonPresent do
			local hearts = ((CanOnlyHaveSoulHearts(player) and player:GetBoneHearts() * 2 or player:GetEffectiveMaxHearts()) + player:GetSoulHearts()) - (i * 2)
			local hpOffset = hearts % 2 ~= 0 and (playeroffset == 5 and -6 or 6) or 0
			local offset = playersHeartPos(playeroffset, hearts, hpOffset, isForgotten)
			if offset == nil then return end
			local offsetCol = (playeroffset == 1 or playeroffset == 5) and 13 or 7
			offset.X = offset.X - math.floor(hearts / offsetCol) * (playeroffset == 5 and (-72) or (playeroffset == 1 and 72 or 36))
			offset.Y = offset.Y + math.floor(hearts / offsetCol) * 10
			local anim = type.."Full"
			if not isTotalEven then
				if i == 0 then
					anim = type.."Half"
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

			HeartsAnm[type].Color = Color(1, 1, 1, transperancy)
			--[[local rendering = MoonHeart.Color.A > 0.1 or game:GetFrameCount() < 1
			if game:IsPaused() then
				pauseColorTimer = pauseColorTimer + 1
				if pauseColorTimer >= 20 and pauseColorTimer <= 30 and rendering then
					MoonHeart.Color = Color.Lerp(MoonHeart.Color,Color(1,1,1,0.1),0.1)
				end
			else
				pauseColorTimer = 0
				MoonHeart.Color = Color(1,1,1,transperancy)
			end]]
			HeartsAnm[type]:Play(anim, true)
			HeartsAnm[type]:LoadGraphics()
			HeartsAnm[type].FlipX = playeroffset == 5
			HeartsAnm[type]:Render(Vector(offset.X, offset.Y), Vector(0, 0), Vector(0, 0))
		end
		if type == "MoonHeart" and data.MoonHeart > 0 then isMoonPresent = 1 end
		::continue::
	end
end

function mod:onRender(shadername)
	if shadername ~= "Moon and Rock Hearts" then return end
	if mod:shouldDeHook() then return end
	local isJacobFirst = false
	local pNum = 1
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if not player.Parent then
			local data = mod:GetData(player)
			if i == 0 and player:GetPlayerType() == PlayerType.PLAYER_JACOB then
				isJacobFirst = true
			end
			if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B then
				-- what does this do???? = hides other T.Lazarus' health with birthright in inventory
				local otherTwin = player:GetOtherTwin()
				if otherTwin then
					if data.MoonHeart_i and data.MoonHeart_i == i then
						data.MoonHeart_i = nil
					end

					if data.MoonHeart_i == nil then
						local otherData = mod:GetData(otherTwin)
						otherData.MoonHeart_i = i
					end
				elseif data.MoonHeart_i then
					data.MoonHeart_i = nil
				end
			end

			if player:GetPlayerType() ~= PlayerType.PLAYER_THESOUL_B and data.MoonHeart_i == nil then
				if player:GetPlayerType() == PlayerType.PLAYER_ESAU and isJacobFirst then
					renderingHearts(player, 5)
				elseif player:GetPlayerType() ~= PlayerType.PLAYER_ESAU then
					renderingHearts(player,pNum)
					pNum = pNum + 1
				end
			end
			if pNum > 4 then break end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, mod.onRender)

function mod:MoonDamage(entity, damage, flag, source, cooldown)
	local player = entity:ToPlayer()
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then return nil end
	local data = mod:GetData(player)
	player = player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B and player:GetOtherTwin() or player
	for _,type in ipairs({"MoonHeart","RockHeart"}) do
		if data[type] > 0 and damage > 0 and player:GetDamageCooldown() <= 0 then
			if source.Type ~= EntityType.ENTITY_DARK_ESAU then
				if flag & DamageFlag.DAMAGE_FAKE == 0 then
					if not ((flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS or player:HasTrinket(TrinketType.TRINKET_CROW_HEART)) and player:GetHearts() > 0) then
						if type == "MoonHeart" then
							local isLastMoon = data.MoonHeart > 0 and player:GetSoulHearts() == damage and player:GetEffectiveMaxHearts() == 0 and player:GetEternalHearts() > 0
							local NumSoulHearts = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2)
							if not isLastMoon then
								player:UseCard(Card.CARD_MOON, 257)
								player:RemoveBlackHeart(NumSoulHearts)
								player:AddSoulHearts(-1)
								data.MoonHeart = data.MoonHeart - 2
							end
							damage = damage - 2
						else
							local isLastRock = data.RockHeart == damage and player:GetSoulHearts() == damage and player:GetEffectiveMaxHearts() == 0 and player:GetEternalHearts() > 0
							local NumSoulHearts = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2)
							if (data.RockHeart % 2 ~= 0) and not isLastRock then
								for i = 0, damage / 2 do
									local NumSoulHearts = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2) - 2 * i
									player:RemoveBlackHeart(NumSoulHearts)
								end
							end
							--Checking for Half Rock and Eternal heart
							if not isLastRock then
								data.RockHeart = data.RockHeart - damage
								data.TookRockDmg = true
								player:UseActiveItem(CollectibleType.COLLECTIBLE_WAIT_WHAT, false, false, true, false, -1)
								SFXManager():Stop(SoundEffect.SOUND_FART)
							end
							for _, fart in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.FART)) do
								fart:Remove()
							end
							if data.RockHeart <= 0 and not player:HasCollectible(CollectibleType.COLLECTIBLE_WAFER) and 
							not player:HasCollectible(CollectibleType.COLLECTIBLE_CANCER) then
								player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
							end
						end
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.MoonDamage, EntityType.ENTITY_PLAYER)

function mod:HeartHandling(player)
	if player.FrameCount == 0 then return end
	local forgottenCheck = player
	local data = mod:GetData(player)
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
		if forgottenCheck:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_WAFER) > 0
		and not player:HasCollectible(CollectibleType.COLLECTIBLE_WAFER) then
			forgottenCheck:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
		end
		player = player:GetSubPlayer()
	end

	if data.MoonHeart == nil then
		data.MoonHeart = 0
	end
	if data.RockHeart == nil then
		data.RockHeart = 0
	end

	if data.MoonHeart > 0 and data.MoonHeart ~= 2 then
		data.MoonHeart = 2
	elseif data.MoonHeart < 0 then
		data.MoonHeart = 0
	end
	if data.RockHeart < 0 then
		data.RockHeart = 0
	end

	if data.MoonHeart > 0 or data.RockHeart > 0 then
		if data.MoonHeart == 2 and player:GetSoulHearts() % 2 ~= 0 then
			player:AddSoulHearts(1)
		end

		data.RockHeart = data.RockHeart > player:GetSoulHearts() and player:GetSoulHearts() or data.RockHeart
		local ImmortalHeart = ComplianceImmortal and ComplianceImmortal.GetImmortalHearts(player) or 0
		local IHIndex = (ComplianceImmortal and ImmortalHeart > 0) and math.ceil(ImmortalHeart/2) - 1 or 0
		local heartIndex = math.ceil((data.RockHeart + data.MoonHeart)/2) - 1
		
		if player:GetSoulHearts() % 2 ~= 0 then
			if data.RockHeart % 2 == 0 then
				player:AddSoulHearts(1)
			end
		end
		if player:GetSoulHearts() % 2 == 0 then
			if data.RockHeart % 2 ~= 0 then
				data.RockHeart = data.RockHeart + 1
			end
		end

		for i=IHIndex, (heartIndex + IHIndex) do
			local ExtraHearts = math.ceil(player:GetSoulHearts() / 2) + player:GetBoneHearts() - i
			local HeartLastIndex = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2) - i * 2
			if (player:IsBoneHeart(ExtraHearts - 1)) or not player:IsBlackHeart(player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2) - i * 2) then
				for j = HeartLastIndex, HeartLastIndex - ((heartIndex + IHIndex) + 1) * 2, -2 do
					player:RemoveBlackHeart(j)
				end
				player:AddSoulHearts(-(data.RockHeart + data.MoonHeart))
				player:AddBlackHearts((data.RockHeart + data.MoonHeart))
			end
		end
		if ImmortalHeart <= 0 and data.RockHeart > 0 and data.MoonHeart == 0 
		and forgottenCheck:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_WAFER) < 1
		and forgottenCheck:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN then
			forgottenCheck:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_WAFER)
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
			if rng:RandomFloat() <= 0.293 then -- 1 - sqrt(0.5)
				return { entityType, variant, (rng:RandomInt(2) == 1 and HeartSubType.HEART_MOON or HeartSubType.HEART_ROCK), seed }
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