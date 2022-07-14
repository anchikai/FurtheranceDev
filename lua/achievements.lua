local mod = Furtherance
local game = Game()

local AchievementGraphics = {
	Leah = {
		MomsHeart = "achievement_secretdiary",
		Isaac = "achievement_bindsofdevotion",
		Satan = "achievement_",
		BlueBaby = "achievement_mandrake",
		Lamb = "achievement_littlesister",
		BossRush = "achievement_leahslock",
		Hush = "achievement_keratoconus",
		MegaSatan = "achievement_d16",
		Delirium = "achievement_heartrenovator",
		Mother = "achievement_owlseye",
		Beast = "achievement_",
		GreedMode = "achievement_holyheart",
		Greedier = "achievement_heartembeddedcoin",
		Tainted = "achievement_taintedleah",
		FullCompletion = "achievement.full_completion",
	},
	LeahB = {
		PolNegPath = "achievement_leahsheart",
		SoulPath = "achievement_soulofleah",
		MegaSatan = "achievement_loveteller",
		Delirium = "achievement_shatteredheart",
		Mother = "achievement_",
		Beast = "achievement_",
		Greedier = "achievement_reversehope",
		FullCompletion = "achievement.full_completion_b",
	},
	Peter = {
		MomsHeart = "achievement_prayerjournal",
		Isaac = "achievement_pallium",
		Satan = "achievement_",
		BlueBaby = "achievement_phirho",
		Lamb = "achievement_",
		BossRush = "achievement_altruism",
		Hush = "achievement_",
		MegaSatan = "achievement_",
		Delirium = "achievement_keystothekingdom",
		Mother = "achievement_",
		Beast = "achievement_",
		GreedMode = "achievement_alabasterscrap",
		Greedier = "achievement_unluckypenny",
		Tainted = "achievement_taintedpeter",
		FullCompletion = "achievement.full_completion",
	},
	PeterB = {
		PolNegPath = "achievement_",
		SoulPath = "achievement_soulofpeter",
		MegaSatan = "achievement_",
		Delirium = "achievement_muddledcross",
		Mother = "achievement_",
		Beast = "achievement_",
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
		Beast = "achievement_polydipsia",
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

function mod:FuckYou(player, flag)
	if (mod.Unlocks.Leah.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_LEAH_B)
	or (mod.Unlocks.Peter.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_PETER_B)
	or (mod.Unlocks.Miriam.Tainted == false and player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B) then
		player.SpriteScale = Vector.Zero
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.FuckYou, CacheFlag.CACHE_SIZE)

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
		end

		-- Leah
		if mod.Unlocks.Leah.MomsHeart == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SECRET_DIARY)
		end
		if mod.Unlocks.Leah.Isaac == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION)
		end
		if mod.Unlocks.Leah.Satan == false then

		end
		if mod.Unlocks.Leah.BlueBaby == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MANDRAKE)
		end
		if mod.Unlocks.Leah.Lamb == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_LITTLE_SISTER)
		end
		if mod.Unlocks.Leah.BossRush == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_LEAHS_LOCK)
		end
		if mod.Unlocks.Leah.Hush == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_KERATOCONUS)
		end
		if mod.Unlocks.Leah.MegaSatan == false then
			
		end
		if mod.Unlocks.Leah.Delirium == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
		end
		if mod.Unlocks.Leah.Mother == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE)
		end
		if mod.Unlocks.Leah.Beast == false then
			
		end
		if mod.Unlocks.Leah.GreedMode == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_HEART_EMBEDDED_COIN)
		end
		if mod.Unlocks.Leah.FullCompletion == false then
			
		end

		-- Tainted Leah
		if mod.Unlocks.LeahB.PolNegPath == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_LEAHS_HEART)
		end
		if mod.Unlocks.LeahB.SoulPath == false then
			
		end
		if mod.Unlocks.LeahB.MegaSatan == false then
			
		end
		if mod.Unlocks.LeahB.Delirium == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART)
		end
		if mod.Unlocks.LeahB.Mother == false then
			
		end
		if mod.Unlocks.LeahB.Beast == false then
			
		end
		if mod.Unlocks.LeahB.GreedMode == false then
			
		end
		if mod.Unlocks.LeahB.FullCompletion == false then
			
		end

		-- Peter
		if mod.Unlocks.Peter.MomsHeart == false then
			--game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PRAYER_JOURNAL)
		end
		if mod.Unlocks.Peter.Isaac == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PALLIUM)
		end
		if mod.Unlocks.Peter.Satan == false then
			
		end
		if mod.Unlocks.Peter.BlueBaby == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_CHI_RHO)
		end
		if mod.Unlocks.Peter.Lamb == false then
			
		end
		if mod.Unlocks.Peter.BossRush == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ALTRUISM)
		end
		if mod.Unlocks.Peter.Hush == false then
			
		end
		if mod.Unlocks.Peter.MegaSatan == false then
			
		end
		if mod.Unlocks.Peter.Delirium == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)
		end
		if mod.Unlocks.Peter.Mother == false then
			
		end
		if mod.Unlocks.Peter.Beast == false then
			
		end
		if mod.Unlocks.Peter.GreedMode == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ALABASTER_SCRAP)
		end
		if mod.Unlocks.Peter.FullCompletion == false then
			
		end

		-- Tainted Peter
		if mod.Unlocks.PeterB.PolNegPath == false then
			
		end
		if mod.Unlocks.PeterB.SoulPath == false then
			
		end
		if mod.Unlocks.PeterB.MegaSatan == false then
			
		end
		if mod.Unlocks.PeterB.Delirium == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MUDDLED_CROSS)
		end
		if mod.Unlocks.PeterB.Mother == false then
			
		end
		if mod.Unlocks.PeterB.Beast == false then
			
		end
		if mod.Unlocks.PeterB.GreedMode == false then
			
		end
		if mod.Unlocks.PeterB.FullCompletion == false then
			
		end

		-- Miriam
		if mod.Unlocks.Miriam.MomsHeart == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_GUIDANCE)
		end
		if mod.Unlocks.Miriam.Isaac == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_APOCALYPSE)
		end
		if mod.Unlocks.Miriam.Satan == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_KARETH)
		end
		if mod.Unlocks.Miriam.BlueBaby == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_CLOUDS)
		end
		if mod.Unlocks.Miriam.Lamb == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PILLAR_OF_FIRE)
		end
		if mod.Unlocks.Miriam.BossRush == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_WORMWOOD_LEAF)
		end
		if mod.Unlocks.Miriam.Hush == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_CADUCEUS_STAFF)
		end
		if mod.Unlocks.Miriam.MegaSatan == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_MIRIAMS_WELL)
		end
		if mod.Unlocks.Miriam.Delirium == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_TAMBOURINE)
		end
		if mod.Unlocks.Miriam.Mother == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_FIRSTBORN_SON)
		end
		if mod.Unlocks.Miriam.Beast == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)
		end
		if mod.Unlocks.Miriam.GreedMode == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_SALINE_SPRAY)
		end
		if mod.Unlocks.Miriam.FullCompletion == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_QUARANTINE)
		end

		-- Tainted Miriam
		if mod.Unlocks.MiriamB.PolNegPath == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ALMAGEST_SCRAP)
		end
		if mod.Unlocks.MiriamB.SoulPath == false then
			
		end
		if mod.Unlocks.MiriamB.MegaSatan == false then
			
		end
		if mod.Unlocks.MiriamB.Delirium == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND)
		end
		if mod.Unlocks.MiriamB.Mother == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ABYSSAL_PENNY)
		end
		if mod.Unlocks.MiriamB.Beast == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_JAR_OF_MANNA)
		end
		if mod.Unlocks.MiriamB.GreedMode == false then
			
		end
		if mod.Unlocks.MiriamB.FullCompletion == false then
			
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.StartUnlocks)


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
		mod.Unlocks.Leah.MomsHeart = false
		mod.Unlocks.Leah.Isaac = false
		mod.Unlocks.Leah.Satan = false
		mod.Unlocks.Leah.BlueBaby = false
		mod.Unlocks.Leah.Lamb = false
		mod.Unlocks.Leah.BossRush = false
		mod.Unlocks.Leah.Hush = false
		mod.Unlocks.Leah.MegaSatan = false
		mod.Unlocks.Leah.Delirium = false
		mod.Unlocks.Leah.Mother = false
		mod.Unlocks.Leah.Beast = false
		mod.Unlocks.Leah.GreedMode = false
		mod.Unlocks.Leah.Tainted = false
		mod.Unlocks.Leah.FullCompletion = false
		print("Leah has been reset.")
	end
	if string.lower(cmd) == "unlockleah" then
		mod.Unlocks.Leah.MomsHeart = true
		mod.Unlocks.Leah.Isaac = true
		mod.Unlocks.Leah.Satan = true
		mod.Unlocks.Leah.BlueBaby = true
		mod.Unlocks.Leah.Lamb = true
		mod.Unlocks.Leah.BossRush = true
		mod.Unlocks.Leah.Hush = true
		mod.Unlocks.Leah.MegaSatan = true
		mod.Unlocks.Leah.Delirium = true
		mod.Unlocks.Leah.Mother = true
		mod.Unlocks.Leah.Beast = true
		mod.Unlocks.Leah.GreedMode = true
		mod.Unlocks.Leah.Tainted = true
		mod.Unlocks.Leah.FullCompletion = true
		print("All Leah marks have been unlocked.")
	end
	if string.lower(cmd) == "resetpeter" then
		mod.Unlocks.Peter.MomsHeart = false
		mod.Unlocks.Peter.Isaac = false
		mod.Unlocks.Peter.Satan = false
		mod.Unlocks.Peter.BlueBaby = false
		mod.Unlocks.Peter.Lamb = false
		mod.Unlocks.Peter.BossRush = false
		mod.Unlocks.Peter.Hush = false
		mod.Unlocks.Peter.MegaSatan = false
		mod.Unlocks.Peter.Delirium = false
		mod.Unlocks.Peter.Mother = false
		mod.Unlocks.Peter.Beast = false
		mod.Unlocks.Peter.GreedMode = false
		mod.Unlocks.Peter.Tainted = false
		mod.Unlocks.Peter.FullCompletion = false
		print("Peter has been reset.")
	end
	if string.lower(cmd) == "unlockpeter" then
		mod.Unlocks.Peter.MomsHeart = true
		mod.Unlocks.Peter.Isaac = true
		mod.Unlocks.Peter.Satan = true
		mod.Unlocks.Peter.BlueBaby = true
		mod.Unlocks.Peter.Lamb = true
		mod.Unlocks.Peter.BossRush = true
		mod.Unlocks.Peter.Hush = true
		mod.Unlocks.Peter.MegaSatan = true
		mod.Unlocks.Peter.Delirium = true
		mod.Unlocks.Peter.Mother = true
		mod.Unlocks.Peter.Beast = true
		mod.Unlocks.Peter.GreedMode = true
		mod.Unlocks.Peter.Tainted = true
		mod.Unlocks.Peter.FullCompletion = true
		print("All Peter marks have been unlocked.")
	end
	if string.lower(cmd) == "resetmiriam" then
		mod.Unlocks.Miriam.MomsHeart = false
		mod.Unlocks.Miriam.Isaac = false
		mod.Unlocks.Miriam.Satan = false
		mod.Unlocks.Miriam.BlueBaby = false
		mod.Unlocks.Miriam.Lamb = false
		mod.Unlocks.Miriam.BossRush = false
		mod.Unlocks.Miriam.Hush = false
		mod.Unlocks.Miriam.MegaSatan = false
		mod.Unlocks.Miriam.Delirium = false
		mod.Unlocks.Miriam.Mother = false
		mod.Unlocks.Miriam.Beast = false
		mod.Unlocks.Miriam.GreedMode = false
		mod.Unlocks.Miriam.Tainted = false
		mod.Unlocks.Miriam.FullCompletion = false
		print("Miriam has been reset.")
	end
	if string.lower(cmd) == "unlockmiriam" then
		mod.Unlocks.Miriam.MomsHeart = true
		mod.Unlocks.Miriam.Isaac = true
		mod.Unlocks.Miriam.Satan = true
		mod.Unlocks.Miriam.BlueBaby = true
		mod.Unlocks.Miriam.Lamb = true
		mod.Unlocks.Miriam.BossRush = true
		mod.Unlocks.Miriam.Hush = true
		mod.Unlocks.Miriam.MegaSatan = true
		mod.Unlocks.Miriam.Delirium = true
		mod.Unlocks.Miriam.Mother = true
		mod.Unlocks.Miriam.Beast = true
		mod.Unlocks.Miriam.GreedMode = true
		mod.Unlocks.Miriam.Tainted = true
		mod.Unlocks.Miriam.FullCompletion = true
		print("All Miriam marks have been unlocked.")
	end

	-- Tainteds
	if string.lower(cmd) == "resetleahb" then
		mod.Unlocks.LeahB.MomsHeart = false
		mod.Unlocks.LeahB.Isaac = false
		mod.Unlocks.LeahB.Satan = false
		mod.Unlocks.LeahB.BlueBaby = false
		mod.Unlocks.LeahB.Lamb = false
		mod.Unlocks.LeahB.BossRush = false
		mod.Unlocks.LeahB.Hush = false
		mod.Unlocks.LeahB.MegaSatan = false
		mod.Unlocks.LeahB.Delirium = false
		mod.Unlocks.LeahB.Mother = false
		mod.Unlocks.LeahB.Beast = false
		mod.Unlocks.LeahB.GreedMode = false
		mod.Unlocks.LeahB.FullCompletion = false
		print("Tainted Leah has been reset.")
	end
	if string.lower(cmd) == "unlockleahb" then
		mod.Unlocks.LeahB.MomsHeart = true
		mod.Unlocks.LeahB.Isaac = true
		mod.Unlocks.LeahB.Satan = true
		mod.Unlocks.LeahB.BlueBaby = true
		mod.Unlocks.LeahB.Lamb = true
		mod.Unlocks.LeahB.BossRush = true
		mod.Unlocks.LeahB.Hush = true
		mod.Unlocks.LeahB.MegaSatan = true
		mod.Unlocks.LeahB.Delirium = true
		mod.Unlocks.LeahB.Mother = true
		mod.Unlocks.LeahB.Beast = true
		mod.Unlocks.LeahB.GreedMode = true
		mod.Unlocks.LeahB.FullCompletion = true
		print("All Tainted Leah marks have been unlocked.")
	end
	if string.lower(cmd) == "resetpeterb" then
		mod.Unlocks.PeterB.MomsHeart = false
		mod.Unlocks.PeterB.Isaac = false
		mod.Unlocks.PeterB.Satan = false
		mod.Unlocks.PeterB.BlueBaby = false
		mod.Unlocks.PeterB.Lamb = false
		mod.Unlocks.PeterB.BossRush = false
		mod.Unlocks.PeterB.Hush = false
		mod.Unlocks.PeterB.MegaSatan = false
		mod.Unlocks.PeterB.Delirium = false
		mod.Unlocks.PeterB.Mother = false
		mod.Unlocks.PeterB.Beast = false
		mod.Unlocks.PeterB.GreedMode = false
		mod.Unlocks.PeterB.FullCompletion = false
		print("Tainted Peter has been reset.")
	end
	if string.lower(cmd) == "unlockpeterb" then
		mod.Unlocks.PeterB.MomsHeart = true
		mod.Unlocks.PeterB.Isaac = true
		mod.Unlocks.PeterB.Satan = true
		mod.Unlocks.PeterB.BlueBaby = true
		mod.Unlocks.PeterB.Lamb = true
		mod.Unlocks.PeterB.BossRush = true
		mod.Unlocks.PeterB.Hush = true
		mod.Unlocks.PeterB.MegaSatan = true
		mod.Unlocks.PeterB.Delirium = true
		mod.Unlocks.PeterB.Mother = true
		mod.Unlocks.PeterB.Beast = true
		mod.Unlocks.PeterB.GreedMode = true
		mod.Unlocks.PeterB.FullCompletion = true
		print("All Tainted Peter marks have been unlocked.")
	end
	if string.lower(cmd) == "resetmiriamb" then
		mod.Unlocks.MiriamB.MomsHeart = false
		mod.Unlocks.MiriamB.Isaac = false
		mod.Unlocks.MiriamB.Satan = false
		mod.Unlocks.MiriamB.BlueBaby = false
		mod.Unlocks.MiriamB.Lamb = false
		mod.Unlocks.MiriamB.BossRush = false
		mod.Unlocks.MiriamB.Hush = false
		mod.Unlocks.MiriamB.MegaSatan = false
		mod.Unlocks.MiriamB.Delirium = false
		mod.Unlocks.MiriamB.Mother = false
		mod.Unlocks.MiriamB.Beast = false
		mod.Unlocks.MiriamB.GreedMode = false
		mod.Unlocks.MiriamB.FullCompletion = false
		print("Tainted Miriam has been reset.")
	end
	if string.lower(cmd) == "unlockmiriamb" then
		mod.Unlocks.MiriamB.MomsHeart = true
		mod.Unlocks.MiriamB.Isaac = true
		mod.Unlocks.MiriamB.Satan = true
		mod.Unlocks.MiriamB.BlueBaby = true
		mod.Unlocks.MiriamB.Lamb = true
		mod.Unlocks.MiriamB.BossRush = true
		mod.Unlocks.MiriamB.Hush = true
		mod.Unlocks.MiriamB.MegaSatan = true
		mod.Unlocks.MiriamB.Delirium = true
		mod.Unlocks.MiriamB.Mother = true
		mod.Unlocks.MiriamB.Beast = true
		mod.Unlocks.MiriamB.GreedMode = true
		mod.Unlocks.MiriamB.FullCompletion = true
		print("All Tainted Miriam marks have been unlocked.")
	end
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.ResetUnlocks)