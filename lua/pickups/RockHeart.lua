local mod = Furtherance
local game = Game()
local sfx = SFXManager()
local RockSFX = Isaac.GetSoundIdByName("MoonHeartPickup")
local screenHelper = require("lua.screenhelper")
local rng = RNG()

-- API functions --

function Furtherance.AddRockHearts(player, amount, data) -- data is optional
	local index = mod:GetEntityIndex(player)
	if amount % 2 == 0 then
		if player:GetSoulHearts() % 2 ~= 0 then
			amount = amount - 1 -- if you already have a half heart, a new full rock heart always replaces it instead of adding another heart
		end
	end
	
	if player:CanPickBlackHearts() or amount < 0 then
		player:AddBlackHearts(amount)
	end
	mod.DataTable[index].FurtheranceRockHeart = mod.DataTable[index].FurtheranceRockHeart + amount
end

function Furtherance.GetRockHearts(player)
	return mod.DataTable[mod:GetEntityIndex(player)].FurtheranceRockHeart
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
		local data = mod.DataTable[mod:GetEntityIndex(player)]
		if data.FurtheranceRockHeart < (player:GetHeartLimit() - player:GetEffectiveMaxHearts()) and data.FurtheranceRockHeart < 2 then
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

local function renderingHearts(player,playeroffset)
	local index = mod:GetEntityIndex(player)
	local pType = player:GetPlayerType()
	local isForgotten = pType == PlayerType.PLAYER_THEFORGOTTEN and 1 or 0
	local transperancy = 1
	local isTotalEven = mod.DataTable[index].FurtheranceRockHeart % 2 == 0
	local level = game:GetLevel()
	if pType == PlayerType.PLAYER_JACOB2_B or player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) or isForgotten == 1 then
		transperancy = 0.3
	end
	if isForgotten == 1 then
		player = player:GetSubPlayer()
	end
	local heartIndex = math.ceil(mod.DataTable[index].FurtheranceRockHeart/2) - 1
	local goldHearts = player:GetGoldenHearts()
	local getMaxHearts = player:GetEffectiveMaxHearts() + (player:GetSoulHearts() + player:GetSoulHearts() % 2)
	local eternalHeart = player:GetEternalHearts()
	for i=0, heartIndex do
		local RockHeart = Sprite()
		RockHeart:Load("gfx/ui/ui_rockheart.anm2",true)

		local hearts = ((CanOnlyHaveSoulHearts(player) and player:GetBoneHearts()*2 or player:GetEffectiveMaxHearts()) + player:GetSoulHearts()) - (i * 2)
		local hpOffset = hearts%2 ~= 0 and (playeroffset == 5 and -6 or 6) or 0
		local playersHeartPos = {
			[1] = Options.HUDOffset * Vector(20, 12) + Vector(hearts*6+36+hpOffset, 12) + Vector(0,10) * isForgotten,
			[2] = screenHelper.GetScreenTopRight(0) + Vector(hearts*6+hpOffset-123,12) + Options.HUDOffset * Vector(-20*1.2, 12) + Vector(0,20) * isForgotten,
			[3] = screenHelper.GetScreenBottomLeft(0) + Vector(hearts*6+hpOffset+46,-27) + Options.HUDOffset * Vector(20*1.1, -12*0.5) + Vector(0,20) * isForgotten,
			[4] = screenHelper.GetScreenBottomRight(0) + Vector(hearts*6+hpOffset-131,-27) + Options.HUDOffset * Vector(-20*0.8, -12*0.5) + Vector(0,20) * isForgotten,
			[5] = screenHelper.GetScreenBottomRight(0) + Vector((-hearts)*6+hpOffset-36,-27) + Options.HUDOffset * Vector(-20*0.8, -12*0.5)
		}
		local offset = playersHeartPos[playeroffset]
		local offsetCol = (playeroffset == 1 or playeroffset == 5) and 13 or 7
		offset.X = offset.X  - math.floor(hearts / offsetCol) * (playeroffset == 5 and (-72) or (playeroffset == 1 and 72 or 36))
		offset.Y = offset.Y + math.floor(hearts / offsetCol) * 10
		local anim = "RockHeartFull"
		if not isTotalEven then
			if i == 0 then
				anim = "RockHeartHalf"
			end
		end
		if player:GetEffectiveMaxHearts() == 0 and i == (math.ceil(player:GetSoulHearts()/2) - 1)
		and eternalHeart > 0 then
			anim = anim.."Eternal"
		end
		if goldHearts - i > 0 then
			anim = anim.."Gold"
		end
		if i == 0 and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
		and getMaxHearts == player:GetHeartLimit() and not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE)
		and pType ~= PlayerType.PLAYER_JACOB2_B then
			anim = anim.."Mantle"
		end
				
		RockHeart.Color = Color(1,1,1,transperancy)
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
		RockHeart:Render(Vector(offset.X, offset.Y), Vector(0,0), Vector(0,0))
	end
end

function mod:onRender(shadername)
	if shadername ~= "Rock Hearts" then return end
	if mod:shouldDeHook() then return end
	local isJacobFirst = false
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local index = mod:GetEntityIndex(player)
		if i == 0 and player:GetPlayerType() == PlayerType.PLAYER_JACOB then
			isJacobFirst = true
		end
		
		if (player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B) then
			if player:GetOtherTwin() then
				if mod.DataTable[index].i and mod.DataTable[index].i == i then
					mod.DataTable[index].i = nil
				end
				if not mod.DataTable[index].i then
					local otherIndex = mod:GetEntityIndex(player:GetOtherTwin())
					mod.DataTable[otherIndex].i = i
				end
			elseif mod.DataTable[index].i then
				mod.DataTable[index].i = nil
			end
		end
		if player:GetPlayerType() ~= PlayerType.PLAYER_THESOUL_B and not player.Parent and not mod.DataTable[index].i then
			if player:GetPlayerType() == PlayerType.PLAYER_ESAU and isJacobFirst then
				renderingHearts(player,5)	
			elseif player:GetPlayerType() ~= PlayerType.PLAYER_ESAU then
				renderingHearts(player,i+1)
			end
		end
	end

end
mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, mod.onRender)

function mod:RockDamage(entity, damage, flag, source, cooldown)
	local player = entity:ToPlayer()
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then return nil end
	local index = mod:GetEntityIndex(player)
	player = player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN_B and player:GetOtherTwin() or player
	if mod.DataTable[index].FurtheranceRockHeart > 0 and damage > 0 then
		if not mod.DataTable[index].RockTakeDmg and source.Type ~= EntityType.ENTITY_DARK_ESAU then
			if flag & DamageFlag.DAMAGE_FAKE == 0 then
				if not ((flag & DamageFlag.DAMAGE_RED_HEARTS == DamageFlag.DAMAGE_RED_HEARTS or player:HasTrinket(TrinketType.TRINKET_CROW_HEART)) and player:GetHearts() > 0) then
					local isLastRock = mod.DataTable[index].FurtheranceRockHeart == 1 and player:GetSoulHearts() == 1 and player:GetEffectiveMaxHearts() == 0 and player:GetEternalHearts() > 0
					local NumSoulHearts = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2)
					if (mod.DataTable[index].FurtheranceRockHeart % 2 ~= 0) and not isLastRock then
						player:UseActiveItem(CollectibleType.COLLECTIBLE_WAIT_WHAT, false, false, true, false, -1)
						player:RemoveBlackHeart(NumSoulHearts)
					end
					--Checking for Half Rock and Eternal heart
					if not isLastRock then
						mod.DataTable[index].FurtheranceRockHeart = mod.DataTable[index].FurtheranceRockHeart - 1
						player:UseActiveItem(CollectibleType.COLLECTIBLE_WAIT_WHAT, false, false, true, false, -1)
					end
					mod.DataTable[index].RockTakeDmg = true
					player:TakeDamage(1, flag | DamageFlag.DAMAGE_NO_MODIFIERS, source, cooldown)
					if mod.DataTable[index].FurtheranceRockHeart > 0 then
						local cd = isLastRock and cooldown or 60
						player:ResetDamageCooldown()
						player:SetMinDamageCooldown(cd)
						if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B or player:GetPlayerType() == PlayerType.PLAYER_ESAU
						or player:GetPlayerType() == PlayerType.PLAYER_JACOB then
							player:GetOtherTwin():ResetDamageCooldown()
							player:GetOtherTwin():SetMinDamageCooldown(cd)
						end
					end
					return false
				end
			end
		else
			mod.DataTable[index].RockTakeDmg = nil
		end
	else
		mod.DataTable[index].RockTakeDmg = nil
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.RockDamage, EntityType.ENTITY_PLAYER)

function mod:HeartHandling(player)
	if player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
		player = player:GetSubPlayer()
	end
	local index = mod:GetEntityIndex(player)
	if mod.DataTable[index].FurtheranceRockHeart > 0 then
		mod.DataTable[index].FurtheranceRockHeart = mod.DataTable[index].FurtheranceRockHeart > player:GetSoulHearts() and player:GetSoulHearts() or mod.DataTable[index].FurtheranceRockHeart
		local heartIndex = math.ceil(mod.DataTable[index].FurtheranceRockHeart/2) - 1
		for i=0, heartIndex do
			local ExtraHearts = math.ceil(player:GetSoulHearts() / 2) + player:GetBoneHearts() - i
			local imHeartLastIndex = player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2) - i * 2
			if (player:IsBoneHeart(ExtraHearts - 1)) or not player:IsBlackHeart(player:GetSoulHearts() - (1 - player:GetSoulHearts() % 2) - i * 2) then
				for j = imHeartLastIndex, imHeartLastIndex - (heartIndex + 1) * 2, -2 do
					player:RemoveBlackHeart(j)
				end
				player:AddSoulHearts(-mod.DataTable[index].FurtheranceRockHeart)
				player:AddBlackHearts(mod.DataTable[index].FurtheranceRockHeart)
			end
			if player:GetEffectiveMaxHearts() + player:GetSoulHearts() == player:GetHeartLimit() and mod.DataTable[index].FurtheranceRockHeart == 1 then
				player:AddSoulHearts(-1)
			end
		end
		if player:GetSoulHearts() % 2 == 0 then
			if Furtherance.GetRockHearts(player) % 2 ~= 0 then
				mod.DataTable[index].FurtheranceRockHeart = mod.DataTable[index].FurtheranceRockHeart + 1
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

function mod:MorphHeart(entityType, variant, subType, position, velocity, spawner, seed)
	if entityType == EntityType.ENTITY_PICKUP then
		if variant == PickupVariant.PICKUP_HEART then
			if subType == HeartSubType.HEART_ETERNAL or subType == HeartSubType.HEART_GOLDEN then
				rng:SetSeed(seed, 1)
				if rng:RandomFloat() <= 0.5 then
					return {entityType, variant, HeartSubType.HEART_MOON, seed}
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, mod.MorphHeart)