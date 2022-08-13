local mod = Furtherance
local game = Game()

local AchievementGraphics = {
	Leah = {
		MomsHeart = "achievement_secretdiary",
		Isaac = "achievement_bindsofdevotion",
		Satan = "achievement_rue",
		BlueBaby = "achievement_mandrake",
		Lamb = "achievement_parasol",
		BossRush = "achievement_leahslock",
		Hush = "achievement_keratoconus",
		MegaSatan = "achievement_d16",
		Delirium = "achievement_heartrenovator",
		Mother = "achievement_owlseye",
		Beast = "achievement_essenceoflove",
		GreedMode = "achievement_holyheart",
		Greedier = "achievement_heartembeddedcoin",
		Tainted = "achievement_taintedleah",
		FullCompletion = "achievement_exsanguination",
	},
	LeahB = {
		PolNegPath = "achievement_leahsheart",
		SoulPath = "achievement_soulofleah",
		MegaSatan = "achievement_rottenlove",
		Delirium = "achievement_shatteredheart",
		Mother = "achievement_coldhearted",
		Beast = "achievement_essenceofhate",
		Greedier = "achievement_reversehope",
		FullCompletion = "achievement.full_completion_b",
	},
	Peter = {
		MomsHeart = "achievement_prayerjournal",
		Isaac = "achievement_pallium",
		Satan = "achievement_severedear",
		BlueBaby = "achievement_chirho",
		Lamb = "achievement_bookofleviticus",
		BossRush = "achievement_altruism",
		Hush = "achievement_liberation",
		MegaSatan = "achievement_astragali",
		Delirium = "achievement_keystothekingdom",
		Mother = "achievement_itchingpowder",
		Beast = "achievement_essenceoflife",
		GreedMode = "achievement_alabasterscrap",
		Greedier = "achievement_moltengold",
		Tainted = "achievement_taintedpeter",
		FullCompletion = "achievement_goldenport",
	},
	PeterB = {
		PolNegPath = "achievement_leviathanstendril",
		SoulPath = "achievement_soulofpeter",
		MegaSatan = "achievement_trepanation",
		Delirium = "achievement_muddledcross",
		Mother = "achievement_keytothepit",
		Beast = "achievement_essenceofdeath",
		Greedier = "achievement_reversefaith",
		FullCompletion = "achievement.full_completion_b",
	},
	Miriam = {
		MomsHeart = "achievement_bookofguidance",
		Isaac = "achievement_apocalypse",
		Satan = "achievement_kareth",
		BlueBaby = "achievement_pillarofclouds",
		Lamb = "achievement_pillaroffire",
		BossRush = "achievement_wormwoodleaf",
		Hush = "achievement_caduceusstaff",
		MegaSatan = "achievement_thedreidel",
		Delirium = "achievement_tambourine",
		Mother = "achievement_firstbornson",
		Beast = "achievement_essenceofprosperityanddrought",
		GreedMode = "achievement_salinespray",
		Greedier = "achievement_miriamswell",
		Tainted = "achievement_taintedmiriam",
		FullCompletion = "achievement_polydipsia",
	},
	MiriamB = {
		PolNegPath = "achievement_almagestscrap",
		SoulPath = "achievement_soulofmiriam",
		MegaSatan = "achievement_goldensack",
		Delirium = "achievement_spiritualwound",
		Mother = "achievement_abyssalpenny",
		Beast = "achievement_jarofmanna",
		Greedier = "achievement_reversecharity",
		FullCompletion = "achievement.full_completion_b",
	},
	Esther = {
		MomsHeart = "achievement_",
		Isaac = "achievement_",
		Satan = "achievement_",
		BlueBaby = "achievement_",
		Lamb = "achievement_",
		BossRush = "achievement_",
		Hush = "achievement_",
		MegaSatan = "achievement_",
		Delirium = "achievement_",
		Mother = "achievement_",
		Beast = "achievement_",
		GreedMode = "achievement_",
		Greedier = "achievement_",
		Tainted = "achievement_taintedesther",
		FullCompletion = "achievement_",
	},
	EstherB = {
		PolNegPath = "achievement_",
		SoulPath = "achievement_soulofesther",
		MegaSatan = "achievement_",
		Delirium = "achievement_",
		Mother = "achievement_",
		Beast = "achievement_",
		Greedier = "achievement_",
		FullCompletion = "achievement.full_completion_b",
	},
}

local AchievementText = {
	Leah = {
		MomsHeart = "Secret Diary",
		Isaac = "Binds of Devotion",
		Satan = "Rue",
		BlueBaby = "Mandrake",
		Lamb = "Parasol",
		BossRush = "Leah's Lock",
		Hush = "Keratoconus",
		MegaSatan = "D16",
		Delirium = "Heart Renovator",
		Mother = "Owl's Eye",
		Beast = "Essence of Love",
		GreedMode = "Holy Heart",
		Greedier = "Heart Embedded Coin",
		Tainted = "Tainted Leah",
		FullCompletion = "Exsanguination",
	},
	LeahB = {
		PolNegPath = "Leah's Heart",
		SoulPath = "Soul of Leah",
		MegaSatan = "Rotten Love",
		Delirium = "Shattered Heart",
		Mother = "Cold Hearted",
		Beast = "Essence of Hate",
		Greedier = "Reverse Hope",
		FullCompletion = "All Tainted Leah marks",
	},
	Peter = {
		MomsHeart = "Prayer Journal",
		Isaac = "Pallium",
		Satan = "Severed Ear",
		BlueBaby = "Chirho",
		Lamb = "Book ofl Eviticus",
		BossRush = "Altruism",
		Hush = "Liberation",
		MegaSatan = "Astragali",
		Delirium = "Keys to the Kingdom",
		Mother = "Itching Powder",
		Beast = "Essence of Life",
		GreedMode = "Alabaster Scrap",
		Greedier = "Molten Gold",
		Tainted = "Tainted Peter",
		FullCompletion = "Golden Port",
	},
	PeterB = {
		PolNegPath = "Leviathan's Tendril",
		SoulPath = "Soul of Peter",
		MegaSatan = "Trepanation",
		Delirium = "Muddled Cross",
		Mother = "Key to the Pit",
		Beast = "Essence of Death",
		Greedier = "Reverse Faith",
		FullCompletion = "All Tainted Peter marks",
	},
	Miriam = {
		MomsHeart = "Book of Guidance",
		Isaac = "Apocalypse",
		Satan = "Kareth",
		BlueBaby = "Pillar of Clouds",
		Lamb = "Pillar of Fire",
		BossRush = "Wormwood Leaf",
		Hush = "Caduceus Staff",
		MegaSatan = "The Dreidel",
		Delirium = "Tambourine",
		Mother = "Firstborn Son",
		Beast = "Essence of Prosperity + Drought",
		GreedMode = "Saline Spray",
		Greedier = "Miriam's Well",
		Tainted = "Tainted Miriam",
		FullCompletion = "Polydipsia",
	},
	MiriamB = {
		PolNegPath = "Almagest Scrap",
		SoulPath = "Soul of Miriam",
		MegaSatan = "Golden Sack",
		Delirium = "Spiritual Wound",
		Mother = "Abyssal Penny",
		Beast = "Jar of Manna",
		Greedier = "Reverse Charity",
		FullCompletion = "All Tainted Miriam marks",
	},
	Esther = {
		MomsHeart = "",
		Isaac = "",
		Satan = "",
		BlueBaby = "",
		Lamb = "",
		BossRush = "",
		Hush = "",
		MegaSatan = "",
		Delirium = "",
		Mother = "",
		Beast = "",
		GreedMode = "",
		Greedier = "Miriam's ",
		Tainted = "Tainted Esther",
		FullCompletion = "",
	},
	EstherB = {
		PolNegPath = "",
		SoulPath = "Soul of Esther",
		MegaSatan = "",
		Delirium = "",
		Mother = "",
		Beast = "",
		Greedier = "",
		FullCompletion = "All Tainted Esther marks",
	},
}

local function createUnlocksTable()
	return {
		Leah = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			Tainted = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
		LeahB = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			PolNegPath = false,
			SoulPath = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
		Peter = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			Tainted = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
		PeterB = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			PolNegPath = false,
			SoulPath = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
		Miriam = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			Tainted = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
		MiriamB = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			PolNegPath = false,
			SoulPath = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
		Esther = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			Tainted = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
		EstherB = {
			MomsHeart = {Unlock = false, Hard = false},
			Isaac = {Unlock = false, Hard = false},
			Satan = {Unlock = false, Hard = false},
			BlueBaby = {Unlock = false, Hard = false},
			Lamb = {Unlock = false, Hard = false},
			BossRush = {Unlock = false, Hard = false},
			Hush = {Unlock = false, Hard = false},
			MegaSatan = {Unlock = false, Hard = false},
			Delirium = {Unlock = false, Hard = false},
			Mother = {Unlock = false, Hard = false},
			Beast = {Unlock = false, Hard = false},
			GreedMode = {Unlock = false, Hard = false},
			PolNegPath = false,
			SoulPath = false,
			FullCompletion = {Unlock = false, Hard = false},
		},
	}
end

local noAPIachievements = {}

Furtherance.Unlocks = createUnlocksTable()

mod:ShelveModData({
	Unlocks = createUnlocksTable
})

local function PlayAchievement(achievement,playerName,name)
	if GiantBookAPI and Furtherance.PrefferedAPI == 1 then
		GiantBookAPI.ShowAchievement(achievement .. ".png")
	elseif ScreenAPI and (Furtherance.PrefferedAPI == 2 or (not GiantBookAPI and Furtherance.PrefferedAPI ~= 3)) then
		ScreenAPI.PlayAchievement("gfx/ui/achievements/"..achievement..".png", 60)
	else
		table.insert(noAPIachievements,AchievementText[playerName][name])
	end
end

local function GetPlayerAchievements(player)
	local ptype = player:GetPlayerType()
	local name = player:GetName()
	local isTainted = nil
	if ptype == PlayerType.PLAYER_LEAH or ptype == PlayerType.PLAYER_PETER or ptype == PlayerType.PLAYER_MIRIAM then
		isTainted = false
	elseif ptype == PlayerType.PLAYER_LEAH_B or ptype == PlayerType.PLAYER_PETER_B or ptype == PlayerType.PLAYER_MIRIAM_B then
		isTainted = true
		name = name.."B"
	end
	if isTainted ~= nil then
		return {name, isTainted}
	else
		return nil
	end
end

function mod:CantMove(player)
	return not (player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) or player:IsCoopGhost() or player:HasCurseMistEffect())
end

local function setCanShoot(player, canShoot) -- Funciton Credit: im_tem
	local oldchallenge = game.Challenge

	game.Challenge = canShoot and Challenge.CHALLENGE_NULL or Challenge.CHALLENGE_SOLAR_SYSTEM
	player:UpdateCanShoot()
	game.Challenge = oldchallenge
end

function mod:NoMovement(entity, hook, button)
	if entity ~= nil and entity.Type == EntityType.ENTITY_PLAYER and not entity:IsDead() and hook == InputHook.GET_ACTION_VALUE then
		local player = entity:ToPlayer()
		if ((mod.Unlocks.Leah.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_LEAH_B)
		or (mod.Unlocks.Peter.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_PETER_B)
		or (mod.Unlocks.Miriam.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B)
		or (mod.Unlocks.Esther.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B))
		and mod:CantMove(player) then
			setCanShoot(player, false)
			if button == ButtonAction.ACTION_LEFT or button == ButtonAction.ACTION_RIGHT or button == ButtonAction.ACTION_UP or button == ButtonAction.ACTION_DOWN then
				return 0
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, mod.NoMovement, 2)

local noAPITextCooldown = 0
function mod:TextAchievementHandler()
	if #noAPIachievements > 0 and noAPITextCooldown == 0 then
		game:GetHUD():ShowItemText("Unlocked "..noAPIachievements[1])
		noAPITextCooldown = 90
		table.remove(noAPIachievements,1)
	end
	if noAPITextCooldown > 0 then
		noAPITextCooldown = noAPITextCooldown - 1
	end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.TextAchievementHandler)

function mod:StartUnlocks()
	local level = game:GetLevel()
	local room = game:GetRoom()
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		-- Tainted Stuff
		if (mod.Unlocks.Leah.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_LEAH_B)
		or (mod.Unlocks.Peter.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_PETER_B)
		or (mod.Unlocks.Miriam.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B)
		or (mod.Unlocks.Esther.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B) then
			Isaac.ExecuteCommand("stage 13")
			level:MakeRedRoomDoor(95, DoorSlot.LEFT0)
			level:ChangeRoom(94)
			room:RemoveDoor(DoorSlot.RIGHT0)
			for _, entity in ipairs(Isaac.GetRoomEntities()) do
				if ((entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE)
				or (entity.Type == EntityType.ENTITY_SHOPKEEPER)) then
					Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, entity.Position, Vector.Zero, nil)
					entity:Remove()
				end
			end
			game:GetHUD():SetVisible(false)
			player.Visible = false
		end

		-- Leah
		if mod.Unlocks.Leah.MomsHeart.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SECRET_DIARY)
		end
		if mod.Unlocks.Leah.Isaac.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION)
		end
		if mod.Unlocks.Leah.Satan.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_RUE)
		end
		if mod.Unlocks.Leah.BlueBaby.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MANDRAKE)
		end
		if mod.Unlocks.Leah.Lamb.Unlock == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_PARASOL)
		end
		if mod.Unlocks.Leah.BossRush.Unlock == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_LEAHS_LOCK)
		end
		if mod.Unlocks.Leah.Hush.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS)
		end
		if mod.Unlocks.Leah.MegaSatan.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_D16)
		end
		if mod.Unlocks.Leah.Delirium.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
		end
		if mod.Unlocks.Leah.Mother.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE)
		end
		if mod.Unlocks.Leah.GreedMode.Unlock == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_HOLY_HEART)
		end
		if mod.Unlocks.Leah.GreedMode.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_HEART_EMBEDDED_COIN)
		end
		if mod.Unlocks.Leah.FullCompletion.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_EXSANGUINATION)
		end

		-- Tainted Leah
		if mod.Unlocks.LeahB.PolNegPath == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_LEAHS_HEART)
		end
		if mod.Unlocks.LeahB.MegaSatan.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_ROTTEN_LOVE)
		end
		if mod.Unlocks.LeahB.Delirium.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART)
		end
		if mod.Unlocks.LeahB.Mother.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_COLD_HEARTED)
		end

		-- Peter
		if mod.Unlocks.Peter.MomsHeart.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PRAYER_JOURNAL)
		end
		if mod.Unlocks.Peter.Isaac.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PALLIUM)
		end
		if mod.Unlocks.Peter.Satan.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SEVERED_EAR)
		end
		if mod.Unlocks.Peter.BlueBaby.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_CHI_RHO)
		end
		if mod.Unlocks.Peter.Lamb.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_LEVITICUS)
		end
		if mod.Unlocks.Peter.BossRush.Unlock == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ALTRUISM)
		end
		if mod.Unlocks.Peter.Hush.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_LIBERATION)
		end
		if mod.Unlocks.Peter.MegaSatan.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_ASTRAGALI)
		end
		if mod.Unlocks.Peter.Delirium.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)
		end
		if mod.Unlocks.Peter.Mother.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_ITCHING_POWDER)
		end
		if mod.Unlocks.Peter.GreedMode.Unlock == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ALABASTER_SCRAP)
		end
		if mod.Unlocks.Peter.GreedMode.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MOLTEN_GOLD)
		end
		if mod.Unlocks.Peter.FullCompletion.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_GOLDEN_PORT)
		end

		-- Tainted Peter
		if mod.Unlocks.PeterB.PolNegPath == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_LEVIATHANS_TENDRIL)
		end
		if mod.Unlocks.PeterB.MegaSatan.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_TREPANATION)
		end
		if mod.Unlocks.PeterB.Delirium.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MUDDLED_CROSS)
		end
		if mod.Unlocks.PeterB.Mother.Hard == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_KEY_TO_THE_PIT)
		end

		-- Miriam
		if mod.Unlocks.Miriam.MomsHeart.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_GUIDANCE)
		end
		if mod.Unlocks.Miriam.Isaac.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_APOCALYPSE)
		end
		if mod.Unlocks.Miriam.Satan.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_KARETH)
		end
		if mod.Unlocks.Miriam.BlueBaby.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_CLOUDS)
		end
		if mod.Unlocks.Miriam.Lamb.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)
		end
		if mod.Unlocks.Miriam.BossRush.Unlock == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_WORMWOOD_LEAF)
		end
		if mod.Unlocks.Miriam.Hush.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_CADUCEUS_STAFF)
		end
		if mod.Unlocks.Miriam.MegaSatan.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_THE_DREIDEL)
		end
		if mod.Unlocks.Miriam.Delirium.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_TAMBOURINE)
		end
		if mod.Unlocks.Miriam.Mother.Unlock == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_FIRSTBORN_SON)
		end
		if mod.Unlocks.Miriam.GreedMode.Unlock == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_SALINE_SPRAY)
		end
		if mod.Unlocks.Miriam.GreedMode.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_WELL)
		end
		if mod.Unlocks.Miriam.FullCompletion.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)
		end

		-- Tainted Miriam
		if mod.Unlocks.MiriamB.PolNegPath == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ALMAGEST_SCRAP)
		end
		if mod.Unlocks.MiriamB.Delirium.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
		end
		if mod.Unlocks.MiriamB.Mother.Hard == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ABYSSAL_PENNY)
		end
		if mod.Unlocks.MiriamB.Beast.Hard == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_JAR_OF_MANNA)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.StartUnlocks)

function mod:StartUnlocksPickups(entity)
	-- Leah
	if mod.Unlocks.Leah.Beast.Unlock == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == OBJ_ESSENCE_OF_LOVE then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.LeahB.SoulPath == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == RUNE_SOUL_OF_LEAH then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.LeahB.Beast.Hard == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == OBJ_ESSENCE_OF_HATE then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.LeahB.GreedMode.Hard == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == CARD_REVERSE_HOPE then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end

	-- Peter
	if mod.Unlocks.Peter.Beast.Unlock == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == OBJ_ESSENCE_OF_LIFE then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.PeterB.SoulPath == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == RUNE_SOUL_OF_PETER then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.PeterB.Beast.Hard == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == OBJ_ESSENCE_OF_DEATH then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.PeterB.GreedMode.Hard == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == CARD_REVERSE_FAITH then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end

	-- Miriam
	if mod.Unlocks.Miriam.Beast.Unlock == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and (entity.SubType == OBJ_ESSENCE_OF_PROSPERITY or entity.SubType == OBJ_ESSENCE_OF_DROUGHT) then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.MiriamB.SoulPath == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == RUNE_SOUL_OF_MIRIAM then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.MiriamB.GreedMode.Hard == false then
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == CARD_REVERSE_CHARITY then
			entity:Morph(entity.Type, entity.Variant, Card.CARD_NULL)
		end
	end
	if mod.Unlocks.MiriamB.MegaSatan.Hard == false then
		if entity.Variant == PickupVariant.PICKUP_GRAB_BAG and entity.SubType == SackSubType.SACK_GOLDEN then
			entity:Morph(entity.Type, entity.Variant, SackSubType.SACK_NORMAL)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.StartUnlocksPickups)

function mod:UpdateCompletion(name, difficulty)
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		local AchievementPlayer = GetPlayerAchievements(player)
		if AchievementPlayer == nil then return end
		local isTainted = AchievementPlayer[2]
		local playerName = AchievementPlayer[1]
		if not isTainted then
			local TargetTab = mod.Unlocks[playerName]
			if TargetTab[name].Unlock == false then
				TargetTab[name].Unlock = true
				
				if AchievementGraphics[playerName][name] then
					PlayAchievement(AchievementGraphics[playerName][name],playerName,name)
				end
			end
			if difficulty == Difficulty.DIFFICULTY_HARD then
				TargetTab[name].Hard = true
			elseif difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if TargetTab[name].Hard == false then
					TargetTab[name].Hard = true
					PlayAchievement(AchievementGraphics[playerName].Greedier,playerName,"Greedier")
				end
			end
			
			local MissingUnlock = false
			local MissingHard = false
			for boss, tab in pairs(TargetTab) do
				if boss ~= "FullCompletion"
				and type(tab) == "table"
				then
					if tab.Unlock == false then
						MissingUnlock = true
						break
					end
					if tab.Hard == false then
						MissingHard = true
						
						if boss == "GreedMode" then
							MissingUnlock = true
							break
						end
					end
				end
			end
			
			if (not MissingUnlock)
			then
				if not TargetTab.FullCompletion.Unlock then
					TargetTab.FullCompletion.Unlock = true
					PlayAchievement(AchievementGraphics[playerName].FullCompletion,playerName,"FullCompletion")
				
					if (not MissingHard)
					and (not TargetTab.FullCompletion.Hard)
					then
						TargetTab.FullCompletion.Hard = true
					end
				end
			end
		else
			local TargetTab = mod.Unlocks[playerName]

			if TargetTab[name].Unlock == false then
				TargetTab[name].Unlock = true
				
				if AchievementGraphics[playerName][name] then
					PlayAchievement(AchievementGraphics[playerName][name],playerName,name)
				end
			end
			if difficulty == Difficulty.DIFFICULTY_HARD then
				TargetTab[name].Hard = true
			elseif difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if TargetTab[name].Hard == false then
					TargetTab[name].Hard = true
					PlayAchievement(AchievementGraphics[playerName].Greedier,playerName,"Greedier")
				end
			end
			
			if TargetTab.PolNegPath == false
			and TargetTab.Isaac.Unlock == true
			and TargetTab.BlueBaby.Unlock == true
			and TargetTab.Satan.Unlock == true
			and TargetTab.Lamb.Unlock == true
			then
				TargetTab.PolNegPath = true
				PlayAchievement(AchievementGraphics[playerName].PolNegPath,playerName,"PolNegPath")
			end
			
			if TargetTab.SoulPath == false
			and TargetTab.BossRush.Unlock == true
			and TargetTab.Hush.Unlock == true
			then
				TargetTab.SoulPath = true
				PlayAchievement(AchievementGraphics[playerName].SoulPath,playerName,"SoulPath")
			end
			
			local MissingUnlock = false
			local MissingHard = false
			for boss, tab in pairs(TargetTab) do
				if boss ~= "FullCompletion"
				and type(tab) == "table"
				then
					if tab.Unlock == false then
						MissingUnlock = true
						break
					end
					if tab.Hard == false then
						MissingHard = true
						
						if boss == "GreedMode" then
							MissingUnlock = true
							break
						end
					end
				end
			end
			
			if (not MissingUnlock)	then
				if not TargetTab.FullCompletion.Unlock then
					TargetTab.FullCompletion.Unlock = true
					PlayAchievement(AchievementGraphics[playerName].FullCompletion,playerName,"FullCompletion")
					if (not MissingHard)
					and (not TargetTab.FullCompletion.Hard)
					then
						TargetTab.FullCompletion.Hard = true
					end
				end
			end
		end
	end
end

local UnlockFunctions = {
	[LevelStage.STAGE4_2] = function(room, stageType, difficulty, desc) -- Heart / Mother
		if room:IsClear() then
			local Name
			if stageType >= StageType.STAGETYPE_REPENTANCE
			and desc.SafeGridIndex == -10
			then
				Name = "Mother"
			elseif stageType <= StageType.STAGETYPE_AFTERBIRTH
			and room:IsCurrentRoomLastBoss()
			then
				Name = "MomsHeart"
			end
		
			if Name then
				mod:UpdateCompletion(Name, difficulty)
			end
		end
	end,
	[LevelStage.STAGE4_3] = function(room, stageType, difficulty, desc) -- Hush
		if room:IsClear() then
			local Name = "Hush"
		
			mod:UpdateCompletion(Name, difficulty)
		end
	end,
	[LevelStage.STAGE5] = function(room, stageType, difficulty, desc) -- Satan / Isaac
		if room:IsClear() then
			local Name = "Satan"
			if stageType == StageType.STAGETYPE_WOTL then
				Name = "Isaac"
			end
		
			mod:UpdateCompletion(Name, difficulty)
		end
	end,
	[LevelStage.STAGE6] = function(room, stageType, difficulty, desc) -- Mega Satan / Lamb / Blue Baby
		if desc.SafeGridIndex == -7 then
			local MegaSatan
			for _, satan in ipairs(Isaac.FindByType(EntityType.ENTITY_MEGA_SATAN_2, 0)) do
				MegaSatan = satan
				break
			end
		
			if not MegaSatan then return end
			
			local sprite = MegaSatan:GetSprite()
			
			if sprite:IsPlaying("Death") and sprite:GetFrame() == 110 then
				local Name = "MegaSatan"
			
				mod:UpdateCompletion(Name, difficulty)
			end
		else
			if room:IsClear() then
				local Name = "Lamb"
				if stageType == StageType.STAGETYPE_WOTL then
					Name = "BlueBaby"
				end
			
				mod:UpdateCompletion(Name, difficulty)
			end
		end
	end,
	[LevelStage.STAGE7] = function(room, stageType, difficulty, desc) -- Delirium
		if desc.Data.Subtype == 70 and room:IsClear() then
			local Name = "Delirium"
		
			mod:UpdateCompletion(Name, difficulty)
		end
	end,
	
	BossRush = function(room, stageType, difficulty, desc) -- Boss Rush
		if room:IsAmbushDone() then
			local Name = "BossRush"
		
			mod:UpdateCompletion(Name, difficulty)
		end
	end,
	Beast = function(room, stageType, difficulty, desc) -- Beast
		local Beast
		for _, beast in ipairs(Isaac.FindByType(EntityType.ENTITY_BEAST, 0)) do
			Beast = beast
			break
		end
	
		if not Beast then return end
		
		local sprite = Beast:GetSprite()
		
		if sprite:IsPlaying("Death") and sprite:GetFrame() == 30 then
			local Name = "Beast"
		
			mod:UpdateCompletion(Name, difficulty)
		end
	end,
	Greed = function(room, stageType, difficulty, desc) -- Greed
		if room:IsClear() then
			local Name = "GreedMode"
			
			mod:UpdateCompletion(Name, difficulty)
		end
	end,
}

function mod:postUpdateAchievements()
	local level = game:GetLevel()
	local room = game:GetRoom()
	local desc = level:GetCurrentRoomDesc()
	local levelStage = level:GetStage()
	local roomType = room:GetType()
	local difficulty = game.Difficulty
	
	if Isaac.GetChallenge() > 0
	or game:GetVictoryLap() > 0
	then
		return
	end
	
	if difficulty <= Difficulty.DIFFICULTY_HARD then
		local stageType = level:GetStageType()
		
		if levelStage == LevelStage.STAGE4_1
		and level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH > 0
		then
			levelStage = levelStage + 1
		end
		
		if roomType == RoomType.ROOM_BOSS and UnlockFunctions[levelStage] then
			UnlockFunctions[levelStage](room, stageType, difficulty, desc)
			mod:OnSaveData(false)
		elseif roomType == RoomType.ROOM_BOSSRUSH then
			UnlockFunctions.BossRush(room, stageType, difficulty, desc)
			mod:OnSaveData(false)
		elseif levelStage == LevelStage.STAGE8 and roomType == RoomType.ROOM_DUNGEON then
			UnlockFunctions.Beast(room, stageType, difficulty, desc)
			mod:OnSaveData(false)
		end
	else
		if levelStage == LevelStage.STAGE7_GREED
		and roomType == RoomType.ROOM_BOSS
		and desc.SafeGridIndex == 45
		then
			UnlockFunctions.Greed(room, nil, difficulty, desc)
			mod:OnSaveData(false)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.postUpdateAchievements)