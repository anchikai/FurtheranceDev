local mod = Furtherance
local game = Game()
local rng = RNG()
mod.Flipped = false

local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

local function switchBackground(isFlipped)
	local level = game:GetLevel()
	local room = game:GetRoom()
	if isFlipped == true then
		backdrop = room:GetBackdropType()
		if room:GetType() == RoomType.ROOM_DEFAULT or room:GetType() == RoomType.ROOM_TREASURE then
			if level:GetStageType() <= StageType.STAGETYPE_AFTERBIRTH then
				if level:GetStage() < LevelStage.STAGE4_3 then
					game:ShowHallucination(0, backdrop + 3)
				elseif level:GetStage() ~= LevelStage.STAGE4_3 and level:GetStage() < LevelStage.STAGE6 then
					game:ShowHallucination(0, backdrop + 2)
				end
			elseif level:GetStageType() >= StageType.STAGETYPE_REPENTANCE then
				if level:GetStage() < LevelStage.STAGE4_1 then
					if backdrop == clamp(backdrop, BackdropType.MAUSOLEUM2, BackdropType.MAUSOLEUM4) or backdrop == BackdropType.MAUSOLEUM then
						game:ShowHallucination(0, BackdropType.CORPSE)
					else
						game:ShowHallucination(0, backdrop + 1)
					end
				end
			end
		end
	elseif isFlipped == false then
		game:ShowHallucination(0, backdrop)
	end
	SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)
end

function mod:UseFlippedCross(_, _, player)
	local room = game:GetRoom()
	game:ShakeScreen(10)

	mod.Flipped = not mod.Flipped
	switchBackground(mod.Flipped)

	if mod.Flipped == true then
		SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_DEAD)
	else
		SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_ALIVE)
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseFlippedCross, CollectibleType.COLLECTIBLE_MUDDLED_CROSS)

function mod:RoomPersist()
	local room = game:GetRoom()
	if mod.Flipped == true then
		switchBackground(true)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RoomPersist)

function mod:UltraSecretPool(pool, decrease, seed)
	if mod.Flipped == true then
		if Rerolled ~= true then
			Rerolled = true
			return game:GetItemPool():GetCollectible(ItemPoolType.POOL_ULTRA_SECRET, false, seed, CollectibleType.COLLECTIBLE_NULL)
		end
		Rerolled = false
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.UltraSecretPool)

function mod:DoubleStuff(pickup)
	local room = game:GetRoom()
	if pickup.FrameCount ~= 1 or mod.Flipped ~= true then
		return
	end
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if pickup.SpawnerType ~= EntityType.ENTITY_PLAYER then
			pickup.SpawnerEntity = player
			pickup.SpawnerType = EntityType.ENTITY_PLAYER
			pickup.SpawnerVariant = player.Variant
			if mod.Flipped and room:IsFirstVisit() then
				local newItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, pickup.Variant, 0, Isaac.GetFreeNearPosition(pickup.Position, 40), Vector.Zero, player):ToPickup()
				newItem.Price = pickup.Price
				newItem.OptionsPickupIndex = pickup.OptionsPickupIndex
			end

			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.DoubleStuff)

function mod:HealthDrain(player)
	if mod.Flipped == true and player:GetHearts() > 1 and game:GetFrameCount() ~= 0 then
		local drainSpeed
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			drainSpeed = 420
		else
			drainSpeed = 210
		end
		if game:GetFrameCount() % drainSpeed == 0 then
			player:AddHearts(-1)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.HealthDrain)

function mod:TougherEnemies(entity, damage, flags, source, frames)
	if mod.Flipped ~= true then return end

	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
			if data.DamageTimeout == nil then
				data.DamageTimeout = false
			elseif data.DamageTimeout == true then
				data.DamageTimeout = false
				entity:SetColor(Color(0.709, 0.0196, 0.0196, 1, 0.65, 0, 0), 1, 1, false, false)
				return false
			else
				data.DamageTimeout = true
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.TougherEnemies)

function mod:FixInputs(entity, hook, button)
	if entity == nil then return end

	local player = entity:ToPlayer()
	if player == nil then return end

	if mod.Flipped ~= true then return end

	if button == ButtonAction.ACTION_DOWN then
		return Input.GetActionValue(ButtonAction.ACTION_UP, player.ControllerIndex)
	elseif button == ButtonAction.ACTION_UP then
		return Input.GetActionValue(ButtonAction.ACTION_DOWN, player.ControllerIndex)
	elseif button == ButtonAction.ACTION_SHOOTUP then
		return Input.GetActionValue(ButtonAction.ACTION_SHOOTDOWN, player.ControllerIndex)
	elseif button == ButtonAction.ACTION_SHOOTDOWN then
		return Input.GetActionValue(ButtonAction.ACTION_SHOOTUP, player.ControllerIndex)
	end
end
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, mod.FixInputs, InputHook.GET_ACTION_VALUE)

local flipFactor = 0
function mod:AnimateFlip()
	if mod.Flipped == true then
		flipFactor = flipFactor + 0.1
	elseif mod.Flipped == false then
		flipFactor = flipFactor - 0.1
	end
	flipFactor = clamp(flipFactor, 0, 1)
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.AnimateFlip)

-- Thank you im_tem for the shader!!
function mod:PeterFlip(name)
	if name == 'Peter Flip' then
		return { FlipFactor = flipFactor }
	end
end
mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, mod.PeterFlip)

function mod:ResetFlipped()
	if mod.Flipped == true then
		mod.Flipped = false
		flipFactor = 0
		switchBackground(false)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetFlipped)

local pauseTime = 0
function mod:FixMenu()
	if game:IsPaused() then
		pauseTime = math.min(pauseTime + 1, 26)
	else
		pauseTime = 0
	end
	if mod.Flipped then
		mod.Flipped = pauseTime < 25
		pausedFixed = true
	elseif pausedFixed and game:IsPaused() == false then
		mod.Flipped = true
	end
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.FixMenu)
