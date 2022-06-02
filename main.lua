Furtherance = RegisterMod("Furtherance", 1)
local mod = Furtherance
local game = Game()
local json = require("json")
local loading = {}
local loadTimer

mod.DataTable = {}

Furtherance.FailSound = SoundEffect.SOUND_EDEN_GLITCH
Furtherance.FlipSpeed = 1

mod.isLoadingData = false

-- Characters
LeahA = Isaac.GetPlayerTypeByName("Leah", false)
LeahB = Isaac.GetPlayerTypeByName("Leah", true)
PeterA = Isaac.GetPlayerTypeByName("Peter", false)
PeterB = Isaac.GetPlayerTypeByName("Peter", true)
MiriamA = Isaac.GetPlayerTypeByName("Miriam", false)
MiriamB = Isaac.GetPlayerTypeByName("Miriam", true)

-- Collectibles
CollectibleType.COLLECTIBLE_TECH_IX = Isaac.GetItemIdByName("Tech IX")
CollectibleType.COLLECTIBLE_LEAKING_TANK = Isaac.GetItemIdByName("Leaking Tank")
CollectibleType.COLLECTIBLE_UNSTABLE_CORE = Isaac.GetItemIdByName("Unstable Core")
CollectibleType.COLLECTIBLE_TECHNOLOGY_MINUS_1 = Isaac.GetItemIdByName("Technology -1")
CollectibleType.COLLECTIBLE_BOOK_OF_SWIFTNESS = Isaac.GetItemIdByName("Book of Swiftness")
CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT = Isaac.GetItemIdByName("Book of Ambit")
CollectibleType.COLLECTIBLE_NEASS = Isaac.GetItemIdByName("Plug N' Play")
CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ = Isaac.GetItemIdByName("ZZZZoptionsZZZZ")
CollectibleType.COLLECTIBLE_BRUNCH = Isaac.GetItemIdByName("Brunch")
CollectibleType.COLLECTIBLE_CRAB_LEGS = Isaac.GetItemIdByName("Crab Legs")
CollectibleType.COLLECTIBLE_OWLS_EYE = Isaac.GetItemIdByName("Owl's Eye")
CollectibleType.COLLECTIBLE_HEART_RENOVATOR = Isaac.GetItemIdByName("Heart Renovator")
CollectibleType.COLLECTIBLE_PHARAOH_CAT = Isaac.GetItemIdByName("Pharaoh Cat")
CollectibleType.COLLECTIBLE_F4_KEY = Isaac.GetItemIdByName("F4 Key")
CollectibleType.COLLECTIBLE_TAB_KEY = Isaac.GetItemIdByName("Tab Key")
CollectibleType.COLLECTIBLE_SHATTERED_HEART = Isaac.GetItemIdByName("Shattered Heart")
CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM = Isaac.GetItemIdByName("Keys to the Kingdom")
CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION = Isaac.GetItemIdByName("Binds of Devotion")
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
CollectibleType.COLLECTIBLE_MANDRAKE = Isaac.GetItemIdByName("Mandrake")
CollectibleType.COLLECTIBLE_LITTLE_SISTER = Isaac.GetItemIdByName("Little Sister")
CollectibleType.COLLECTIBLE_OLD_CAMERA = Isaac.GetItemIdByName("Old Camera")
CollectibleType.COLLECTIBLE_BUTTERFLY = Isaac.GetItemIdByName("Butterfly")
CollectibleType.COLLECTIBLE_ALTERNATE_REALITY = Isaac.GetItemIdByName("Alternate Reality")
CollectibleType.COLLECTIBLE_WINE_BOTTLE = Isaac.GetItemIdByName("Wine Bottle")
CollectibleType.COLLECTIBLE_FLUX = Isaac.GetItemIdByName("Flux")
CollectibleType.COLLECTIBLE_BRAINSTORM = Isaac.GetItemIdByName("Brainstorm")
CollectibleType.COLLECTIBLE_COSMIC_OMNIBUS = Isaac.GetItemIdByName("Cosmic Omnibus")
CollectibleType.COLLECTIBLE_LITTLE_RAINCOAT = Isaac.GetItemIdByName("Little Raincoat")
CollectibleType.COLLECTIBLE_BLOOD_CYST = Isaac.GetItemIdByName("Blood Cyst")
CollectibleType.COLLECTIBLE_POLARIS = Isaac.GetItemIdByName("Polaris")
CollectibleType.COLLECTIBLE_D9 = Isaac.GetItemIdByName("D9")
CollectibleType.COLLECTIBLE_LEAHS_HAIR_TIE = Isaac.GetItemIdByName("Leah's Hair Tie")
CollectibleType.COLLECTIBLE_LEAHS_TORN_HEART = Isaac.GetItemIdByName("Leah's Torn Heart")
CollectibleType.COLLECTIBLE_PETERS_HEADBAND = Isaac.GetItemIdByName("Peter's Headband")
CollectibleType.COLLECTIBLE_PETERS_BLOODY_FRACTURE = Isaac.GetItemIdByName("Peter's Bloody Fracture")
CollectibleType.COLLECTIBLE_MIRIAMS_HEADBAND = Isaac.GetItemIdByName("Miriam's Headband")
CollectibleType.COLLECTIBLE_MIRIAMS_PUTRID_VEIL = Isaac.GetItemIdByName("Miriam's Putrid Veil")
CollectibleType.COLLECTIBLE_POLARITY_SHIFT = Isaac.GetItemIdByName("Polarity Shift")
CollectibleType.COLLECTIBLE_BOOK_OF_BOOKS = Isaac.GetItemIdByName("Book of Books")
CollectibleType.COLLECTIBLE_KERATOCONUS = Isaac.GetItemIdByName("Keratoconus")
CollectibleType.COLLECTIBLE_SERVITUDE = Isaac.GetItemIdByName("Servitude")
CollectibleType.COLLECTIBLE_CARDIOMYOPATHY = Isaac.GetItemIdByName("Cardiomyopathy")
CollectibleType.COLLECTIBLE_SUNSCREEN = Isaac.GetItemIdByName("Sunscreen")
CollectibleType.COLLECTIBLE_SECRET_DIARY = Isaac.GetItemIdByName("Secret Diary")
CollectibleType.COLLECTIBLE_D16 = Isaac.GetItemIdByName("D16")

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

-- Trinkets
TrinketType.TRINKET_HOLY_HEART = Isaac.GetTrinketIdByName("Holy Heart")
TrinketType.TRINKET_CRINGE = Isaac.GetTrinketIdByName("Cringe")
TrinketType.TRINKET_SLICK_WORM = Isaac.GetTrinketIdByName("Slick Worm")
TrinketType.TRINKET_GRASS = Isaac.GetTrinketIdByName("Grass")
TrinketType.TRINKET_ALABASTER_SCRAP = Isaac.GetTrinketIdByName("Alabaster Scrap")
TrinketType.TRINKET_LEAHS_LOCK = Isaac.GetTrinketIdByName("Leah's Lock")
TrinketType.TRINKET_ABYSSAL_PENNY = Isaac.GetTrinketIdByName("Abyssal Penny")
TrinketType.TRINKET_SALINE_SPRAY = Isaac.GetTrinketIdByName("Saline Spray")
TrinketType.TRINKET_ALMAGEST_SCRAP = Isaac.GetTrinketIdByName("Almagest Scrap")
TrinketType.TRINKET_WORMWOOD_LEAF = Isaac.GetTrinketIdByName("Wormwood Leaf")
TrinketType.TRINKET_ESCAPE_PLAN = Isaac.GetTrinketIdByName("Escape Plan")
TrinketType.TRINKET_EPITAPH = Isaac.GetTrinketIdByName("Epitaph")
TrinketType.TRINKET_LEVIATHANS_TENDRIL = Isaac.GetTrinketIdByName("Leviathan's Tendril")
TrinketType.TRINKET_ALTRUISM = Isaac.GetTrinketIdByName("Altruism")
TrinketType.TRINKET_NIL_NUM = Isaac.GetTrinketIdByName("Nil Num")

-- Cards/Runes/Pills/etc
RUNE_SOUL_OF_LEAH = Isaac.GetCardIdByName("Soul of Leah")
CARD_TWO_OF_SHIELDS = Isaac.GetCardIdByName("Two of Shields")
CARD_ACE_OF_SHIELDS = Isaac.GetCardIdByName("Ace of Shields")
CARD_TRAP = Isaac.GetCardIdByName("Trap Card")
CARD_KEY = Isaac.GetCardIdByName("Key Card")
RUNE_SOUL_OF_PETER = Isaac.GetCardIdByName("Soul of Peter")
RUNE_SOUL_OF_MIRIAM = Isaac.GetCardIdByName("Soul of Miriam")
OBJ_ESSENCE_OF_LOVE = Isaac.GetCardIdByName("Essence of Love")
OBJ_ESSENCE_OF_HATE = Isaac.GetCardIdByName("Essence of Hate")
OBJ_ESSENCE_OF_LIFE = Isaac.GetCardIdByName("Essence of Life")
OBJ_ESSENCE_OF_DEATH = Isaac.GetCardIdByName("Essence of Death")
OBJ_ESSENCE_OF_PROSPERITY = Isaac.GetCardIdByName("Essence of Prosperity")
OBJ_ESSENCE_OF_DROUGHT = Isaac.GetCardIdByName("Essence of Drought")
PILLEFFECT_HEARTACHE_UP = Isaac.GetPillEffectByName("Heartache Up")
PILLEFFECT_HEARTACHE_DOWN = Isaac.GetPillEffectByName("Heartache Down")
CARD_GOLDEN = Isaac.GetCardIdByName("Golden Card")

-- Pickups
HeartSubType.HEART_MOON = 225
HeartSubType.HEART_ROCK = 226
SackSubType.SACK_GOLDEN = 3
CoinSubType.COIN_UNLUCKYPENNY = 117

include("lua/customcallbacks.lua")

-------- Game Saving Callbacks --------
local function serialToVector(serial)
	return serial and Vector(serial.X, serial.Y)
end

local function vectorToSerial(vector)
	return vector and { X = vector.X, Y = vector.Y }
end

function mod:OnSave(isSaving)
	local save = {}
	if isSaving then
		local saveData = {}
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			local playerData = {
				numAngelItems = data.numAngelItems,
				LeahsLockTears = data.LeahsLockTears,
				MoonHeart = data.MoonHeart,
				RenovatorDamage = data.RenovatorDamage,
				HeartCount = data.HeartCount,
				CameraSaved = data.CameraSaved,
				CurRoomID = data.CurRoomID,
				ShiftKeyPressed = data.ShiftKeyPressed,
				ShiftMultiplier = data.ShiftMultiplier,
				SleptInMomsBed = data.SleptInMomsBed,
				ApocalypseBuffs = data.ApocalypseBuffs,
				SpareCount = data.SpareCount,
				KTTKBuffs = data.KTTKBuffs,
				KTTKTempBuffs = data.KTTKTempBuffs,
				MannaCount = data.MannaCount,
				MannaBuffs = data.MannaBuffs,
				EpitaphStage = data.EpitaphStage,
				EpitaphRoom = data.EpitaphRoom,
				EpitaphTombstonePosition = vectorToSerial(data.EpitaphTombstonePosition),
				EpitaphTombstoneDestroyed = data.EpitaphTombstoneDestroyed,
				NewEpitaphFirstPassiveItem = data.NewEpitaphFirstPassiveItem,
				NewEpitaphLastPassiveItem = data.NewEpitaphLastPassiveItem,
				UnluckyPennyStat = data.UnluckyPennyStat,
				CurrentServitudeItem = data.CurrentServitudeItem,
				ServitudeCounter = data.ServitudeCounter
			}
			if player:GetPlayerType() == LeahA then
				playerData.LeahKills = data.LeahKills
			end
			if player:GetPlayerType() == PeterA then
				playerData.DevilCount = data.DevilCount
				playerData.AngelCount = data.AngelCount
			end
			if player:GetPlayerType() == MiriamA then
				playerData.MiriamTearCount = data.MiriamTearCount
				playerData.MiriamRiftTimeout = data.MiriamRiftTimeout
			end

			saveData["player_" .. tostring(i + 1)] = playerData
		end
		saveData.Flipped = mod.Flipped
		save.PlayerData = saveData
	else
		local saveData = {}
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			local playerData = {
				EpitaphStage = data.EpitaphStage,
				EpitaphRoom = data.EpitaphRoom,
				EpitaphFirstPassiveItem = data.NewEpitaphFirstPassiveItem,
				EpitaphLastPassiveItem = data.NewEpitaphLastPassiveItem,
				EpitaphTombstonePosition = vectorToSerial(data.EpitaphTombstonePosition),
				EpitaphTombstoneDestroyed = data.EpitaphTombstoneDestroyed
			}

			saveData["player_" .. tostring(i + 1)] = playerData
		end
		save.PlayerData = saveData
	end
	save.Unlocks = mod.Unlocks
	mod:SaveData(json.encode(save))
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.OnSave)

Furtherance.isLoadingData = false
function mod:OnLoad(isLoading)
	if not mod:HasData() then return end
	if isLoading then
		mod.isLoadingData = true
		local load = json.decode(mod:LoadData())
		local loadData = load.PlayerData
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			local playerData = loadData[string.format("player_%d", i + 1)]

			-- local index = mod:GetEntityIndex(player)
			-- if isLoading == false or mod.DataTable[index].FurtheranceMoonHeart == nil then
			-- 	mod.DataTable[index].FurtheranceMoonHeart = 0
			-- end

			data.numAngelItems = playerData.numAngelItems
			data.LeahsLockTears = playerData.LeahsLockTears
			data.MoonHeart = playerData.MoonHeart
			data.RenovatorDamage = playerData.RenovatorDamage
			data.HeartCount = playerData.HeartCount
			data.CameraSaved = playerData.CameraSaved
			data.CurRoomID = playerData.CurRoomID
			data.ShiftKeyPressed = playerData.ShiftKeyPressed
			data.ShiftMultiplier = playerData.ShiftMultiplier
			data.SleptInMomsBed = playerData.SleptInMomsBed
			data.ApocalypseBuffs = playerData.ApocalypseBuffs
			data.SpareCount = playerData.SpareCount
			data.KTTKBuffs = playerData.KTTKBuffs
			data.KTTKTempBuffs = playerData.KTTKTempBuffs
			data.MannaCount = playerData.MannaCount
			data.MannaBuffs = playerData.MannaBuffs
			data.EpitaphStage = playerData.EpitaphStage
			data.EpitaphRoom = playerData.EpitaphRoom
			data.EpitaphTombstonePosition = serialToVector(playerData.EpitaphTombstonePosition)
			data.EpitaphTombstoneDestroyed = playerData.EpitaphTombstoneDestroyed
			data.EpitaphFirstPassiveItem = playerData.EpitaphFirstPassiveItem
			data.EpitaphLastPassiveItem = playerData.EpitaphLastPassiveItem
			data.UnluckyPennyStat = playerData.UnluckyPennyStat
			data.CurrentServitudeItem = playerData.CurrentServitudeItem
			data.ServitudeCounter = playerData.ServitudeCounter

			if player:GetPlayerType() == LeahA then -- Leah's Data
				data.LeahKills = playerData.LeahKills
			end
			if player:GetPlayerType() == PeterA then -- Peter's Data
				data.DevilCount = playerData.DevilCount
				data.AngelCount = playerData.AngelCount
			end
			if player:GetPlayerType() == MiriamA then -- Miriam's Data
				data.MiriamTearCount = playerData.MiriamTearCount
				data.MiriamRiftTimeout = playerData.MiriamRiftTimeout
			end
		end
		if loadData.Flipped then
			mod.Flipped = loadData.Flipped
		end
		if loadData.Unlocks then
			for key in ipairs(mod.Unlocks) do
				if loadData.Unlocks[key] then
					mod.Unlocks[key] = loadData.Unlocks[key]
				end
			end
		end
	else
		local load = json.decode(mod:LoadData())
		local loadData = load.PlayerData
		for i = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(i)
			local data = mod:GetData(player)
			local playerData = loadData[string.format("player_%d", i + 1)]

			data.EpitaphStage = playerData.EpitaphStage
			data.EpitaphRoom = playerData.EpitaphRoom
			data.EpitaphTombstonePosition = serialToVector(playerData.EpitaphTombstonePosition)
			data.EpitaphTombstoneDestroyed = playerData.EpitaphTombstoneDestroyed
			data.EpitaphFirstPassiveItem = playerData.EpitaphFirstPassiveItem
			data.EpitaphLastPassiveItem = playerData.EpitaphLastPassiveItem
		end
	end
end
mod:AddCustomCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.OnLoad)

---- Lua Files ----

-- Players
include("lua/players/Leah.lua")
include("lua/players/Peter.lua")
include("lua/players/Miriam.lua")

-- Collectibles
include("lua/items/collectibles/Esc.lua")
include("lua/items/collectibles/Tilde.lua")
include("lua/items/collectibles/Alt.lua")
include("lua/items/collectibles/Spacebar.lua")
include("lua/items/collectibles/Backspace.lua")
include("lua/items/collectibles/Q.lua")
include("lua/items/collectibles/E.lua")
include("lua/items/collectibles/C.lua")
include("lua/items/collectibles/Caps.lua")
include("lua/items/collectibles/Enter.lua")
include("lua/items/collectibles/Shift.lua")
include("lua/items/collectibles/Ophiuchus.lua")
include("lua/items/collectibles/Chiron.lua")
include("lua/items/collectibles/Ceres.lua")
include("lua/items/collectibles/Pallas.lua")
include("lua/items/collectibles/Juno.lua")
include("lua/items/collectibles/Vesta.lua")
include("lua/items/collectibles/TechIX.lua")
include("lua/items/collectibles/LeakingTank.lua")
include("lua/items/collectibles/UnstableCore.lua")
include("lua/items/collectibles/Technology-1.lua")
include("lua/items/collectibles/BookOfSwiftness.lua")
include("lua/items/collectibles/BookOfAmbit.lua")
include("lua/items/collectibles/NEASS.lua")
include("lua/items/collectibles/Cringe.lua")
include("lua/items/collectibles/ZZZZoptionsZZZZ.lua")
include("lua/items/collectibles/Brunch.lua")
include("lua/items/collectibles/CrabLegs.lua")
include("lua/items/collectibles/OwlsEye.lua")
include("lua/items/collectibles/HeartRenovator.lua")
include("lua/items/collectibles/PharaohCat.lua")
include("lua/items/collectibles/F4.lua")
include("lua/items/collectibles/Tab.lua")
include("lua/items/collectibles/ShatteredHeart.lua")
include("lua/items/collectibles/KeysToTheKingdom.lua")
include("lua/items/collectibles/BindsOfDevotion.lua")
include("lua/items/collectibles/MuddledCross.lua")
include("lua/items/collectibles/ParasiticPoofer.lua")
include("lua/items/collectibles/HeartEmbeddedCoin.lua")
include("lua/items/collectibles/SpiritualWound.lua")
include("lua/items/collectibles/CaduceusStaff.lua")
include("lua/items/collectibles/Polydipsia.lua")
include("lua/items/collectibles/Kareth.lua")
include("lua/items/collectibles/PillarOfFire.lua")
include("lua/items/collectibles/PillarOfClouds.lua")
include("lua/items/collectibles/FirstbornSon.lua")
include("lua/items/collectibles/MiriamsWell.lua")
include("lua/items/collectibles/Quarantine.lua")
include("lua/items/collectibles/BookOfGuidance.lua")
include("lua/items/collectibles/JarOfManna.lua")
include("lua/items/collectibles/Tambourine.lua")
include("lua/items/collectibles/TheDreidel.lua")
include("lua/items/collectibles/Apocalypse.lua")
include("lua/items/collectibles/Mandrake.lua")
include("lua/items/collectibles/LittleSister.lua")
include("lua/items/collectibles/OldCamera.lua")
include("lua/items/collectibles/Butterfly.lua")
include("lua/items/collectibles/AlternateReality.lua")
include("lua/items/collectibles/WineBottle.lua")
include("lua/items/collectibles/Flux.lua")
include("lua/items/collectibles/Brainstorm.lua")
include("lua/items/collectibles/CosmicOmnibus.lua")
include("lua/items/collectibles/LittleRaincoat.lua")
include("lua/items/collectibles/BloodCyst.lua")
include("lua/items/collectibles/Polaris.lua")
include("lua/items/collectibles/D9.lua")
include("lua/items/collectibles/LeahsHairTie.lua")
include("lua/items/collectibles/LeahsTornHeart.lua")
include("lua/items/collectibles/PetersHeadband.lua")
include("lua/items/collectibles/PetersBloodyFracture.lua")
include("lua/items/collectibles/MiriamsHeadband.lua")
include("lua/items/collectibles/MiriamsPutridVeil.lua")
include("lua/items/collectibles/PolarityShift.lua")
include("lua/items/collectibles/BookOfBooks.lua")
include("lua/items/collectibles/Keratoconus.lua")
include("lua/items/collectibles/Servitude.lua")
include("lua/items/collectibles/Cardiomyopathy.lua")
include("lua/items/collectibles/Sunscreen.lua")
include("lua/items/collectibles/SecretDiary.lua")
include("lua/items/collectibles/D16.lua")

-- Trinkets
include("lua/items/trinkets/HolyHeart.lua")
include("lua/items/trinkets/SlickWorm.lua")
include("lua/items/trinkets/Grass.lua")
include("lua/items/trinkets/AlabasterScrap.lua")
include("lua/items/trinkets/LeahsLock.lua")
include("lua/items/trinkets/AbyssalPenny.lua")
include("lua/items/trinkets/SalineSpray.lua")
include("lua/items/trinkets/AlmagestScrap.lua")
include("lua/items/trinkets/WormwoodLeaf.lua")
include("lua/items/trinkets/EscapePlan.lua")
include("lua/items/trinkets/Epitaph/Epitaph.lua")
include("lua/items/trinkets/LeviathansTendril.lua")
include("lua/items/trinkets/Altruism.lua")
include("lua/items/trinkets/NilNum.lua")
--include("lua/items/trinkets/EpicExperimentingForSky.lua")

-- Enemies
include("lua/enemies/Hostikai.lua")
include("lua/enemies/Illusioner.lua")

-- Pockets
include("lua/pocket/SoulOfLeah.lua")
include("lua/pocket/TwoOfShields.lua")
include("lua/pocket/AceOfShields.lua")
include("lua/pocket/TrapCard.lua")
include("lua/pocket/KeyCard.lua")
include("lua/pocket/SoulOfPeter.lua")
include("lua/pocket/SoulOfMiriam.lua")
include("lua/pocket/EssenceOfLove.lua")
include("lua/pocket/EssenceOfHate.lua")
include("lua/pocket/EssenceOfLife.lua")
include("lua/pocket/EssenceOfDeath.lua")
include("lua/pocket/EssenceOfProsperity.lua")
include("lua/pocket/EssenceOfDrought.lua")
include("lua/pocket/Heartache.lua")
include("lua/pocket/GoldenCard.lua")

-- Pickups
include("lua/pickups/MoonHeart.lua")
include("lua/pickups/RockHeart.lua")
include("lua/pickups/GoldenSack.lua")
include("lua/pickups/UnluckyPenny.lua")

-- Floor Generation
--include("lua/rooms/NoahsArk.lua")
include("lua/rooms/HomeExit.lua")

-- Custom Challenges
include("lua/challenges/WhereAmI.lua")

-- Achievements
include("lua/achievements.lua")

-- Mod Support
if EID then
	include("lua/eid.lua")
end

if Encyclopedia then
	include("lua/encyclopedia.lua")
end

if Poglite then
	-- Leah
	local LeahCostumeA = Isaac.GetCostumeIdByPath("gfx/characters/Character_001_Leah_Pog.anm2")
	Poglite:AddPogCostume("LeahPog", LeahA, LeahCostumeA)
	-- Tainted Leah
	local LeahCostumeB = Isaac.GetCostumeIdByPath("gfx/characters/Character_001b_Leah_Pog.anm2")
	Poglite:AddPogCostume("LeahBPog", LeahB, LeahCostumeB)
	-- Tainted Peter
	local PeterCostumeA = Isaac.GetCostumeIdByPath("gfx/characters/Character_002b_Peter_Pog.anm2")
	Poglite:AddPogCostume("PeterBPog", PeterB, PeterCostumeA)
	-- Miriam
	local MiriamCostumeA = Isaac.GetCostumeIdByPath("gfx/characters/Character_003_Miriam_Pog.anm2")
	Poglite:AddPogCostume("MiriamPog", MiriamA, MiriamCostumeA)
end

if MiniMapiItemsAPI then
	local MoonHeartSprite = Sprite()
	MoonHeartSprite:Load("gfx/ui/heart_icon.anm2", true)
	-- Moon Heart
	MinimapAPI:AddIcon("MoonHeartIcon", MoonHeartSprite, "MoonHeart", 0)
	MinimapAPI:AddPickup(HeartSubType.HEART_MOON, "MoonHeartIcon", 5, 10, HeartSubType.HEART_MOON, MinimapAPI.PickupNotCollected, "hearts", 13000)
	-- Rock Heart
	MinimapAPI:AddIcon("RockHeartIcon", RockHeartSprite, "RockHeart", 0)
	MinimapAPI:AddPickup(HeartSubType.HEART_ROCK, "RockHeartIcon", 5, 10, HeartSubType.HEART_ROCK, MinimapAPI.PickupNotCollected, "hearts", 13000)
end

if ModConfigMenu then
	include("lua/MCM.lua")
end

-- Other
include("lua/piber.lua")

-------- Lua Files End --------

function Furtherance:playFailSound()
	SFXManager():Play(Furtherance.FailSound)
end

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
			if not mod.DataTable[index].FurtheranceRockHeart then
				mod.DataTable[index].FurtheranceRockHeart = 0
			end
			if not mod.DataTable[index].lastEternalHearts or not mod.DataTable[index].lastMaxHearts then
				mod.DataTable[index].lastEternalHearts = 0
				mod.DataTable[index].lastMaxHearts = 0
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

function mod:LoadDataCacheEval(player)
	if player.FrameCount == 1 then
		player:AddCacheFlags(CacheFlag.CACHE_ALL)
		player:EvaluateItems()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.LoadDataCacheEval)

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
	return Isaac.WorldToRenderPosition(pos)
end

function mod:GetScreenSize()
	local room = game:GetRoom()
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

function Furtherance:GetFireDelayFromTears(tearsPerSecond)
	return 30 / tearsPerSecond - 1
end

function Furtherance:GetTearsFromFireDelay(fireDelay)
	return 30 / (fireDelay + 1)
end
