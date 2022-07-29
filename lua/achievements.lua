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
		FullCompletion = "achievement.full_completion",
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
		Greedier = "achievement_unluckypenny",
		Tainted = "achievement_taintedpeter",
		FullCompletion = "achievement.full_completion",
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
		Beast = "achievement_essenceofprosperity",
		GreedMode = "achievement_salinespray",
		Greedier = "achievement_miriamswell",
		Tainted = "achievement_taintedmiriam",
		FullCompletion = "achievement.full_completion",
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
	}
end

Furtherance.Unlocks = createUnlocksTable()

mod:ShelveModData({
	Unlocks = createUnlocksTable()
})

local function PlayAchievement(achievement)
	if GiantBookAPI then
		GiantBookAPI.ShowAchievement(achievement .. ".png")
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
		or (mod.Unlocks.Miriam.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B))
		and mod:CantMove(player) then
			setCanShoot(player, false)
			if button == ButtonAction.ACTION_LEFT or button == ButtonAction.ACTION_RIGHT or button == ButtonAction.ACTION_UP or button == ButtonAction.ACTION_DOWN then
				return 0
			end
		end
	end

end
mod:AddCallback(ModCallbacks.MC_INPUT_ACTION, mod.NoMovement, 2)

function mod:StartUnlocks()
	local level = game:GetLevel()
	local room = game:GetRoom()
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		-- Tainted Stuff
		if (mod.Unlocks.Leah.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_LEAH_B)
		or (mod.Unlocks.Peter.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_PETER_B)
		or (mod.Unlocks.Miriam.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B) then
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
		if entity.Variant == PickupVariant.PICKUP_TAROTCARD and entity.SubType == OBJ_ESSENCE_OF_PROSPERITY then
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
					PlayAchievement(AchievementGraphics[playerName][name])
				end
			end
			if difficulty == Difficulty.DIFFICULTY_HARD then
				TargetTab[name].Hard = true
			elseif difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if TargetTab[name].Hard == false then
					TargetTab[name].Hard = true
					PlayAchievement(AchievementGraphics[playerName].Greedier)
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
					PlayAchievement(AchievementGraphics[playerName].FullCompletion)
				
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
					PlayAchievement(AchievementGraphics[playerName][name])
				end
			end
			if difficulty == Difficulty.DIFFICULTY_HARD then
				TargetTab[name].Hard = true
			elseif difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if TargetTab[name].Hard == false then
					TargetTab[name].Hard = true
					PlayAchievement(AchievementGraphics[playerName].Greedier)
				end
			end
			
			if TargetTab.PolNegPath == false
			and TargetTab.Isaac.Unlock == true
			and TargetTab.BlueBaby.Unlock == true
			and TargetTab.Satan.Unlock == true
			and TargetTab.Lamb.Unlock == true
			then
				TargetTab.PolNegPath = true
				PlayAchievement(AchievementGraphics[playerName].PolNegPath)
			end
			
			if TargetTab.SoulPath == false
			and TargetTab.BossRush.Unlock == true
			and TargetTab.Hush.Unlock == true
			then
				TargetTab.SoulPath = true
				PlayAchievement(AchievementGraphics[playerName].SoulPath)
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
					PlayAchievement(AchievementGraphics[playerName].FullCompletion)
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

function mod:ResetUnlocks(cmd)
	if string.lower(cmd) == "furtherancehelp" then
		print("Reset a character's unlocks: reset[name]\nExamples: resetleahb, resetpeter\n\nUnlock all of a character's unlocks: unlock[name]\nExamples: unlockleah, unlockmiriamb")
	end
	if string.lower(cmd) == "resetleah" then
		mod.Unlocks.Leah.MomsHeart.Unlock = false
		mod.Unlocks.Leah.Isaac.Unlock = false
		mod.Unlocks.Leah.Satan.Unlock = false
		mod.Unlocks.Leah.BlueBaby.Unlock = false
		mod.Unlocks.Leah.Lamb.Unlock = false
		mod.Unlocks.Leah.BossRush.Unlock = false
		mod.Unlocks.Leah.Hush.Unlock = false
		mod.Unlocks.Leah.MegaSatan.Unlock = false
		mod.Unlocks.Leah.Delirium.Unlock = false
		mod.Unlocks.Leah.Mother.Unlock = false
		mod.Unlocks.Leah.Beast.Unlock = false
		mod.Unlocks.Leah.GreedMode.Unlock = false
		mod.Unlocks.Leah.FullCompletion.Unlock = false

		mod.Unlocks.Leah.MomsHeart.Hard = false
		mod.Unlocks.Leah.Isaac.Hard = false
		mod.Unlocks.Leah.Satan.Hard = false
		mod.Unlocks.Leah.BlueBaby.Hard = false
		mod.Unlocks.Leah.Lamb.Hard = false
		mod.Unlocks.Leah.BossRush.Hard = false
		mod.Unlocks.Leah.Hush.Hard = false
		mod.Unlocks.Leah.MegaSatan.Hard = false
		mod.Unlocks.Leah.Delirium.Hard = false
		mod.Unlocks.Leah.Mother.Hard = false
		mod.Unlocks.Leah.Beast.Hard = false
		mod.Unlocks.Leah.GreedMode.Hard = false
		mod.Unlocks.Leah.FullCompletion.Hard = false

		mod.Unlocks.Leah.Tainted = false
		print("Leah has been reset.")
	end
	if string.lower(cmd) == "unlockleah" then
		mod.Unlocks.Leah.MomsHeart.Unlock = true
		mod.Unlocks.Leah.Isaac.Unlock = true
		mod.Unlocks.Leah.Satan.Unlock = true
		mod.Unlocks.Leah.BlueBaby.Unlock = true
		mod.Unlocks.Leah.Lamb.Unlock = true
		mod.Unlocks.Leah.BossRush.Unlock = true
		mod.Unlocks.Leah.Hush.Unlock = true
		mod.Unlocks.Leah.MegaSatan.Unlock = true
		mod.Unlocks.Leah.Delirium.Unlock = true
		mod.Unlocks.Leah.Mother.Unlock = true
		mod.Unlocks.Leah.Beast.Unlock = true
		mod.Unlocks.Leah.GreedMode.Unlock = true
		mod.Unlocks.Leah.FullCompletion.Unlock = true

		mod.Unlocks.Leah.MomsHeart.Hard = true
		mod.Unlocks.Leah.Isaac.Hard = true
		mod.Unlocks.Leah.Satan.Hard = true
		mod.Unlocks.Leah.BlueBaby.Hard = true
		mod.Unlocks.Leah.Lamb.Hard = true
		mod.Unlocks.Leah.BossRush.Hard = true
		mod.Unlocks.Leah.Hush.Hard = true
		mod.Unlocks.Leah.MegaSatan.Hard = true
		mod.Unlocks.Leah.Delirium.Hard = true
		mod.Unlocks.Leah.Mother.Hard = true
		mod.Unlocks.Leah.Beast.Hard = true
		mod.Unlocks.Leah.GreedMode.Hard = true
		mod.Unlocks.Leah.FullCompletion.Hard = true

		mod.Unlocks.Leah.Tainted = true
		print("All Leah marks have been unlocked.")
	end
	if string.lower(cmd) == "resetpeter" then
		mod.Unlocks.Peter.MomsHeart.Unlock = false
		mod.Unlocks.Peter.Isaac.Unlock = false
		mod.Unlocks.Peter.Satan.Unlock = false
		mod.Unlocks.Peter.BlueBaby.Unlock = false
		mod.Unlocks.Peter.Lamb.Unlock = false
		mod.Unlocks.Peter.BossRush.Unlock = false
		mod.Unlocks.Peter.Hush.Unlock = false
		mod.Unlocks.Peter.MegaSatan.Unlock = false
		mod.Unlocks.Peter.Delirium.Unlock = false
		mod.Unlocks.Peter.Mother.Unlock = false
		mod.Unlocks.Peter.Beast.Unlock = false
		mod.Unlocks.Peter.GreedMode.Unlock = false
		mod.Unlocks.Peter.FullCompletion.Unlock = false
		
		mod.Unlocks.Peter.MomsHeart.Hard = false
		mod.Unlocks.Peter.Isaac.Hard = false
		mod.Unlocks.Peter.Satan.Hard = false
		mod.Unlocks.Peter.BlueBaby.Hard = false
		mod.Unlocks.Peter.Lamb.Hard = false
		mod.Unlocks.Peter.BossRush.Hard = false
		mod.Unlocks.Peter.Hush.Hard = false
		mod.Unlocks.Peter.MegaSatan.Hard = false
		mod.Unlocks.Peter.Delirium.Hard = false
		mod.Unlocks.Peter.Mother.Hard = false
		mod.Unlocks.Peter.Beast.Hard = false
		mod.Unlocks.Peter.GreedMode.Hard = false
		mod.Unlocks.Peter.FullCompletion.Hard = false
		
		mod.Unlocks.Peter.Tainted = false
		print("Peter has been reset.")
	end
	if string.lower(cmd) == "unlockpeter" then
		mod.Unlocks.Peter.MomsHeart.Unlock = true
		mod.Unlocks.Peter.Isaac.Unlock = true
		mod.Unlocks.Peter.Satan.Unlock = true
		mod.Unlocks.Peter.BlueBaby.Unlock = true
		mod.Unlocks.Peter.Lamb.Unlock = true
		mod.Unlocks.Peter.BossRush.Unlock = true
		mod.Unlocks.Peter.Hush.Unlock = true
		mod.Unlocks.Peter.MegaSatan.Unlock = true
		mod.Unlocks.Peter.Delirium.Unlock = true
		mod.Unlocks.Peter.Mother.Unlock = true
		mod.Unlocks.Peter.Beast.Unlock = true
		mod.Unlocks.Peter.GreedMode.Unlock = true
		mod.Unlocks.Peter.FullCompletion.Unlock = true
		
		mod.Unlocks.Peter.MomsHeart.Hard = true
		mod.Unlocks.Peter.Isaac.Hard = true
		mod.Unlocks.Peter.Satan.Hard = true
		mod.Unlocks.Peter.BlueBaby.Hard = true
		mod.Unlocks.Peter.Lamb.Hard = true
		mod.Unlocks.Peter.BossRush.Hard = true
		mod.Unlocks.Peter.Hush.Hard = true
		mod.Unlocks.Peter.MegaSatan.Hard = true
		mod.Unlocks.Peter.Delirium.Hard = true
		mod.Unlocks.Peter.Mother.Hard = true
		mod.Unlocks.Peter.Beast.Hard = true
		mod.Unlocks.Peter.GreedMode.Hard = true
		mod.Unlocks.Peter.FullCompletion.Hard = true
		
		mod.Unlocks.Peter.Tainted = true
		print("All Peter marks have been unlocked.")
	end
	if string.lower(cmd) == "resetmiriam" then
		mod.Unlocks.Miriam.MomsHeart.Unlock = false
		mod.Unlocks.Miriam.Isaac.Unlock = false
		mod.Unlocks.Miriam.Satan.Unlock = false
		mod.Unlocks.Miriam.BlueBaby.Unlock = false
		mod.Unlocks.Miriam.Lamb.Unlock = false
		mod.Unlocks.Miriam.BossRush.Unlock = false
		mod.Unlocks.Miriam.Hush.Unlock = false
		mod.Unlocks.Miriam.MegaSatan.Unlock = false
		mod.Unlocks.Miriam.Delirium.Unlock = false
		mod.Unlocks.Miriam.Mother.Unlock = false
		mod.Unlocks.Miriam.Beast.Unlock = false
		mod.Unlocks.Miriam.GreedMode.Unlock = false
		mod.Unlocks.Miriam.FullCompletion.Unlock = false
		
		mod.Unlocks.Miriam.MomsHeart.Hard = false
		mod.Unlocks.Miriam.Isaac.Hard = false
		mod.Unlocks.Miriam.Satan.Hard = false
		mod.Unlocks.Miriam.BlueBaby.Hard = false
		mod.Unlocks.Miriam.Lamb.Hard = false
		mod.Unlocks.Miriam.BossRush.Hard = false
		mod.Unlocks.Miriam.Hush.Hard = false
		mod.Unlocks.Miriam.MegaSatan.Hard = false
		mod.Unlocks.Miriam.Delirium.Hard = false
		mod.Unlocks.Miriam.Mother.Hard = false
		mod.Unlocks.Miriam.Beast.Hard = false
		mod.Unlocks.Miriam.GreedMode.Hard = false
		mod.Unlocks.Miriam.FullCompletion.Hard = false
		
		mod.Unlocks.Miriam.Tainted = false
		print("Miriam has been reset.")
	end
	if string.lower(cmd) == "unlockmiriam" then
		mod.Unlocks.Miriam.MomsHeart.Unlock = true
		mod.Unlocks.Miriam.Isaac.Unlock = true
		mod.Unlocks.Miriam.Satan.Unlock = true
		mod.Unlocks.Miriam.BlueBaby.Unlock = true
		mod.Unlocks.Miriam.Lamb.Unlock = true
		mod.Unlocks.Miriam.BossRush.Unlock = true
		mod.Unlocks.Miriam.Hush.Unlock = true
		mod.Unlocks.Miriam.MegaSatan.Unlock = true
		mod.Unlocks.Miriam.Delirium.Unlock = true
		mod.Unlocks.Miriam.Mother.Unlock = true
		mod.Unlocks.Miriam.Beast.Unlock = true
		mod.Unlocks.Miriam.GreedMode.Unlock = true
		mod.Unlocks.Miriam.FullCompletion.Unlock = true
		
		mod.Unlocks.Miriam.MomsHeart.Hard = true
		mod.Unlocks.Miriam.Isaac.Hard = true
		mod.Unlocks.Miriam.Satan.Hard = true
		mod.Unlocks.Miriam.BlueBaby.Hard = true
		mod.Unlocks.Miriam.Lamb.Hard = true
		mod.Unlocks.Miriam.BossRush.Hard = true
		mod.Unlocks.Miriam.Hush.Hard = true
		mod.Unlocks.Miriam.MegaSatan.Hard = true
		mod.Unlocks.Miriam.Delirium.Hard = true
		mod.Unlocks.Miriam.Mother.Hard = true
		mod.Unlocks.Miriam.Beast.Hard = true
		mod.Unlocks.Miriam.GreedMode.Hard = true
		mod.Unlocks.Miriam.FullCompletion.Hard = true
		
		mod.Unlocks.Miriam.Tainted = true
		print("All Miriam marks have been unlocked.")
	end

	-- Tainteds
	if string.lower(cmd) == "resetleahb" then
		mod.Unlocks.LeahB.MomsHeart.Unlock = false
		mod.Unlocks.LeahB.Isaac.Unlock = false
		mod.Unlocks.LeahB.Satan.Unlock = false
		mod.Unlocks.LeahB.BlueBaby.Unlock = false
		mod.Unlocks.LeahB.Lamb.Unlock = false
		mod.Unlocks.LeahB.BossRush.Unlock = false
		mod.Unlocks.LeahB.Hush.Unlock = false
		mod.Unlocks.LeahB.MegaSatan.Unlock = false
		mod.Unlocks.LeahB.Delirium.Unlock = false
		mod.Unlocks.LeahB.Mother.Unlock = false
		mod.Unlocks.LeahB.Beast.Unlock = false
		mod.Unlocks.LeahB.GreedMode.Unlock = false
		mod.Unlocks.LeahB.FullCompletion.Unlock = false
		
		mod.Unlocks.LeahB.MomsHeart.Hard = false
		mod.Unlocks.LeahB.Isaac.Hard = false
		mod.Unlocks.LeahB.Satan.Hard = false
		mod.Unlocks.LeahB.BlueBaby.Hard = false
		mod.Unlocks.LeahB.Lamb.Hard = false
		mod.Unlocks.LeahB.BossRush.Hard = false
		mod.Unlocks.LeahB.Hush.Hard = false
		mod.Unlocks.LeahB.MegaSatan.Hard = false
		mod.Unlocks.LeahB.Delirium.Hard = false
		mod.Unlocks.LeahB.Mother.Hard = false
		mod.Unlocks.LeahB.Beast.Hard = false
		mod.Unlocks.LeahB.GreedMode.Hard = false
		mod.Unlocks.LeahB.FullCompletion.Hard = false
		print("Tainted Leah has been reset.")
	end
	if string.lower(cmd) == "unlockleahb" then
		mod.Unlocks.LeahB.MomsHeart.Unlock = true
		mod.Unlocks.LeahB.Isaac.Unlock = true
		mod.Unlocks.LeahB.Satan.Unlock = true
		mod.Unlocks.LeahB.BlueBaby.Unlock = true
		mod.Unlocks.LeahB.Lamb.Unlock = true
		mod.Unlocks.LeahB.BossRush.Unlock = true
		mod.Unlocks.LeahB.Hush.Unlock = true
		mod.Unlocks.LeahB.MegaSatan.Unlock = true
		mod.Unlocks.LeahB.Delirium.Unlock = true
		mod.Unlocks.LeahB.Mother.Unlock = true
		mod.Unlocks.LeahB.Beast.Unlock = true
		mod.Unlocks.LeahB.GreedMode.Unlock = true
		mod.Unlocks.LeahB.FullCompletion.Unlock = true
		
		mod.Unlocks.LeahB.MomsHeart.Hard = true
		mod.Unlocks.LeahB.Isaac.Hard = true
		mod.Unlocks.LeahB.Satan.Hard = true
		mod.Unlocks.LeahB.BlueBaby.Hard = true
		mod.Unlocks.LeahB.Lamb.Hard = true
		mod.Unlocks.LeahB.BossRush.Hard = true
		mod.Unlocks.LeahB.Hush.Hard = true
		mod.Unlocks.LeahB.MegaSatan.Hard = true
		mod.Unlocks.LeahB.Delirium.Hard = true
		mod.Unlocks.LeahB.Mother.Hard = true
		mod.Unlocks.LeahB.Beast.Hard = true
		mod.Unlocks.LeahB.GreedMode.Hard = true
		mod.Unlocks.LeahB.FullCompletion.Hard = true
		print("All Tainted Leah marks have been unlocked.")
	end
	if string.lower(cmd) == "resetpeterb" then
		mod.Unlocks.PeterB.MomsHeart.Unlock = false
		mod.Unlocks.PeterB.Isaac.Unlock = false
		mod.Unlocks.PeterB.Satan.Unlock = false
		mod.Unlocks.PeterB.BlueBaby.Unlock = false
		mod.Unlocks.PeterB.Lamb.Unlock = false
		mod.Unlocks.PeterB.BossRush.Unlock = false
		mod.Unlocks.PeterB.Hush.Unlock = false
		mod.Unlocks.PeterB.MegaSatan.Unlock = false
		mod.Unlocks.PeterB.Delirium.Unlock = false
		mod.Unlocks.PeterB.Mother.Unlock = false
		mod.Unlocks.PeterB.Beast.Unlock = false
		mod.Unlocks.PeterB.GreedMode.Unlock = false
		mod.Unlocks.PeterB.FullCompletion.Unlock = false
		
		mod.Unlocks.PeterB.MomsHeart.Hard = false
		mod.Unlocks.PeterB.Isaac.Hard = false
		mod.Unlocks.PeterB.Satan.Hard = false
		mod.Unlocks.PeterB.BlueBaby.Hard = false
		mod.Unlocks.PeterB.Lamb.Hard = false
		mod.Unlocks.PeterB.BossRush.Hard = false
		mod.Unlocks.PeterB.Hush.Hard = false
		mod.Unlocks.PeterB.MegaSatan.Hard = false
		mod.Unlocks.PeterB.Delirium.Hard = false
		mod.Unlocks.PeterB.Mother.Hard = false
		mod.Unlocks.PeterB.Beast.Hard = false
		mod.Unlocks.PeterB.GreedMode.Hard = false
		mod.Unlocks.PeterB.FullCompletion.Hard = false
		print("Tainted Peter has been reset.")
	end
	if string.lower(cmd) == "unlockpeterb" then
		mod.Unlocks.PeterB.MomsHeart.Unlock = true
		mod.Unlocks.PeterB.Isaac.Unlock = true
		mod.Unlocks.PeterB.Satan.Unlock = true
		mod.Unlocks.PeterB.BlueBaby.Unlock = true
		mod.Unlocks.PeterB.Lamb.Unlock = true
		mod.Unlocks.PeterB.BossRush.Unlock = true
		mod.Unlocks.PeterB.Hush.Unlock = true
		mod.Unlocks.PeterB.MegaSatan.Unlock = true
		mod.Unlocks.PeterB.Delirium.Unlock = true
		mod.Unlocks.PeterB.Mother.Unlock = true
		mod.Unlocks.PeterB.Beast.Unlock = true
		mod.Unlocks.PeterB.GreedMode.Unlock = true
		mod.Unlocks.PeterB.FullCompletion.Unlock = true
		
		mod.Unlocks.PeterB.MomsHeart.Hard = true
		mod.Unlocks.PeterB.Isaac.Hard = true
		mod.Unlocks.PeterB.Satan.Hard = true
		mod.Unlocks.PeterB.BlueBaby.Hard = true
		mod.Unlocks.PeterB.Lamb.Hard = true
		mod.Unlocks.PeterB.BossRush.Hard = true
		mod.Unlocks.PeterB.Hush.Hard = true
		mod.Unlocks.PeterB.MegaSatan.Hard = true
		mod.Unlocks.PeterB.Delirium.Hard = true
		mod.Unlocks.PeterB.Mother.Hard = true
		mod.Unlocks.PeterB.Beast.Hard = true
		mod.Unlocks.PeterB.GreedMode.Hard = true
		mod.Unlocks.PeterB.FullCompletion.Hard = true
		print("All Tainted Peter marks have been unlocked.")
	end
	if string.lower(cmd) == "resetmiriamb" then
		mod.Unlocks.MiriamB.MomsHeart.Unlock = false
		mod.Unlocks.MiriamB.Isaac.Unlock = false
		mod.Unlocks.MiriamB.Satan.Unlock = false
		mod.Unlocks.MiriamB.BlueBaby.Unlock = false
		mod.Unlocks.MiriamB.Lamb.Unlock = false
		mod.Unlocks.MiriamB.BossRush.Unlock = false
		mod.Unlocks.MiriamB.Hush.Unlock = false
		mod.Unlocks.MiriamB.MegaSatan.Unlock = false
		mod.Unlocks.MiriamB.Delirium.Unlock = false
		mod.Unlocks.MiriamB.Mother.Unlock = false
		mod.Unlocks.MiriamB.Beast.Unlock = false
		mod.Unlocks.MiriamB.GreedMode.Unlock = false
		mod.Unlocks.MiriamB.FullCompletion.Unlock = false
		
		mod.Unlocks.MiriamB.MomsHeart.Hard = false
		mod.Unlocks.MiriamB.Isaac.Hard = false
		mod.Unlocks.MiriamB.Satan.Hard = false
		mod.Unlocks.MiriamB.BlueBaby.Hard = false
		mod.Unlocks.MiriamB.Lamb.Hard = false
		mod.Unlocks.MiriamB.BossRush.Hard = false
		mod.Unlocks.MiriamB.Hush.Hard = false
		mod.Unlocks.MiriamB.MegaSatan.Hard = false
		mod.Unlocks.MiriamB.Delirium.Hard = false
		mod.Unlocks.MiriamB.Mother.Hard = false
		mod.Unlocks.MiriamB.Beast.Hard = false
		mod.Unlocks.MiriamB.GreedMode.Hard = false
		mod.Unlocks.MiriamB.FullCompletion.Hard = false
		print("Tainted Miriam has been reset.")
	end
	if string.lower(cmd) == "unlockmiriamb" then
		mod.Unlocks.MiriamB.MomsHeart.Unlock = true
		mod.Unlocks.MiriamB.Isaac.Unlock = true
		mod.Unlocks.MiriamB.Satan.Unlock = true
		mod.Unlocks.MiriamB.BlueBaby.Unlock = true
		mod.Unlocks.MiriamB.Lamb.Unlock = true
		mod.Unlocks.MiriamB.BossRush.Unlock = true
		mod.Unlocks.MiriamB.Hush.Unlock = true
		mod.Unlocks.MiriamB.MegaSatan.Unlock = true
		mod.Unlocks.MiriamB.Delirium.Unlock = true
		mod.Unlocks.MiriamB.Mother.Unlock = true
		mod.Unlocks.MiriamB.Beast.Unlock = true
		mod.Unlocks.MiriamB.GreedMode.Unlock = true
		mod.Unlocks.MiriamB.FullCompletion.Unlock = true
		
		mod.Unlocks.MiriamB.MomsHeart.Hard = true
		mod.Unlocks.MiriamB.Isaac.Hard = true
		mod.Unlocks.MiriamB.Satan.Hard = true
		mod.Unlocks.MiriamB.BlueBaby.Hard = true
		mod.Unlocks.MiriamB.Lamb.Hard = true
		mod.Unlocks.MiriamB.BossRush.Hard = true
		mod.Unlocks.MiriamB.Hush.Hard = true
		mod.Unlocks.MiriamB.MegaSatan.Hard = true
		mod.Unlocks.MiriamB.Delirium.Hard = true
		mod.Unlocks.MiriamB.Mother.Hard = true
		mod.Unlocks.MiriamB.Beast.Hard = true
		mod.Unlocks.MiriamB.GreedMode.Hard = true
		mod.Unlocks.MiriamB.FullCompletion.Hard = true
		print("All Tainted Miriam marks have been unlocked.")
	end
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.ResetUnlocks)