local mod = Furtherance
local game = Game()
local rng = RNG()

mod.Flipped = false

local function switchBackground(isFlipped)
	local level = game:GetLevel()
	local room = game:GetRoom()

	local levelName = level:GetName()
	if isFlipped == true then
		if room:GetType() == RoomType.ROOM_DEFAULT then
			if levelName == "Basement I" or levelName == "Basement II" or levelName == "Basement XL" then -- Basement
				game:ShowHallucination(0, BackdropType.CAVES)
			elseif levelName == "Cellar I" or levelName == "Cellar II" or levelName == "Cellar XL" then -- Cellar
				game:ShowHallucination(0, BackdropType.CATACOMBS)
			elseif levelName == "Burning Basement I" or levelName == "Burning Basement II" or levelName == "Burning Basement XL" then -- Burning Basement
				game:ShowHallucination(0, BackdropType.FLOODED_CAVES)
			elseif levelName == "Caves I" or levelName == "Caves II" or levelName == "Caves XL" then -- Caves
				game:ShowHallucination(0, BackdropType.DEPTHS)
			elseif levelName == "Catacombs I" or levelName == "Catacombs II" or levelName == "Catacombs XL" then -- Catacombs
				game:ShowHallucination(0, BackdropType.NECROPOLIS)
			elseif levelName == "Flooded Caves I" or levelName == "Flooded Caves II" or levelName == "Flooded Caves XL" then -- Flooded Caves
				game:ShowHallucination(0, BackdropType.DANK_DEPTHS)
			elseif levelName == "Depths I" or levelName == "Depths II" or levelName == "Depths XL" then -- Depths
				game:ShowHallucination(0, BackdropType.WOMB)
			elseif levelName == "Necropolis I" or levelName == "Necropolis II" or levelName == "Necropolis XL" then -- Necropolis
				game:ShowHallucination(0, BackdropType.UTERO)
			elseif levelName == "Dank Depths I" or levelName == "Dank Depths II" or levelName == "Dank Depths XL" then -- Dank Depths
				game:ShowHallucination(0, BackdropType.SCARRED_WOMB)
			elseif levelName == "Womb I" or levelName == "Womb II" or levelName == "Womb XL" or levelName == "Utero I" or levelName == "Utero II" or levelName == "Utero XL" or levelName == "Scarred Womb I" or levelName == "Scarred Womb II" or levelName == "Scarred Womb XL" then -- Womb, Utero, Scarred Womb
				game:ShowHallucination(0, BackdropType.BLUE_WOMB)
			elseif levelName == "???" then -- Blue Womb
				game:ShowHallucination(0, rng:RandomInt(2) + 14) -- Either pick Sheol or Cathedral
			elseif levelName == "Sheol" then -- Sheol
				game:ShowHallucination(0, BackdropType.DARKROOM)
			elseif levelName == "Cathedral" then -- Cathedral
				game:ShowHallucination(0, BackdropType.CHEST)
			elseif levelName == "Dark Room" then -- Dark Room
				game:ShowHallucination(0, BackdropType.DARKROOM)
			elseif levelName == "Chest" then -- Chest
				game:ShowHallucination(0, BackdropType.CHEST)
			elseif levelName == "Downpour I" or levelName == "Downpour II" or levelName == "Downpour XL" then -- Downpour
				game:ShowHallucination(0, BackdropType.MINES)
			elseif levelName == "Mines I" or levelName == "Mines II" or levelName == "Mines XL" then -- Mines
				game:ShowHallucination(0, BackdropType.MAUSOLEUM)
			elseif levelName == "Mausoleum I" or levelName == "Mausoleum II" or levelName == "Mausoleum XL" then -- Mausoleum
				game:ShowHallucination(0, BackdropType.CORPSE)
			elseif levelName == "Corpse I" or levelName == "Corpse II" or levelName == "Corpse XL" then -- Corpse
				game:ShowHallucination(0, BackdropType.CORPSE)
			elseif levelName == "Dross I" or levelName == "Dross II" or levelName == "Dross II" then -- Dross
				game:ShowHallucination(0, BackdropType.ASHPIT)
			elseif levelName == "Ashpit I" or levelName == "Ashpit II" or levelName == "Ashpit XL" then -- Ass Shit
				game:ShowHallucination(0, BackdropType.GEHENNA)
			elseif levelName == "Gehenna I" or levelName == "Gehenna II" or levelName == "Gehenna XL" then -- Gehenna
				game:ShowHallucination(0, BackdropType.MORTIS)
			elseif levelName == "Mortis I" or levelName == "Mortis II" or levelName == "Mortis XL" then -- Mortis
				game:ShowHallucination(0, BackdropType.MORTIS)
			end
		end
	elseif isFlipped == false then
		if levelName == "Basement I" or levelName == "Basement II" or levelName == "Basement XL" then
			game:ShowHallucination(0, BackdropType.BASEMENT)
		elseif levelName == "Cellar I" or levelName == "Cellar II" or levelName == "Cellar XL" then
			game:ShowHallucination(0, BackdropType.CELLAR)
		elseif levelName == "Burning Basement I" or levelName == "Burning Basement II" or levelName == "Burning Basement XL" then
			game:ShowHallucination(0, BackdropType.BURNT_BASEMENT)
		elseif levelName == "Caves I" or levelName == "Caves II" or levelName == "Caves XL" then
			game:ShowHallucination(0, BackdropType.CAVES)
		elseif levelName == "Catacombs I" or levelName == "Catacombs II" or levelName == "Catacombs XL" then
			game:ShowHallucination(0, BackdropType.CATACOMBS)
		elseif levelName == "Flooded Caves I" or levelName == "Flooded Caves II" or levelName == "Flooded Caves XL" then
			game:ShowHallucination(0, BackdropType.FLOODED_CAVES)
		elseif levelName == "Depths I" or levelName == "Depths II" or levelName == "Depths XL" then
			game:ShowHallucination(0, BackdropType.DEPTHS)
		elseif levelName == "Necropolis I" or levelName == "Necropolis II" or levelName == "Necropolis XL" then
			game:ShowHallucination(0, BackdropType.NECROPOLIS)
		elseif levelName == "Dank Depths I" or levelName == "Dank Depths II" or levelName == "Dank Depths XL" then
			game:ShowHallucination(0, BackdropType.DANK_DEPTHS)
		elseif levelName == "Womb I" or levelName == "Womb II" or levelName == "Womb XL" then
			game:ShowHallucination(0, BackdropType.WOMB)
		elseif levelName == "Utero I" or levelName == "Utero II" or levelName == "Utero XL" then
			game:ShowHallucination(0, BackdropType.UTERO)
		elseif levelName == "Scarred Womb I" or levelName == "Scarred Womb II" or levelName == "Scarred Womb XL" then
			game:ShowHallucination(0, BackdropType.SCARRED_WOMB)
		elseif levelName == "???" then
			game:ShowHallucination(0, BackdropType.BLUE_WOMB)
		elseif levelName == "Sheol" then
			game:ShowHallucination(0, BackdropType.SHEOL)
		elseif levelName == "Cathedral" then
			game:ShowHallucination(0, BackdropType.CATHEDRAL)
		elseif levelName == "Dark Room" then
			game:ShowHallucination(0, BackdropType.DARKROOM)
		elseif levelName == "Chest" then
			game:ShowHallucination(0, BackdropType.CHEST)
		elseif levelName == "Downpour I" or levelName == "Downpour II" or levelName == "Downpour XL" then
			game:ShowHallucination(0, BackdropType.DOWNPOUR)
		elseif levelName == "Mines I" or levelName == "Mines II" or levelName == "Mines XL" then
			game:ShowHallucination(0, BackdropType.MINES)
		elseif levelName == "Mausoleum I" or levelName == "Mausoleum II" or levelName == "Mausoleum XL" then
			game:ShowHallucination(0, BackdropType.MAUSOLEUM)
		elseif levelName == "Corpse I" or levelName == "Corpse II" or levelName == "Corpse XL" then
			game:ShowHallucination(0, BackdropType.CORPSE)
		elseif levelName == "Dross I" or levelName == "Dross II" or levelName == "Dross II" then
			game:ShowHallucination(0, BackdropType.DROSS)
		elseif levelName == "Ashpit I" or levelName == "Ashpit II" or levelName == "Ashpit XL" then
			game:ShowHallucination(0, BackdropType.ASHPIT)
		elseif levelName == "Gehenna I" or levelName == "Gehenna II" or levelName == "Gehenna XL" then
			game:ShowHallucination(0, BackdropType.GEHENNA)
		elseif levelName == "Mortis I" or levelName == "Mortis II" or levelName == "Mortis XL" then
			game:ShowHallucination(0, BackdropType.MORTIS)
		end
	end
	SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)
end

function mod:UseFlippedCross()
	local room = game:GetRoom()
	game:ShakeScreen(10)

	mod.Flipped = not mod.Flipped
	switchBackground(mod.Flipped)

	if mod.Flipped == true then
		SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_DEAD)

		room:SetFloorColor(Color(1, 1, 1, 1, 0.1, 0, 0))
		room:SetWallColor(Color(1, 1, 1, 1, 0.1, 0, 0))
	else
		SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_ALIVE)

		room:SetFloorColor(Color(1, 1, 1, 1, 0, 0, 0))
		room:SetWallColor(Color(1, 1, 1, 1, 0, 0, 0))
	end


	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseFlippedCross, CollectibleType.COLLECTIBLE_FLIPPED_CROSS)

function mod:RoomPersist()
	local room = game:GetRoom()
	if mod.Flipped == true then
		switchBackground(true)

		room:SetFloorColor(Color(1, 1, 1, 1, 0.1, 0, 0))
		room:SetWallColor(Color(1, 1, 1, 1, 0.1, 0, 0))
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

---@param pickup EntityPickup
function mod:DoubleStuff(pickup)
	if pickup.FrameCount ~= 1 or mod.Flipped ~= true then
		return
	end

	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if pickup.SpawnerType ~= EntityType.ENTITY_PLAYER then
			pickup.SpawnerEntity = player
			pickup.SpawnerType = EntityType.ENTITY_PLAYER
			pickup.SpawnerVariant = player.Variant

			local newItem = Isaac.Spawn(EntityType.ENTITY_PICKUP, pickup.Variant, 0, Isaac.GetFreeNearPosition(pickup.Position, 40), Vector.Zero, player):ToPickup()
			newItem.Price = pickup.Price
			newItem.OptionsPickupIndex = pickup.OptionsPickupIndex

			break
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.DoubleStuff)

---@param player EntityPlayer
function mod:HealthDrain(player)
	if mod.Flipped == true and player:GetHearts() > 1 and game:GetFrameCount() ~= 0 then
		local drainSpeed
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
			drainSpeed = 420
		else
			drainSpeed = 210
		end
		if game:GetFrameCount() % drainSpeed == 0 then
			Isaac.GetPlayer():AddHearts(-1)
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
			local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_FLIPPED_CROSS)
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

---@param entity Entity|nil
---@param hook InputHook
---@param button InputAction
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

local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

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
