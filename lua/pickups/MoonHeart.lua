local mod = Furtherance
local game = Game()
local rng = RNG()
local moon = Isaac.GetSoundIdByName("MoonHeartPickup")
local sprite = Sprite()
local screenHelper = require("lua.screenhelper")

function mod:onStart(_, bool)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		if bool == false then
			data.MoonHeart = 0
			data.hpOffset = 0
		end
		if data.MoonHeart == nil then
			data.MoonHeart = 0
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onStart)

function mod:initData(player)
	local data = mod:GetData(player)
	if data.MoonHeart == nil then
		data.MoonHeart = 0
		data.hpOffset = 0
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.initData)

local function CanOnlyHaveSoulHearts(player)
	if player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY
	or player:GetPlayerType() == PlayerType.PLAYER_BLUEBABY_B or player:GetPlayerType() == PlayerType.PLAYER_BLACKJUDAS
	or player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B or player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B
	or player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then
		return true
	end
	return false
end

function mod:MoonHeartUpdate(entity, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
		local player = collider:ToPlayer()
		if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then
			player = player:GetMainTwin()
		end
		local data = mod:GetData(player)
		local truelimit = 2
		if entity.SubType == HeartSubType.HEART_FULL or entity.SubType == HeartSubType.HEART_HALF 
		or entity.SubType == HeartSubType.HEART_DOUBLEPACK or entity.SubType == HeartSubType.HEART_ETERNAL 
		or entity.SubType == HeartSubType.HEART_GOLDEN or entity.SubType == HeartSubType.HEART_ROTTEN then
			return nil
		end
		if entity.SubType == HeartSubType.HEART_BLACK then
			data.MoonHeart = 0
		end
		if entity.SubType == HeartSubType.HEART_HALF_SOUL then
			truelimit = 1
		end
		local effectiveHearts = CanOnlyHaveSoulHearts(player) and player:GetBrokenHearts() * 2 or player:GetEffectiveMaxHearts()
		if entity.SubType == HeartSubType.HEART_BLENDED and not CanOnlyHaveSoulHearts(player) then
			if (player:GetEffectiveMaxHearts() - player:GetHearts() == 1) and player:GetEffectiveMaxHearts() + player:GetSoulHearts() <= player:GetHeartLimit() - 3 then
				truelimit = 1
			end
		end
		if effectiveHearts + player:GetSoulHearts() + data.MoonHeart > player:GetHeartLimit() - truelimit then
			if entity.SubType == HeartSubType.HEART_BLENDED and not CanOnlyHaveSoulHearts(player) and player:GetEffectiveMaxHearts() > player:GetHearts() then
				return nil
			elseif (entity.SubType == HeartSubType.HEART_BLENDED or entity.SubType == HeartSubType.HEART_SOUL) and player:GetSoulHearts()%2==1 then
				entity:Morph(entity.Type, entity.Variant, HeartSubType.HEART_HALF_SOUL, true, true)
			else
				return false
			end
		end
		if entity.SubType == 225 then
			if (player:GetPlayerType() == PlayerType.PLAYER_THELOST or player:GetPlayerType() == PlayerType.PLAYER_THELOST_B) then
				entity:GetSprite():Play("Collect", true)
				entity:Remove()
				entity.Velocity = Vector.Zero
				SFXManager():Play(moon, 1, 0, false, 1.25)
				player:UseCard(Card.CARD_MOON, 257)
			elseif data.MoonHeart < 2 then
				if player:GetEffectiveMaxHearts() + player:GetSoulHearts() < player:GetHeartLimit() + 2 then
					entity:GetSprite():Play("Collect", true)
					entity:Die()
					entity.Velocity = Vector.Zero
					SFXManager():Play(moon, 1, 0, false, 1.25)
					data.MoonHeart = 2
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.MoonHeartUpdate, PickupVariant.PICKUP_HEART)

function mod:shouldDeHook()
	local reqs = {
	  not game:GetHUD():IsVisible(),
	  game:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)
	}
	return reqs[1] or reqs[2]
end

local function renderingHearts(player,playeroffset)
	local data = mod:GetData(player)
	if player:GetBlackHearts() > 0 then
		data.MoonHeart = 0
	end
	local transperancy = 1
	local level = game:GetLevel()
	if player:GetPlayerType() == PlayerType.PLAYER_JACOB2_B or player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then
		transperancy = 0.3
	end
	if level:GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN == 0 and data.MoonHeart > 0 then
		local hearts = (CanOnlyHaveSoulHearts(player) and player:GetBoneHearts()*2 or player:GetEffectiveMaxHearts()) + player:GetSoulHearts() + (player:GetBrokenHearts()*2)
		if hearts%2 ~= 0 then
			data.hpOffset = 6
		else
			data.hpOffset = 0
		end
		
		if hearts - (player:GetBrokenHearts()*2) > player:GetHeartLimit() - 2 then
			data.MoonHeart = 0
		end
		local playersHeartPos = {
			[1] = Options.HUDOffset * Vector(20, 12) + Vector(hearts*6+48+data.hpOffset, 12),
			[2] = screenHelper.GetScreenTopRight(0) + Vector(hearts*6+data.hpOffset-111,12) + Options.HUDOffset * Vector(-20*1.2, 12),
			[3] = screenHelper.GetScreenBottomLeft(0) + Vector(hearts*6+data.hpOffset+58,-27) + Options.HUDOffset * Vector(20*1.1, -12*0.5),
			[4] = screenHelper.GetScreenBottomRight(0) + Vector(hearts*6+data.hpOffset-119,-27) + Options.HUDOffset * Vector(-20*0.8, -12*0.5),
			[5] = screenHelper.GetScreenBottomRight(0) + Vector(hearts*6+data.hpOffset-88,-21) + Options.HUDOffset * Vector(-20*1.2, -12)
		}
		local offset = playersHeartPos[playeroffset]
		local offsetCol = (playeroffset == 1 or playeroffset == 5) and 12 or 6
		offset.X = offset.X  - math.floor(hearts / offsetCol) * (playeroffset == 5 and -72 or (playeroffset == 1 and 72 or 36))
		offset.Y = offset.Y + math.floor(hearts / offsetCol) * 10
		local anim = data.MoonHeart == 1 and "MoonHeartHalf" or "MoonHeartFull"
		sprite:Load("gfx/ui/ui_moonheart.anm2", true)
		sprite:Play(anim, true)
		sprite.Color = Color(1,1,1,transperancy)
		sprite.FlipX = playeroffset == 5
		sprite:Render(Vector(offset.X, offset.Y), Vector(0,0), Vector(0,0))
	end
end

function mod:onRender()
	if mod:shouldDeHook() then return end
	local players = 0
	local isJacobFirst = false
	for i = 0, game:GetNumPlayers() - 1 do
		if i < 3 or (i == 3 and not isJacobFirst) then
			local player = Isaac.GetPlayer(i)
			if i == 0 and player:GetPlayerType() == PlayerType.PLAYER_JACOB then
				isJacobFirst = true
			end
			local playeroffset
			local isIllusion = player:GetData().IllusionMod and player:GetData().IllusionMod.IsIllusion
			if  player:GetPlayerType() ~= PlayerType.PLAYER_THESOUL_B and not isIllusion then
				if player:GetPlayerType() ~= PlayerType.PLAYER_ESAU then
					players = players + 1
					playeroffset = players
				else
					playeroffset = 5
				end
				renderingHearts(player,playeroffset)	
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.onRender)

function mod:MoonHeartDamage(entity, amount, flag)
	local player = entity:ToPlayer()
	local data = mod:GetData(player)
	if (player:GetPlayerType() ~= PlayerType.PLAYER_THELOST or player:GetPlayerType() ~= PlayerType.PLAYER_THELOST_B or player:GetPlayerType() ~= PlayerType.PLAYER_JACOB2_B) then
		if data.MoonHeart == 2 and flag & DamageFlag.DAMAGE_FAKE == 0 then
			if rng:RandomInt(20) == 0 then
				data.MoonHeart = data.MoonHeart - 1
				player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, 1)
			else
				data.MoonHeart = data.MoonHeart - 2
				player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, 1)
				player:UseCard(Card.CARD_MOON, 257)
			end
			return false
		elseif data.MoonHeart == 1 and flag & DamageFlag.DAMAGE_FAKE == 0 then
			data.MoonHeart = data.MoonHeart - 1
			player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, 1)
			game:StartRoomTransition(game:GetLevel():QueryRoomTypeIndex(RoomType.ROOM_SUPERSECRET, false, RNG()), Direction.NO_DIRECTION ,3)
			return false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.MoonHeartDamage, EntityType.ENTITY_PLAYER)

function mod:MorphHeart(entity)
	local DropRNG = entity:GetDropRNG()
	if entity.SubType == HeartSubType.HEART_GOLDEN or entity.SubType == HeartSubType.HEART_ETERNAL then
		if DropRNG:RandomFloat() >= 0.5 then
			entity:Morph(entity.Type, entity.Variant, 225)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_INIT, mod.MorphHeart, PickupVariant.PICKUP_HEART)

function mod:DropSound(entity)
	if entity.SubType == 225 then
		if SFXManager():IsPlaying(SoundEffect.SOUND_MEAT_FEET_SLOW0) then
			SFXManager():Stop(SoundEffect.SOUND_MEAT_FEET_SLOW0)
			SFXManager():Play(SoundEffect.SOUND_STONE_IMPACT)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.DropSound, PickupVariant.PICKUP_HEART)