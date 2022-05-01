local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:UseFlippedCross(_, _, player)
	local data = mod:GetData(player)
	local level = game:GetLevel()
	local room = game:GetRoom()
	game:ShakeScreen(10)
	if data.Flipped == false then
		data.Flipped = true
		data.FlipShader = 1.25
		if room:GetType() == RoomType.ROOM_DEFAULT then
			if level:GetName() == "Basement I" or level:GetName() == "Basement II" or level:GetName() == "Basement XL" then -- Basement
				game:ShowHallucination(0, BackdropType.CAVES)
			elseif level:GetName() == "Cellar I" or level:GetName() == "Cellar II" or level:GetName() == "Cellar XL" then -- Cellar
				game:ShowHallucination(0, BackdropType.CATACOMBS)
			elseif level:GetName() == "Burning Basement I" or level:GetName() == "Burning Basement II" or level:GetName() == "Burning Basement XL" then -- Burning Basement
				game:ShowHallucination(0, BackdropType.FLOODED_CAVES)
			elseif level:GetName() == "Caves I" or level:GetName() == "Caves II" or level:GetName() == "Caves XL" then -- Caves
				game:ShowHallucination(0, BackdropType.DEPTHS)
			elseif level:GetName() == "Catacombs I" or level:GetName() == "Catacombs II" or level:GetName() == "Catacombs XL" then -- Catacombs
				game:ShowHallucination(0, BackdropType.NECROPOLIS)
			elseif level:GetName() == "Flooded Caves I" or level:GetName() == "Flooded Caves II" or level:GetName() == "Flooded Caves XL" then -- Flooded Caves
				game:ShowHallucination(0, BackdropType.DANK_DEPTHS)
			elseif level:GetName() == "Depths I" or level:GetName() == "Depths II" or level:GetName() == "Depths XL" then -- Depths
				game:ShowHallucination(0, BackdropType.WOMB)
			elseif level:GetName() == "Necropolis I" or level:GetName() == "Necropolis II" or level:GetName() == "Necropolis XL" then -- Necropolis
				game:ShowHallucination(0, BackdropType.UTERO)
			elseif level:GetName() == "Dank Depths I" or level:GetName() == "Dank Depths II" or level:GetName() == "Dank Depths XL" then -- Dank Depths
				game:ShowHallucination(0, BackdropType.SCARRED_WOMB)
			elseif level:GetName() == "Womb I" or level:GetName() == "Womb II" or level:GetName() == "Womb XL" or level:GetName() == "Utero I" or level:GetName() == "Utero II" or level:GetName() == "Utero XL" or level:GetName() == "Scarred Womb I" or level:GetName() == "Scarred Womb II" or level:GetName() == "Scarred Womb XL" then -- Womb, Utero, Scarred Womb
				game:ShowHallucination(0, BackdropType.BLUE_WOMB)
			elseif level:GetName() == "???" then -- Blue Womb
				game:ShowHallucination(0, rng:RandomInt(2) + 14) -- Either pick Sheol or Cathedral
			elseif level:GetName() == "Sheol" then -- Sheol
				game:ShowHallucination(0, BackdropType.DARKROOM)
			elseif level:GetName() == "Cathedral" then -- Cathedral
				game:ShowHallucination(0, BackdropType.CHEST)
			elseif level:GetName() == "Dark Room" then -- Dark Room
				game:ShowHallucination(0, BackdropType.DARKROOM)
			elseif level:GetName() == "Chest" then -- Chest
				game:ShowHallucination(0, BackdropType.CHEST)
			elseif level:GetName() == "Downpour I" or level:GetName() == "Downpour II" or level:GetName() == "Downpour XL" then -- Downpour
				game:ShowHallucination(0, BackdropType.MINES)
			elseif level:GetName() == "Mines I" or level:GetName() == "Mines II" or level:GetName() == "Mines XL" then -- Mines
				game:ShowHallucination(0, BackdropType.MAUSOLEUM)
			elseif level:GetName() == "Mausoleum I" or level:GetName() == "Mausoleum II" or level:GetName() == "Mausoleum XL" then -- Mausoleum
				game:ShowHallucination(0, BackdropType.CORPSE)
			elseif level:GetName() == "Corpse I" or level:GetName() == "Corpse II" or level:GetName() == "Corpse XL" then -- Corpse
				game:ShowHallucination(0, BackdropType.CORPSE)
			elseif level:GetName() == "Dross I" or level:GetName() == "Dross II" or level:GetName() == "Dross II" then -- Dross
				game:ShowHallucination(0, BackdropType.ASHPIT)
			elseif level:GetName() == "Ashpit I" or level:GetName() == "Ashpit II" or level:GetName() == "Ashpit XL" then -- Ass Shit
				game:ShowHallucination(0, BackdropType.GEHENNA)
			elseif level:GetName() == "Gehenna I" or level:GetName() == "Gehenna II" or level:GetName() == "Gehenna XL" then -- Gehenna
				game:ShowHallucination(0, BackdropType.MORTIS)
			elseif level:GetName() == "Mortis I" or level:GetName() == "Mortis II" or level:GetName() == "Mortis XL" then -- Mortis
				game:ShowHallucination(0, BackdropType.MORTIS)
			end
		end
		SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)
		SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_DEAD)
		room:SetFloorColor(Color(1, 1, 1, 1, 0.1, 0, 0))
		room:SetWallColor(Color(1, 1, 1, 1, 0.1, 0, 0))
	else
		data.Flipped = false
		data.FlipShader = 1
		if room:GetType() == RoomType.ROOM_DEFAULT then
			if level:GetName() == "Basement I" or level:GetName() == "Basement II" or level:GetName() == "Basement XL" then
				game:ShowHallucination(0, BackdropType.BASEMENT)
			elseif level:GetName() == "Cellar I" or level:GetName() == "Cellar II" or level:GetName() == "Cellar XL" then
				game:ShowHallucination(0, BackdropType.CELLAR)
			elseif level:GetName() == "Burning Basement I" or level:GetName() == "Burning Basement II" or level:GetName() == "Burning Basement XL" then
				game:ShowHallucination(0, BackdropType.BURNT_BASEMENT)
			elseif level:GetName() == "Caves I" or level:GetName() == "Caves II" or level:GetName() == "Caves XL" then
				game:ShowHallucination(0, BackdropType.CAVES)
			elseif level:GetName() == "Catacombs I" or level:GetName() == "Catacombs II" or level:GetName() == "Catacombs XL" then
				game:ShowHallucination(0, BackdropType.CATACOMBS)
			elseif level:GetName() == "Flooded Caves I" or level:GetName() == "Flooded Caves II" or level:GetName() == "Flooded Caves XL" then
				game:ShowHallucination(0, BackdropType.FLOODED_CAVES)
			elseif level:GetName() == "Depths I" or level:GetName() == "Depths II" or level:GetName() == "Depths XL" then
				game:ShowHallucination(0, BackdropType.DEPTHS)
			elseif level:GetName() == "Necropolis I" or level:GetName() == "Necropolis II" or level:GetName() == "Necropolis XL" then
				game:ShowHallucination(0, BackdropType.NECROPOLIS)
			elseif level:GetName() == "Dank Depths I" or level:GetName() == "Dank Depths II" or level:GetName() == "Dank Depths XL" then
				game:ShowHallucination(0, BackdropType.DANK_DEPTHS)
			elseif level:GetName() == "Womb I" or level:GetName() == "Womb II" or level:GetName() == "Womb XL" then
				game:ShowHallucination(0, BackdropType.WOMB)
			elseif level:GetName() == "Utero I" or level:GetName() == "Utero II" or level:GetName() == "Utero XL" then
				game:ShowHallucination(0, BackdropType.UTERO)
			elseif level:GetName() == "Scarred Womb I" or level:GetName() == "Scarred Womb II" or level:GetName() == "Scarred Womb XL" then
				game:ShowHallucination(0, BackdropType.SCARRED_WOMB)
			elseif level:GetName() == "???" then
				game:ShowHallucination(0, BackdropType.BLUE_WOMB)
			elseif level:GetName() == "Sheol" then
				game:ShowHallucination(0, BackdropType.SHEOL)
			elseif level:GetName() == "Cathedral" then
				game:ShowHallucination(0, BackdropType.CATHEDRAL)
			elseif level:GetName() == "Dark Room" then
				game:ShowHallucination(0, BackdropType.DARKROOM)
			elseif level:GetName() == "Chest" then
				game:ShowHallucination(0, BackdropType.CHEST)
			elseif level:GetName() == "Downpour I" or level:GetName() == "Downpour II" or level:GetName() == "Downpour XL" then
				game:ShowHallucination(0, BackdropType.DOWNPOUR)
			elseif level:GetName() == "Mines I" or level:GetName() == "Mines II" or level:GetName() == "Mines XL" then
				game:ShowHallucination(0, BackdropType.MINES)
			elseif level:GetName() == "Mausoleum I" or level:GetName() == "Mausoleum II" or level:GetName() == "Mausoleum XL" then
				game:ShowHallucination(0, BackdropType.MAUSOLEUM)
			elseif level:GetName() == "Corpse I" or level:GetName() == "Corpse II" or level:GetName() == "Corpse XL" then
				game:ShowHallucination(0, BackdropType.CORPSE)
			elseif level:GetName() == "Dross I" or level:GetName() == "Dross II" or level:GetName() == "Dross II" then
				game:ShowHallucination(0, BackdropType.DROSS)
			elseif level:GetName() == "Ashpit I" or level:GetName() == "Ashpit II" or level:GetName() == "Ashpit XL" then
				game:ShowHallucination(0, BackdropType.ASHPIT)
			elseif level:GetName() == "Gehenna I" or level:GetName() == "Gehenna II" or level:GetName() == "Gehenna XL" then
				game:ShowHallucination(0, BackdropType.GEHENNA)
			elseif level:GetName() == "Mortis I" or level:GetName() == "Mortis II" or level:GetName() == "Mortis XL" then
				game:ShowHallucination(0, BackdropType.MORTIS)
			end
		end
		SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)
		SFXManager():Play(SoundEffect.SOUND_LAZARUS_FLIP_ALIVE)
		room:SetFloorColor(Color(1, 1, 1, 1, 0, 0, 0))
		room:SetWallColor(Color(1, 1, 1, 1, 0, 0, 0))
	end
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseFlippedCross, CollectibleType.COLLECTIBLE_FLIPPED_CROSS)

function mod:RoomPersist()
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		local level = game:GetLevel()
		local room = game:GetRoom()
		if data.Flipped == true then
			if room:GetType() == RoomType.ROOM_DEFAULT then
				if level:GetName() == "Basement I" or level:GetName() == "Basement II" or level:GetName() == "Basement XL" then -- Basement
					game:ShowHallucination(0, BackdropType.CAVES)
				elseif level:GetName() == "Cellar I" or level:GetName() == "Cellar II" or level:GetName() == "Cellar XL" then -- Cellar
					game:ShowHallucination(0, BackdropType.CATACOMBS)
				elseif level:GetName() == "Burning Basement I" or level:GetName() == "Burning Basement II" or level:GetName() == "Burning Basement XL" then -- Burning Basement
					game:ShowHallucination(0, BackdropType.FLOODED_CAVES)
				elseif level:GetName() == "Caves I" or level:GetName() == "Caves II" or level:GetName() == "Caves XL" then -- Caves
					game:ShowHallucination(0, BackdropType.DEPTHS)
				elseif level:GetName() == "Catacombs I" or level:GetName() == "Catacombs II" or level:GetName() == "Catacombs XL" then -- Catacombs
					game:ShowHallucination(0, BackdropType.NECROPOLIS)
				elseif level:GetName() == "Flooded Caves I" or level:GetName() == "Flooded Caves II" or level:GetName() == "Flooded Caves XL" then -- Flooded Caves
					game:ShowHallucination(0, BackdropType.DANK_DEPTHS)
				elseif level:GetName() == "Depths I" or level:GetName() == "Depths II" or level:GetName() == "Depths XL" then -- Depths
					game:ShowHallucination(0, BackdropType.WOMB)
				elseif level:GetName() == "Necropolis I" or level:GetName() == "Necropolis II" or level:GetName() == "Necropolis XL" then -- Necropolis
					game:ShowHallucination(0, BackdropType.UTERO)
				elseif level:GetName() == "Dank Depths I" or level:GetName() == "Dank Depths II" or level:GetName() == "Dank Depths XL" then -- Dank Depths
					game:ShowHallucination(0, BackdropType.SCARRED_WOMB)
				elseif level:GetName() == "Womb I" or level:GetName() == "Womb II" or level:GetName() == "Womb XL" or level:GetName() == "Utero I" or level:GetName() == "Utero II" or level:GetName() == "Utero XL" or level:GetName() == "Scarred Womb I" or level:GetName() == "Scarred Womb II" or level:GetName() == "Scarred Womb XL" then -- Womb, Utero, Scarred Womb
					game:ShowHallucination(0, BackdropType.BLUE_WOMB)
				elseif level:GetName() == "???" then -- Blue Womb
					game:ShowHallucination(0, rng:RandomInt(2) + 14) -- Either pick Sheol or Cathedral
				elseif level:GetName() == "Sheol" then -- Sheol
					game:ShowHallucination(0, BackdropType.DARKROOM)
				elseif level:GetName() == "Cathedral" then -- Cathedral
					game:ShowHallucination(0, BackdropType.CHEST)
				elseif level:GetName() == "Dark Room" then -- Dark Room
					game:ShowHallucination(0, BackdropType.DARKROOM)
				elseif level:GetName() == "Chest" then -- Chest
					game:ShowHallucination(0, BackdropType.CHEST)
				elseif level:GetName() == "Downpour I" or level:GetName() == "Downpour II" or level:GetName() == "Downpour XL" then -- Downpour
					game:ShowHallucination(0, BackdropType.MINES)
				elseif level:GetName() == "Mines I" or level:GetName() == "Mines II" or level:GetName() == "Mines XL" then -- Mines
					game:ShowHallucination(0, BackdropType.MAUSOLEUM)
				elseif level:GetName() == "Mausoleum I" or level:GetName() == "Mausoleum II" or level:GetName() == "Mausoleum XL" then -- Mausoleum
					game:ShowHallucination(0, BackdropType.CORPSE)
				elseif level:GetName() == "Corpse I" or level:GetName() == "Corpse II" or level:GetName() == "Corpse XL" then -- Corpse
					game:ShowHallucination(0, BackdropType.CORPSE)
				elseif level:GetName() == "Dross I" or level:GetName() == "Dross II" or level:GetName() == "Dross II" then -- Dross
					game:ShowHallucination(0, BackdropType.ASHPIT)
				elseif level:GetName() == "Ashpit I" or level:GetName() == "Ashpit II" or level:GetName() == "Ashpit XL" then -- Ass Shit
					game:ShowHallucination(0, BackdropType.GEHENNA)
				elseif level:GetName() == "Gehenna I" or level:GetName() == "Gehenna II" or level:GetName() == "Gehenna XL" then -- Gehenna
					game:ShowHallucination(0, BackdropType.MORTIS)
				elseif level:GetName() == "Mortis I" or level:GetName() == "Mortis II" or level:GetName() == "Mortis XL" then -- Mortis
					game:ShowHallucination(0, BackdropType.MORTIS)
				end
			end
			SFXManager():Stop(SoundEffect.SOUND_DEATH_CARD)
			room:SetFloorColor(Color(1, 1, 1, 1, 0.1, 0, 0))
			room:SetWallColor(Color(1, 1, 1, 1, 0.1, 0, 0))
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.RoomPersist)

function mod:UltraSecretPool(pool, decrease, seed)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		local room = game:GetRoom()
		if data.Flipped == true then
			if Rerolled ~= true then
				Rerolled = true
				return game:GetItemPool():GetCollectible(ItemPoolType.POOL_ULTRA_SECRET, false, seed, CollectibleType.COLLECTIBLE_NULL)
			end
			Rerolled = false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, mod.UltraSecretPool)

local function getItemCount()
	local result = 0
	for _, entity in ipairs(Isaac.GetRoomEntities()) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			result = result + 1
		end
	end
	return result
end

function mod:DoubleStuff(pickup)
	if pickup.FrameCount ~= 1 then
		return
	end
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		local itemCount = getItemCount()
		if data.Flipped == true and pickup.SpawnerType ~= EntityType.ENTITY_PLAYER and itemCount < 10 then
			pickup.SpawnerEntity = player
			pickup.SpawnerType = EntityType.ENTITY_PLAYER
			pickup.SpawnerVariant = player.Variant
			Isaac.Spawn(EntityType.ENTITY_PICKUP, pickup.Variant, 0, Isaac.GetFreeNearPosition(pickup.Position, 40), Vector.Zero, player):ToPickup()
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.DoubleStuff)

function mod:HealthDrain(player)
	local data = mod:GetData(player)
	if data.Flipped == true then
		if player:GetHearts() > 1 then
			if (player and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)) then
				drainSpeed = 420
			else
				drainSpeed = 210
			end
			if game:GetFrameCount() % drainSpeed == 0 then
				Isaac.GetPlayer():AddHearts(-1)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.HealthDrain)

function mod:TougherEnemies(entity, damage, flags, source, frames)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		if data.Flipped == true then
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
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.TougherEnemies)

-- Thank you im_tem for the shader!!

function mod:PeterFlip(name)
	if name == 'Peter Flip' then
		return { FlipFactor = flipfactor }
	end
end

mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, mod.PeterFlip)

---@param entity Entity|nil
---@param hook InputHook
---@param button InputAction
function mod:FixInputs(entity, hook, button)
	if entity == nil then return end

	local player = entity:ToPlayer()
	if player == nil then return end

	local data = mod:GetData(player)
	if data.Flipped ~= true then return end

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

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local data = mod:GetData(player)
		if flipfactor == nil then
			flipfactor = 0
		elseif flipfactor < 0 then
			flipfactor = 0
		end
		if flipfactor > 1 then
			flipfactor = 1
		end
		if data.Flipped == true then
			if flipfactor < 1 then
				flipfactor = flipfactor + 0.1
			end
		elseif data.Flipped == false then
			if flipfactor > 0 then
				flipfactor = flipfactor - 0.1
			end
		end
	end
end)
