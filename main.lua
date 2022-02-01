further = RegisterMod("Furtherance", 1)
local mod = further
local json = require("json")
local loading = {}
local loadTimer
local game = Game()
local rng = RNG()

local laugh = Isaac.GetSoundIdByName("Sitcom_Laugh_Track")
further.FailSound = SoundEffect.SOUND_EDEN_GLITCH

-- Keys
CollectibleType.COLLECTIBLE_ESC_KEY = Isaac.GetItemIdByName("Esc Key")
CollectibleType.COLLECTIBLE_TILDE_KEY = Isaac.GetItemIdByName("Tilde Key")
CollectibleType.COLLECTIBLE_ALT_KEY = Isaac.GetItemIdByName("Alt Key")
CollectibleType.COLLECTIBLE_SPACEBAR_KEY = Isaac.GetItemIdByName("Spacebar Key")
CollectibleType.COLLECTIBLE_BACKSPACE_KEY = Isaac.GetItemIdByName("Backspace Key")
CollectibleType.COLLECTIBLE_Q_KEY = Isaac.GetItemIdByName("Q Key")
CollectibleType.COLLECTIBLE_E_KEY = Isaac.GetItemIdByName("E Key")
CollectibleType.COLLECTIBLE_C_KEY = Isaac.GetItemIdByName("C Key")
CollectibleType.COLLECTIBLE_CAPS_KEY = Isaac.GetItemIdByName("Caps Key")
CollectibleType.COLLECTIBLE_ENTER_KEY = Isaac.GetItemIdByName("Enter Key")
CollectibleType.COLLECTIBLE_SHIFT_KEY = Isaac.GetItemIdByName("Shift Key")
-- Astrological Signs
CollectibleType.COLLECTIBLE_OPHIUCHUS = Isaac.GetItemIdByName("Ophiuchus")
CollectibleType.COLLECTIBLE_CHIRON = Isaac.GetItemIdByName("Chiron")
CollectibleType.COLLECTIBLE_CERES = Isaac.GetItemIdByName("Ceres")
CollectibleType.COLLECTIBLE_PALLAS = Isaac.GetItemIdByName("Pallas")
CollectibleType.COLLECTIBLE_JUNO = Isaac.GetItemIdByName("Juno")
CollectibleType.COLLECTIBLE_VESTA = Isaac.GetItemIdByName("Vesta")
-- New
TrinketType.TRINKET_HOLY_HEART = Isaac.GetTrinketIdByName("Holy Heart")
CollectibleType.COLLECTIBLE_TECH_IX = Isaac.GetItemIdByName("Tech IX")
CollectibleType.COLLECTIBLE_LEAKING_TANK = Isaac.GetItemIdByName("Leaking Tank")
CollectibleType.COLLECTIBLE_UNSTABLE_CORE = Isaac.GetItemIdByName("Unstable Core")
CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1 = Isaac.GetItemIdByName("Technology -1")
CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS = Isaac.GetItemIdByName("Book of Swiftness")
CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT = Isaac.GetItemIdByName("Book of Ambit")
CollectibleType.COLLECTIBLE_NEASS = Isaac.GetItemIdByName("Plug N' Play")
TrinketType.TRINKET_CRINGE = Isaac.GetTrinketIdByName("Cringe")
CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ = Isaac.GetItemIdByName("ZZZZoptionsZZZZ")
CollectibleType.COLLECTIBLE_BRUNCH = Isaac.GetItemIdByName("Brunch")
CollectibleType.COLLECTIBLE_CRAB_LEGS = Isaac.GetItemIdByName("Crab Legs")
CollectibleType.COLLECTIBLE_OWLS_EYE = Isaac.GetItemIdByName("Owl's Eye")
TrinketType.TRINKET_SLICK_WORM = Isaac.GetTrinketIdByName("Slick Worm")
CollectibleType.COLLECTIBLE_HEART_RENOVATOR = Isaac.GetItemIdByName("Heart Renovator")
CollectibleType.COLLECTIBLE_PHARAOH_CAT = Isaac.GetItemIdByName("Pharaoh Cat")
CollectibleType.COLLECTIBLE_F4_KEY = Isaac.GetItemIdByName("F4 Key")
CollectibleType.COLLECTIBLE_TAB_KEY = Isaac.GetItemIdByName("Tab Key")
CollectibleType.COLLECTIBLE_SHATTERED_HEART = Isaac.GetItemIdByName("Shattered Heart")
TrinketType.TRINKET_GRASS = Isaac.GetTrinketIdByName("Grass")

function mod:playFailSound()
	SFXManager():Play(further.FailSound)
end

-- Item Luas
include("lua/items/Esc.lua")
include("lua/items/Tilde.lua")
include("lua/items/Alt.lua")
include("lua/items/Spacebar.lua")
include("lua/items/Backspace.lua")
include("lua/items/Q.lua")
include("lua/items/E.lua")
include("lua/items/C.lua")
include("lua/items/Caps.lua")
include("lua/items/Enter.lua")
include("lua/items/Shift.lua")
include("lua/items/Ophiuchus.lua")
include("lua/items/Chiron.lua")
include("lua/items/Ceres.lua")
include("lua/items/Pallas.lua")
include("lua/items/Juno.lua")
include("lua/items/Vesta.lua")
include("lua/items/HolyHeart.lua")
include("lua/items/TechIX.lua")
include("lua/items/LeakingTank.lua")
include("lua/items/UnstableCore.lua")
--include("lua/items/Technology-1.lua")
include("lua/items/BookOfSwiftness.lua")
include("lua/items/BookOfAmbit.lua")
include("lua/items/NEASS.lua")
include("lua/items/Cringe.lua")
include("lua/items/ZZZZoptionsZZZZ.lua")
include("lua/items/Brunch.lua")
include("lua/items/CrabLegs.lua")
include("lua/items/OwlsEye.lua")
include("lua/items/SlickWorm.lua")
include("lua/items/HeartRenovator.lua")
include("lua/items/PharaohCat.lua")
include("lua/items/F4.lua")
include("lua/items/Tab.lua")
include("lua/items/ShatteredHeart.lua")
include("lua/items/Grass.lua")

-- Save Data/Unlocks
include("lua/achievements.lua")

function mod:OnSave(isSaving)
	local save = {}
	if isSaving then
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			if player:GetName() == "Leah" then
				save["player_"..tostring(i+1)] = data.leahkills
				save["player_"..tostring(i+1)] = data.HeartCount
			end
		end
	end
	save.Unlocks = json.encode(mod.Unlocks)
	mod:SaveData(json.encode(save))
end

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.OnSave)

function mod:OnLoad(isLoading)
	if isLoading and mod:HasData() then
		local loadData = json.decode(mod:LoadData())
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			if loadData["player_"..tostring(i+1)] then
				if player:GetName() == "Leah" then
					data.leahkills = json.decode(loadData["player_"..tostring(i+1)])
					data.HeartCount = json.decode(loadData["player_"..tostring(i+1)])
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.OnLoad)

-- Curses & Blessings Lua
include("lua/curses/Curses.lua")

-- Players
include("lua/players/Leah.lua")

-- prevent shaders crash
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function()
    if #Isaac.FindByType(EntityType.ENTITY_PLAYER) == 0 then
        Isaac.ExecuteCommand("reloadshaders")
    end
end)

----- Mod Support -----

if EID then
	include("lua/eid.lua")
end

if Encyclopedia then
	include("lua/encyclopedia.lua")
end

if Poglite then
	local pogCostumeB = Isaac.GetCostumeIdByPath("gfx/characters/Character_001b_Leah_Pog.anm2")
	Poglite:AddPogCostume("LeahBPog", taintedLeah, pogCostumeB)
end

local MCMLoaded, MCM = pcall(require, "scripts.modconfig")

if MCMLoaded then
	function AnIndexOf(t, val)
		for k, v in ipairs(t) do
			if v == val then
				return k
			end
		end
		return 1
	end
	
	MCM.AddSetting(
		"Furtherance",
		"Sound Effects",
		{
			Type = ModConfigMenu.OptionType.BOOLEAN,
			CurrentSetting = function()
				return further.FailSound ~= laugh
			end,
			Display = function()
				local sstr = "???"
				if further.FailSound == laugh then sstr = "Laugh Track"
				elseif further.FailSound == SoundEffect.SOUND_EDEN_GLITCH then sstr = "Default" end
				return "Item Fails Sound Effect: " .. sstr
			end,
			OnChange = function(current_bool)
				if current_bool then
					further.FailSound = SoundEffect.SOUND_EDEN_GLITCH
				else
					further.FailSound = laugh
				end
			end
		}
	)
end

----- Mod Support End -----

-----------------------------------
--Helper Functions (thanks piber)--
-----------------------------------

function mod:GetPlayers(functionCheck, ...)

	local args = {...}
	local players = {}
	
	local game = Game()
	
	for i=1, game:GetNumPlayers() do
	
		local player = Isaac.GetPlayer(i-1)
		
		local argsPassed = true
		
		if type(functionCheck) == "function" then
		
			for j=1, #args do
			
				if args[j] == "player" then
					args[j] = player
				elseif args[j] == "currentPlayer" then
					args[j] = i
				end
				
			end
			
			if not functionCheck(table.unpack(args)) then
			
				argsPassed = false
				
			end
			
		end
		
		if argsPassed then
			players[#players+1] = player
		end
		
	end
	
	return players
	
end

function mod:GetPlayerFromTear(tear)
	for i=1, 3 do
		local check = nil
		if i == 1 then
			check = tear.Parent
		elseif i == 2 then
			check = mod:GetSpawner(tear)
		elseif i == 3 then
			check = tear.SpawnerEntity
		end
		if check then
			if check.Type == EntityType.ENTITY_PLAYER then
				return mod:GetPtrHashEntity(check):ToPlayer()
			elseif check.Type == EntityType.ENTITY_FAMILIAR and check.Variant == FamiliarVariant.INCUBUS then
				local data = mod:GetData(tear)
				data.IsIncubusTear = true
				return check:ToFamiliar().Player:ToPlayer()
			end
		end
	end
	return nil
end

function mod:GetSpawner(entity)
	if entity and entity.GetData then
		local spawnData = mod:GetSpawnData(entity)
		if spawnData and spawnData.SpawnerEntity then
			local spawner = mod:GetPtrHashEntity(spawnData.SpawnerEntity)
			return spawner
		end
	end
	return nil
end

function mod:GetSpawnData(entity)
	if entity and entity.GetData then
		local data = mod:GetData(entity)
		return data.SpawnData
	end
	return nil
end

function mod:GetPtrHashEntity(entity)
	if entity then
		if entity.Entity then
			entity = entity.Entity
		end
		for _, matchEntity in pairs(Isaac.FindByType(entity.Type, entity.Variant, entity.SubType, false, false)) do
			if GetPtrHash(entity) == GetPtrHash(matchEntity) then
				return matchEntity
			end
		end
	end
	return nil
end

function mod:GetData(entity)
	if entity and entity.GetData then
		local data = entity:GetData()
		if not data.further then
			data.further = {}
		end
		return data.further
	end
	return nil
end

local entitySpawnData = {}
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, function(_, type, variant, subType, position, velocity, spawner, seed)
	entitySpawnData[seed] = {
		Type = type,
		Variant = variant,
		SubType = subType,
		Position = position,
		Velocity = velocity,
		SpawnerEntity = spawner,
		InitSeed = seed
	}
end)
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, entity)
	local seed = entity.InitSeed
	local data = mod:GetData(entity)
	data.SpawnData = entitySpawnData[seed]
end)
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, function(_, entity)
	local data = mod:GetData(entity)
	data.SpawnData = nil
end)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	entitySpawnData = {}
end)

function mod:GetRandomNumber(numMin, numMax, rng)
	if not numMax then
		numMax = numMin
		numMin = nil
	end
	
	rng = rng or RNG()

	if type(rng) == "number" then
		local seed = rng
		rng = RNG()
		rng:SetSeed(seed, 1)
	end
	
	if numMin and numMax then
		return rng:Next() % (numMax - numMin + 1) + numMin
	elseif numMax then
		return rng:Next() % numMin
	end
	return rng:Next()
end

OnRenderCounter = 0
IsEvenRender = true
mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	OnRenderCounter = OnRenderCounter + 1
	
	IsEvenRender = false
	if Isaac.GetFrameCount()%2 == 0 then
		IsEvenRender = true
	end
end)

--ripairs stuff from revel
function ripairs_it(t,i)
	i=i-1
	local v=t[i]
	if v==nil then return v end
	return i,v
end
function ripairs(t)
	return ripairs_it, t, #t+1
end

function mod:Contains(list, x, key)
	key = key or false
	for k, v in pairs(list) do
		local val = key and k or v
		if val == x then return true end
	end
	return false
end

--delayed functions
DelayedFunctions = {}

function mod:DelayFunction(func, delay, args, removeOnNewRoom, useRender)
	local delayFunctionData = {
		Function = func,
		Delay = delay,
		Args = args,
		RemoveOnNewRoom = removeOnNewRoom,
		OnRender = useRender
	}
	table.insert(DelayedFunctions, delayFunctionData)
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	for i, delayFunctionData in ripairs(DelayedFunctions) do
		if delayFunctionData.RemoveOnNewRoom then
			table.remove(DelayedFunctions, i)
		end
	end
end)

local function delayFunctionHandling(onRender)
	if #DelayedFunctions ~= 0 then
		for i, delayFunctionData in ripairs(DelayedFunctions) do
			if (delayFunctionData.OnRender and onRender) or (not delayFunctionData.OnRender and not onRender) then
				if delayFunctionData.Delay <= 0 then
					if delayFunctionData.Function then
						if delayFunctionData.Args then
							delayFunctionData.Function(table.unpack(delayFunctionData.Args))
						else
							delayFunctionData.Function()
						end
					end
					table.remove(DelayedFunctions, i)
				else
					delayFunctionData.Delay = delayFunctionData.Delay - 1
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	delayFunctionHandling(false)
end)

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	delayFunctionHandling(true)
end)

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	DelayedFunctions = {}
end)


-- Big Book Stuff (Thanks kittenchilly!)

--bigbook pausing
local hideBerkano = false
function mod:DoBigbookPause()
	local player = Isaac.GetPlayer(0)
	
	local sfx = SFXManager()
	
	hideBerkano = true
	player:UseCard(Card.RUNE_BERKANO, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER) --we undo berkano's effects later, this is done purely for the bigbook which our housing mod should have made blank if we got here
	
	--remove the blue flies and spiders that just spawned
	for _, bluefly in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, -1, false, false)) do
		if bluefly:Exists() and bluefly.FrameCount <= 0 then
			bluefly:Remove()
		end
	end
	for _, bluespider in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, -1, false, false)) do
		if bluespider:Exists() and bluespider.FrameCount <= 0 then
			bluespider:Remove()
		end
	end
end

local isPausingGame = false
local isPausingGameTimer = 0
function mod:KeepPaused()
	isPausingGame = true
	isPausingGameTimer = 0
end

function mod:StopPausing()
	isPausingGame = false
	isPausingGameTimer = 0
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if isPausingGame then
		isPausingGameTimer = isPausingGameTimer - 1
		if isPausingGameTimer <= 0 then
			isPausingGameTimer = 30
			mod:DoBigbookPause()
		end
	end
end)

mod:AddCallback(ModCallbacks.MC_USE_CARD, function()
	if not hideBerkano then
		mod:DelayFunction(function()
			local stuffWasSpawned = false
			
			for _, bluefly in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, -1, false, false)) do
				if bluefly:Exists() and bluefly.FrameCount <= 1 then
					stuffWasSpawned = true
					break
				end
			end
			
			for _, bluespider in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, -1, false, false)) do
				if bluespider:Exists() and bluespider.FrameCount <= 1 then
					stuffWasSpawned = true
					break
				end
			end
			
			if stuffWasSpawned then
				mod:DoBigbook("gfx/ui/giantbook/rune_07_berkano.png", nil, nil, nil, false)
			end
		end, 1, nil, false, true)
	end
	hideBerkano = false
end, Card.RUNE_BERKANO)

--giantbook overlays
local shouldRenderGiantbook = false
local giantbookUI = Sprite()
giantbookUI:Load("gfx/ui/giantbook/giantbook.anm2", true)
local giantbookAnimation = "Appear"
function mod:DoBigbook(spritesheet, sound, animationToPlay, animationFile, doPause)

	if doPause == nil then
		doPause = true
	end
	if doPause then
		mod:DoBigbookPause()
	end
	
	if not animationToPlay then
		animationToPlay = "Appear"
	end
	
	if not animationFile then
		animationFile = "gfx/ui/giantbook/giantbook.anm2"
		if animationToPlay == "Appear" or animationToPlay == "Shake" then
			animationFile = "gfx/ui/giantbook/giantbook.anm2"
		elseif animationToPlay == "Static" then
			animationToPlay = "Effect"
			animationFile = "gfx/ui/giantbook/giantbook_clicker.anm2"
		elseif animationToPlay == "Flash" then
			animationToPlay = "Idle"
			animationFile = "gfx/ui/giantbook/giantbook_mama_mega.anm2"
		elseif animationToPlay == "Sleep" then
			animationToPlay = "Idle"
			animationFile = "gfx/ui/giantbook/giantbook_sleep.anm2"
		elseif animationToPlay == "AppearBig" or animationToPlay == "ShakeBig" then
			if animationToPlay == "AppearBig" then
				animationToPlay = "Appear"
			elseif animationToPlay == "ShakeBig" then
				animationToPlay = "Shake"
			end
			animationFile = "gfx/ui/giantbook/giantbookbig.anm2"
		end
	end
	
	giantbookAnimation = animationToPlay
	giantbookUI:Load(animationFile, true)
	if spritesheet then
		giantbookUI:ReplaceSpritesheet(0, spritesheet)
		giantbookUI:LoadGraphics()
	end
	giantbookUI:Play(animationToPlay, true)
	shouldRenderGiantbook = true
	
	if sound then
		local sfx = SFXManager()
		sfx:Play(sound, 1, 0, false, 1)
	end
	
end
mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	if mod:ShouldRender() then
		local centerPos = mod:GetScreenCenterPosition()
		
		if IsEvenRender then
			giantbookUI:Update()
			if giantbookUI:IsFinished(giantbookAnimation) then
				shouldRenderGiantbook = false
			end
		end
		
		if shouldRenderGiantbook then
			giantbookUI:Render(centerPos, Vector.Zero, Vector.Zero)
		end
	end
end)
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	shouldRenderGiantbook = false
end)

function mod:ShouldRender()	
	local game = Game()
	local seeds = game:GetSeeds()
	local hud = game:GetHUD()

	if hud:IsVisible() == true and (not seeds:HasSeedEffect(SeedEffect.SEED_NO_HUD)) then
		return true
	end
	
	return false
end

function mod:GetScreenCenterPosition()

	local game = Game()
	local room = game:GetRoom()

	local shape = room:GetRoomShape()
	local centerOffset = (room:GetCenterPos()) - room:GetTopLeftPos()
	local pos = room:GetCenterPos()
	
	if centerOffset.X > 260 then
		pos.X = pos.X - 260
	end
	if shape == RoomShape.ROOMSHAPE_LBL or shape == RoomShape.ROOMSHAPE_LTL then
		pos.X = pos.X - 260
	end
	if centerOffset.Y > 140 then
		pos.Y = pos.Y - 140
	end
	if shape == RoomShape.ROOMSHAPE_LTR or shape == RoomShape.ROOMSHAPE_LTL then
		pos.Y = pos.Y - 140
	end
	
	return Isaac.WorldToRenderPosition(pos, false)
	
end

function mod:GetScreenSize()
    local pos = room:WorldToScreenPosition(Vector(0,0)) - room:GetRenderScrollOffset() - game.ScreenShakeOffset
    local rx = pos.X + 60 * 26 / 40
	local ry = pos.Y + 140 * (26 / 40)

    return Vector(rx*2 + 13*26, ry*2 + 7*26)
end

function mod:GetScreenCenter()

	return mod:GetScreenSize() / 2
	
end

function mod:GetScreenBottomRight(offset)

	offset = offset or 0
	
	local pos = mod:GetScreenSize()
	local hudOffset = Vector(-offset * 2.2, -offset * 1.6)
	pos = pos + hudOffset

	return pos
	
end

function mod:GetScreenBottomLeft(offset)

	offset = offset or 0
	
	local pos = Vector(0, mod:GetScreenBottomRight(0).Y)
	local hudOffset = Vector(offset * 2.2, -offset * 1.6)
	pos = pos + hudOffset
	
	return pos
	
end

function mod:GetScreenTopRight(offset)

	offset = offset or 0
	
	local pos = Vector(mod:GetScreenBottomRight(0).X, 0)
	local hudOffset = Vector(-offset * 2.2, offset * 1.2)
	pos = pos + hudOffset

	return pos
	
end

function mod:GetScreenTopLeft(offset)

	offset = offset or 0
	
	local pos = Vector.Zero
	local hudOffset = Vector(offset * 2, offset * 1.2)
	pos = pos + hudOffset
	
	return pos
	
end