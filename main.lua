Furtherance = RegisterMod("Furtherance", 1)
local mod = Furtherance
local json = require("json")
local loading = {}
local loadTimer
local game = Game()
local rng = RNG()

HeartSubType.HEART_MOON = 225
mod.DataTable = {}

local laugh = Isaac.GetSoundIdByName("Sitcom_Laugh_Track")
Furtherance.FailSound = SoundEffect.SOUND_EDEN_GLITCH
mod.isLoadingData = false
-- Isaac's Keyboard
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
CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM = Isaac.GetItemIdByName("Keys to the Kingdom")
CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION = Isaac.GetItemIdByName("Binds of Devotion")
TrinketType.TRINKET_ALABASTER_SCRAP = Isaac.GetTrinketIdByName("Alabaster Scrap")
TrinketType.TRINKET_LEAHS_LOCK = Isaac.GetTrinketIdByName("Leah's Lock")
CollectibleType.COLLECTIBLE_MUDDLED_CROSS = Isaac.GetItemIdByName("Muddled Cross")
CollectibleType.COLLECTIBLE_PARASITIC_POOFER = Isaac.GetItemIdByName("Parasitic Poofer")
CollectibleType.COLLECTIBLE_HEART_EMBEDDED_COIN = Isaac.GetItemIdByName("Heart Embedded Coin")
CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND = Isaac.GetItemIdByName("Spiritual Wound")
CollectibleType.COLLECTIBLE_CADUCEUS_STAFF = Isaac.GetItemIdByName("Caduceus Staff")
CollectibleType.COLLECTIBLE_POLYDIPSIA = Isaac.GetItemIdByName("Polydipsia")
CollectibleType.COLLECTIBLE_KARETH = Isaac.GetItemIdByName("Kareth")
CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE = Isaac.GetItemIdByName("Pillar of Fire")
CollectibleType.COLLECTIBLE_PILLAR_OF_CLOUDS = Isaac.GetItemIdByName("Pillar of Clouds")
CollectibleType.COLLECTIBLE_FIRSTBORN_SON = Isaac.GetItemIdByName("Firstborn Son")
CollectibleType.COLLECTIBLE_MIRIAMS_WELL = Isaac.GetItemIdByName("Miriam's Well")
CollectibleType.COLLECTIBLE_QUARANTINE = Isaac.GetItemIdByName("Quarantine")
CollectibleType.COLLECTIBLE_BOOK_OF_GUIDANCE = Isaac.GetItemIdByName("Book of Guidance")
CollectibleType.COLLECTIBLE_JAR_OF_MANNA = Isaac.GetItemIdByName("Jar of Manna")
CollectibleType.COLLECTIBLE_TAMBOURINE = Isaac.GetItemIdByName("Tambourine")
CollectibleType.COLLECTIBLE_THE_DREIDEL = Isaac.GetItemIdByName("The Dreidel")
CollectibleType.COLLECTIBLE_APOCALYPSE = Isaac.GetItemIdByName("Apocalypse")
TrinketType.TRINKET_INFESTED_PENNY = Isaac.GetTrinketIdByName("Infested Penny")
TrinketType.TRINKET_SALINE_SPRAY = Isaac.GetTrinketIdByName("Saline Spray")
TrinketType.TRINKET_ALMAGEST_SCRAP = Isaac.GetTrinketIdByName("Almagest Scrap")
TrinketType.TRINKET_WORMWOOD_LEAF = Isaac.GetTrinketIdByName("Wormwood Leaf")
CollectibleType.COLLECTIBLE_MANDRAKE = Isaac.GetItemIdByName("Mandrake")
CollectibleType.COLLECTIBLE_LITTLE_SISTER = Isaac.GetItemIdByName("Little Sister")
CollectibleType.COLLECTIBLE_OLD_CAMERA = Isaac.GetItemIdByName("Old Camera")
CollectibleType.COLLECTIBLE_BUTTERFLY = Isaac.GetItemIdByName("Butterfly")
CollectibleType.COLLECTIBLE_ALTERNATE_REALITY = Isaac.GetItemIdByName("Alternate Reality")
CollectibleType.COLLECTIBLE_CORK = Isaac.GetItemIdByName("Cork")
CollectibleType.COLLECTIBLE_FLUX = Isaac.GetItemIdByName("Flux")
CollectibleType.COLLECTIBLE_BRAINSTORM = Isaac.GetItemIdByName("Brainstorm")
CollectibleType.COLLECTIBLE_COSMIC_OMNIBUS = Isaac.GetItemIdByName("Cosmic Omnibus")
CollectibleType.COLLECTIBLE_LITTLE_RAINCOAT = Isaac.GetItemIdByName("Little Raincoat")
CollectibleType.COLLECTIBLE_BLOOD_CYST = Isaac.GetItemIdByName("Blood Cyst")
CollectibleType.COLLECTIBLE_POLARIS = Isaac.GetItemIdByName("Polaris")
TrinketType.TRINKET_ESCAPE_PLAN = Isaac.GetTrinketIdByName("Escape Plan")

-- Cards/Runes/Pills/etc
RUNE_SOUL_OF_LEAH = Isaac.GetCardIdByName("Soul of Leah")
CARD_TWO_OF_SHIELDS = Isaac.GetCardIdByName("Two of Shields")
CARD_ACE_OF_SHIELDS = Isaac.GetCardIdByName("Ace of Shields")
CARD_TRAP = Isaac.GetCardIdByName("Trap Card")
CARD_KEY = Isaac.GetCardIdByName("Key Card")
RUNE_SOUL_OF_PETER = Isaac.GetCardIdByName("Soul of Peter")
RUNE_SOUL_OF_MIRIAM = Isaac.GetCardIdByName("Soul of Miriam")

function Furtherance:playFailSound()
	SFXManager():Play(Furtherance.FailSound)
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
include("lua/items/Technology-1.lua")
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
include("lua/items/KeysToTheKingdom.lua")
include("lua/items/BindsOfDevotion.lua")
include("lua/items/AlabasterScrap.lua")
include("lua/items/LeahsLock.lua")
include("lua/items/MuddledCross.lua")
include("lua/items/ParasiticPoofer.lua")
include("lua/items/HeartEmbeddedCoin.lua")
include("lua/items/SpiritualWound.lua")
include("lua/items/CaduceusStaff.lua")
include("lua/items/Polydipsia.lua")
include("lua/items/Kareth.lua")
include("lua/items/PillarOfFire.lua")
include("lua/items/PillarOfClouds.lua")
include("lua/items/FirstbornSon.lua")
include("lua/items/MiriamsWell.lua")
include("lua/items/Quarantine.lua")
include("lua/items/BookOfGuidance.lua")
include("lua/items/JarOfManna.lua")
include("lua/items/Tambourine.lua")
include("lua/items/TheDreidel.lua")
include("lua/items/Apocalypse.lua")
include("lua/items/InfestedPenny.lua")
include("lua/items/SalineSpray.lua")
include("lua/items/AlmagestScrap.lua")
include("lua/items/WormwoodLeaf.lua")
include("lua/items/Mandrake.lua")
include("lua/items/LittleSister.lua")
include("lua/items/OldCamera.lua")
include("lua/items/Butterfly.lua")
include("lua/items/AlternateReality.lua")
include("lua/items/Cork.lua")
include("lua/items/Flux.lua")
include("lua/items/Brainstorm.lua")
include("lua/items/CosmicOmnibus.lua")
include("lua/items/LittleRaincoat.lua")
include("lua/items/BloodCyst.lua")
include("lua/items/Polaris.lua")
include("lua/items/EscapePlan.lua")

-- Enemy luas
include("lua/enemies/Hostikai.lua")
include("lua/enemies/Illusioner.lua")

-- Card Luas
include("lua/cards/SoulOfLeah.lua")
include("lua/cards/TwoOfShields.lua")
include("lua/cards/AceOfShields.lua")
include("lua/cards/TrapCard.lua")
include("lua/cards/KeyCard.lua")
include("lua/cards/SoulOfPeter.lua")
include("lua/cards/SoulOfMiriam.lua")

-- Pickup Luas
include("lua/pickups/MoonHeart.lua")

-- Floor Generation Luas
--include("lua/rooms/NoahsArk.lua")
--include("lua/rooms/HomeExit.lua")

-- Custom Challenge Luas
include("lua/challenges/WhereAmI.lua")

-- Save Data/Unlocks
--include("lua/achievements.lua")

function Furtherance:GetEntityIndex(entity)
	if entity then
		if entity.Type == EntityType.ENTITY_PLAYER then
			local player = entity:ToPlayer()
			if player:GetPlayerType() == PlayerType.PLAYER_THESOUL_B then
				player = player:GetOtherTwin()
			end
			local id = 1
			if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B then
				id = 2
			end
			local index = player:GetCollectibleRNG(id):GetSeed()
			if not mod.DataTable[index] then
				mod.DataTable[index] = {}
			end
			if not mod.DataTable[index].FurtheranceMoonHeart then
				mod.DataTable[index].FurtheranceMoonHeart = 0
			end
			if not mod.DataTable[index].lastEternalHearts or not mod.DataTable[index].lastMaxHearts then
				mod.DataTable[index].lastEternalHearts = 0
				mod.DataTable[index].lastMaxHearts = 0
			end
			if player:GetPlayerType() == PlayerType.PLAYER_BETHANY and not mod.DataTable[index].ImmortalCharge then
				mod.DataTable[index].ImmortalCharge = 0
			end
			return index
		elseif entity.Type == EntityType.ENTITY_FAMILIAR then
			local index = entity:ToFamiliar().InitSeed
			if not mod.DataTable[index] then
				mod.DataTable[index] = {}
			end
			return index
		end
	end
	return nil
end

function mod:OnSave(isSaving)
	local save = {}
	if isSaving then
		local saveData = {}
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			saveData["player_" .. tostring(i + 1)] = {}
			saveData["player_" .. tostring(i + 1)].numAngelItems = data.numAngelItems
			saveData["player_" .. tostring(i + 1)].solTR = data.solTR
			saveData["player_" .. tostring(i + 1)].solDMG = data.solDMG
			saveData["player_" .. tostring(i + 1)].llTR = data.llTR
			saveData["player_" .. tostring(i + 1)].MoonHeart = data.MoonHeart
			saveData["player_" .. tostring(i + 1)].RenovatorDamage = data.RenovatorDamage
			saveData["player_" .. tostring(i + 1)].HeartCount = data.HeartCount
			saveData["player_" .. tostring(i + 1)].CameraSaved = data.CameraSaved
			saveData["player_" .. tostring(i + 1)].CurRoomID = data.CurRoomID
			saveData["player_" .. tostring(i + 1)].ShiftKeyPressed = data.ShiftKeyPressed
			saveData["player_" .. tostring(i + 1)].ShiftMultiplier = data.ShiftMultiplier
			saveData["player_" .. tostring(i + 1)].SleptInMomsBed = data.SleptInMomsBed
			saveData["player_" .. tostring(i + 1)].ApocalypseBuffs = data.ApocalypseBuffs
			saveData["player_" .. tostring(i + 1)].SpareCount = data.SpareCount
			saveData["player_" .. tostring(i + 1)].KTTKBuffs = data.KTTKBuffs
			saveData["player_" .. tostring(i + 1)].KTTKTempBuffs = data.KTTKTempBuffs
			if player:GetName() == "Leah" then
				saveData["player_" .. tostring(i + 1)].kills = data.leahkills
			end
			if player:GetName() == "Peter" then
				saveData["player_" .. tostring(i + 1)].DevilCount = data.DevilCount
				saveData["player_" .. tostring(i + 1)].AngelCount = data.AngelCount
			end
			if player:GetName() == "Miriam" then
				saveData["player_" .. tostring(i + 1)].MiriamTearCount = data.MiriamTearCount
				saveData["player_" .. tostring(i + 1)].MiriamRiftTimeout = data.MiriamRiftTimeout
			end
		end
		saveData.Flipped = mod.Flipped
		save.PlayerData = saveData
	end
	save.Unlocks = mod.Unlocks
	mod:SaveData(json.encode(save))
end

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.OnSave)

function mod:OnLoad(isLoading)
	mod.isLoadingData = isLoading
	if isLoading and mod:HasData() then
		local load = json.decode(mod:LoadData())
		local loadData = load.PlayerData
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			local index = mod:GetEntityIndex(player)
			if isLoading == false or mod.DataTable[index].FurtheranceMoonHeart == nil then
				mod.DataTable[index].FurtheranceMoonHeart = 0
			end
			if player:GetName() == "Leah" then -- leah's Data
				if loadData["player_" .. tostring(i + 1)].kills then
					data.leahkills = loadData["player_" .. tostring(i + 1)].kills
				end
			end
			if player:GetName() == "Peter" then -- Peter's Data
				if loadData["player_" .. tostring(i + 1)].DevilCount then
					data.DevilCount = loadData["player_" .. tostring(i + 1)].DevilCount
				end
				if loadData["player_" .. tostring(i + 1)].AngelCount then
					data.AngelCount = loadData["player_" .. tostring(i + 1)].AngelCount
				end
			end
			if player:GetName() == "Miriam" then -- Miriam's Data
				if loadData["player_" .. tostring(i + 1)].MiriamTearCount then
					data.MiriamTearCount = loadData["player_" .. tostring(i + 1)].MiriamTearCount
				end
				if loadData["player_" .. tostring(i + 1)].MiriamRiftTimeout then
					data.MiriamRiftTimeout = loadData["player_" .. tostring(i + 1)].MiriamRiftTimeout
				end
			end
			-- Other General Data
			if loadData["player_" .. tostring(i + 1)].numAngelItems then
				data.numAngelItems = loadData["player_" .. tostring(i + 1)].numAngelItems
			end
			if loadData["player_" .. tostring(i + 1)].solTR then
				data.solTR = loadData["player_" .. tostring(i + 1)].solTR
			end
			if loadData["player_" .. tostring(i + 1)].solDMG then
				data.solDMG = loadData["player_" .. tostring(i + 1)].solDMG
			end
			if loadData["player_" .. tostring(i + 1)].llTR then
				data.llTR = loadData["player_" .. tostring(i + 1)].llTR
			end
			if loadData["player_" .. tostring(i + 1)].MoonHeart then
				data.MoonHeart = loadData["player_" .. tostring(i + 1)].MoonHeart
			end
			if loadData["player_" .. tostring(i + 1)].RenovatorDamage then
				data.RenovatorDamage = loadData["player_" .. tostring(i + 1)].RenovatorDamage
			end
			if loadData["player_" .. tostring(i + 1)].HeartCount then
				data.HeartCount = loadData["player_" .. tostring(i + 1)].HeartCount
			end
			if loadData["player_" .. tostring(i + 1)].CameraSaved then
				data.CameraSaved = loadData["player_" .. tostring(i + 1)].CameraSaved
			end
			if loadData["player_" .. tostring(i + 1)].CurRoomID then
				data.CurRoomID = loadData["player_" .. tostring(i + 1)].CurRoomID
			end
			if loadData["player_" .. tostring(i + 1)].ShiftKeyPressed then
				data.ShiftKeyPressed = loadData["player_" .. tostring(i + 1)].ShiftKeyPressed
			end
			if loadData["player_" .. tostring(i + 1)].ShiftMultiplier then
				data.ShiftMultiplier = loadData["player_" .. tostring(i + 1)].ShiftMultiplier
			end
			if loadData["player_" .. tostring(i + 1)].SleptInMomsBed then
				data.SleptInMomsBed = loadData["player_" .. tostring(i + 1)].SleptInMomsBed
			end
			if loadData["player_" .. tostring(i + 1)].ApocalypseBuffs then
				data.ApocalypseBuffs = loadData["player_" .. tostring(i + 1)].ApocalypseBuffs
			end
			if loadData["player_" .. tostring(i + 1)].SpareCount then
				data.SpareCount = loadData["player_" .. tostring(i + 1)].SpareCount
			end
			if loadData["player_" .. tostring(i + 1)].KTTKBuffs then
				data.KTTKBuffs = loadData["player_" .. tostring(i + 1)].KTTKBuffs
			end
			if loadData["player_" .. tostring(i + 1)].KTTKTempBuffs then
				data.KTTKTempBuffs = loadData["player_" .. tostring(i + 1)].KTTKTempBuffs
			end
		end
		if loadData.Flipped then
			mod.Flipped = loadData.Flipped
		end
		if loadData.Unlocks then
			for key, value in ipairs(mod.Unlocks) do
				if loadData.Unlocks[key] then
					mod.Unlocks[key] = loadData.Unlocks[key]
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.OnLoad)

function mod:LoadDataCacheEval(player)
	if player.FrameCount == 1 then
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.LoadDataCacheEval)

-- Players
include("lua/players/Leah.lua")
include("lua/players/Peter.lua")
include("lua/players/Miriam.lua")

-- prevent shaders crash
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, function()
	if #Isaac.FindByType(EntityType.ENTITY_PLAYER) == 0 then
		Isaac.ExecuteCommand("reloadshaders")
	end
end)

-- helper callback for applying custom tear effects
-- used by Flux and Pharaoh Cat
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(self, tear)
	local data = mod:GetData(tear)
	if data.AppliedTearFlags == nil then
		data.AppliedTearFlags = {}
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
	-- Leah
	local LeahCostumeA = Isaac.GetCostumeIdByPath("gfx/characters/Character_001_Leah_Pog.anm2")
	Poglite:AddPogCostume("LeahPog", normalLeah, LeahCostumeA)
	-- Tainted Leah
	local LeahCostumeB = Isaac.GetCostumeIdByPath("gfx/characters/Character_001b_Leah_Pog.anm2")
	Poglite:AddPogCostume("LeahBPog", taintedLeah, LeahCostumeB)
	-- Miriam
	local MiriamCostumeA = Isaac.GetCostumeIdByPath("gfx/characters/Character_003_Miriam_Pog.anm2")
	Poglite:AddPogCostume("MiriamPog", normalMiriam, MiriamCostumeA)
end

if MiniMapiItemsAPI then
	local MoonHeartSprite = Sprite()
	MoonHeartSprite:Load("gfx/ui/moonheart_icon.anm2", true)
	MinimapAPI:AddIcon("MoonHeartIcon", MoonHeartSprite, "MoonHeart", 0)
	MinimapAPI:AddPickup(225, "MoonHeartIcon", 5, 10, 225, MinimapAPI.PickupNotCollected, "hearts", 13000)
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
			return Furtherance.FailSound ~= laugh
		end,
		Display = function()
			local sstr = "???"
			if Furtherance.FailSound == laugh then sstr = "Laugh Track"
			elseif Furtherance.FailSound == SoundEffect.SOUND_EDEN_GLITCH then sstr = "Default" end
			return "Item Fails Sound Effect: " .. sstr
		end,
		OnChange = function(current_bool)
			if current_bool then
				Furtherance.FailSound = SoundEffect.SOUND_EDEN_GLITCH
			else
				Furtherance.FailSound = laugh
			end
		end
	}
	)
end

----- Mod Support End -----

include("lua/piber.lua")

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
	local seeds = game:GetSeeds()
	local hud = game:GetHUD()
	if hud:IsVisible() == true and (not seeds:HasSeedEffect(SeedEffect.SEED_NO_HUD)) then
		return true
	end
	return false
end

function mod:GetScreenCenterPosition()
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
	local pos = room:WorldToScreenPosition(Vector(0, 0)) - room:GetRenderScrollOffset() - game.ScreenShakeOffset
	local rx = pos.X + 60 * 26 / 40
	local ry = pos.Y + 140 * (26 / 40)

	return Vector(rx * 2 + 13 * 26, ry * 2 + 7 * 26)
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
