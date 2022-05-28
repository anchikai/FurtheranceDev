local mod = Furtherance
local game = Game()

local AchievementGraphics = {
	Leah = {
		MomsHeart = "achievement_",
		Isaac = "achievement_bindsofdevotion",
		Satan = "achievement_parasiticpoofer",
		BlueBaby = "achievement_mandrake",
		Lamb = "achievement_littlesister",
		BossRush = "achievement_leahslock",
		Hush = "achievement_",
		MegaSatan = "achievement_",
		Delirium = "achievement_heartrenovator",
		Mother = "achievement_",
		Beast = "achievement_",
		GreedMode = "achievement_",
		Greedier = "achievement_heartembeddedcoin",
		Tainted = "achievement_taintedleah",
		FullCompletion = "achievement.full_completion",
	},
	LeahB = {
		PolNegPath = "achievement_leahsheart",
		SoulPath = "achievement_soulofleah",
		MegaSatan = "achievement_",
		Delirium = "achievement_shatteredheart",
		Mother = "achievement_",
		Beast = "achievement_",
		Greedier = "achievement_",
		FullCompletion = "achievement.full_completion_b",
	},
	Peter = {
		MomsHeart = "achievement_",
		Isaac = "achievement_",
		Satan = "achievement_",
		BlueBaby = "achievement_",
		Lamb = "achievement_",
		BossRush = "achievement_",
		Hush = "achievement_alabasterscrap",
		MegaSatan = "achievement_",
		Delirium = "achievement_keystothekingdom",
		Mother = "achievement_",
		Beast = "achievement_",
		GreedMode = "achievement_",
		Greedier = "achievement_",
		Tainted = "achievement_taintedpeter",
		FullCompletion = "achievement.full_completion",
	},
	PeterB = {
		PolNegPath = "achievement_",
		SoulPath = "achievement_soulofpeter",
		MegaSatan = "achievement_",
		Delirium = "achievement_",
		Mother = "achievement_",
		Beast = "achievement_",
		Greedier = "achievement_",
		FullCompletion = "achievement.full_completion_b",
	},
	Miriam = {
		MomsHeart = "achievement_mosesbaby",
		Isaac = "achievement_bookofguidance",
		Satan = "achievement_kareth",
		BlueBaby = "achievement_pillarofclouds",
		Lamb = "achievement_pillaroffire",
		BossRush = "achievement_wormwoodleaf",
		Hush = "achievement_caduceusstaff",
		MegaSatan = "achievement_aaronbaby",
		Delirium = "achievement_tambourine",
		Mother = "achievement_firstbornson",
		Beast = "achievement_polydipsia",
		GreedMode = "achievement_salinespray",
		Greedier = "achievement_thedreidel",
		Tainted = "achievement_taintedmiriam",
		FullCompletion = "achievement.full_completion",
	},
	MiriamB = {
		PolNegPath = "achievement_almagestscrap",
		SoulPath = "achievement_soulofmiriam",
		MegaSatan = "achievement_spiritualheartfragment",
		Delirium = "achievement_spiritualwound",
		Mother = "achievement_infestedpenny",
		Beast = "achievement_jarofmanna",
		Greedier = "achievement_twoaceofshields",
		FullCompletion = "achievement.full_completion_b",
	},
}

mod.Unlocks = {
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

local function PlayAchievement(achivement)
	if GiantBookAPI then
		GiantBookAPI.ShowAchievement(achivement .. ".png")
	end
end

local function GetPlayerAchievements(player)
	local ptype = player:GetPlayerType()
	local name = player:GetName()
	local isTainted = nil
	if ptype == LeahA or ptype == PeterA or ptype == MiriamA then
		isTainted = false
	elseif ptype == LeahB or ptype == PeterB or ptype == MiriamB then
		isTainted = true
	end
	if isTainted ~= nil then
		return {name,isTainted}
	else
		return nil
	end
end

function mod:StartUnlocks()
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		local data = mod:GetData(player)
		-- Leah
		if mod.Unlocks.Leah.MomsHeart == false then
			
		end
		if mod.Unlocks.Leah.Isaac == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION)
		end
		if mod.Unlocks.Leah.Satan == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_PARASITIC_POOFER)
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
			
		end
		if mod.Unlocks.Leah.MegaSatan == false then
			
		end
		if mod.Unlocks.Leah.Delirium == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
		end
		if mod.Unlocks.Leah.Mother == false then
			
		end
		if mod.Unlocks.Leah.Beast == false then
			
		end
		if mod.Unlocks.Leah.GreedMode == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_HEART_EMBEDDED_COIN)
		end
		if mod.Unlocks.Leah.Tainted == false and player:GetPlayerType() == LeahB then
			player:ChangePlayerType(LeahA)
			player:TryRemoveNullCostume(COSTUME_LEAH_B_HAIR)
			player:AddNullCostume(COSTUME_LEAH_A_HAIR)
			player:AddBrokenHearts(-10)
			player:AddMaxHearts(4)
			player:AddHearts(4)
			player:AddSoulHearts(-2)
		end
		if mod.Unlocks.Leah.FullCompletion == false then
			
		end

		-- Tainted Leah
		if mod.Unlocks.LeahB.PolNegPath == false then
			--game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_LEAHS_HEART)
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
			
		end
		if mod.Unlocks.Peter.Isaac == false then
			
		end
		if mod.Unlocks.Peter.Satan == false then
			
		end
		if mod.Unlocks.Peter.BlueBaby == false then
			
		end
		if mod.Unlocks.Peter.Lamb == false then
			
		end
		if mod.Unlocks.Peter.BossRush == false then
			
		end
		if mod.Unlocks.Peter.Hush == false then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_ALABASTER_SCRAP)
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
			
		end
		if mod.Unlocks.Peter.Tainted == false and player:GetPlayerType() == PeterB then
			player:ChangePlayerType(PeterA)
			player:TryRemoveNullCostume(COSTUME_PETER_B_DRIP)
			player:AddNullCostume(COSTUME_PETER_A_DRIP)
			player:AddMaxHearts(-2)
			player:AddSoulHearts(2)
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
			
		end
		if mod.Unlocks.Miriam.Isaac == false then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_GUIDANCE)
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
		if mod.Unlocks.Miriam.Tainted == false and player:GetPlayerType() == MiriamB then
			player:ChangePlayerType(MiriamA)
			data.MiriamTearCount = 0
			data.MiriamRiftTimeout = 0
			data.MiriamAOE = 1
			player:TryRemoveNullCostume(COSTUME_MIRIAM_B_HAIR)
			player:AddNullCostume(COSTUME_MIRIAM_A_HAIR)
			player:AddBrokenHearts(-4)
			player:AddSoulHearts(4)
			player:AddBoneHearts(-2)
			player:AddMaxHearts(4)
			player:AddHearts(4)
		end
		if mod.Unlocks.Miriam.FullCompletion == false then
			
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
				
				if AchievementGraphics.Leah[name] then
					PlayAchievement(AchievementGraphics[playerName][name])
					CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.Leah[name] .. ".png")
				end
			end
			if difficulty == Difficulty.DIFFICULTY_HARD then
				TargetTab[name].Hard = true
			elseif difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if TargetTab[name].Hard == false then
					TargetTab[name].Hard = true
					PlayAchievement(AchievementGraphics[playerName].Greedier)
					--CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.Edith.Greedier .. ".png")
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
					--CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. enums.AchievementGraphics.PlayerJob.FullCompletion .. ".png")]]
				
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
					--CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.EdithB[name] .. ".png")
				end
			end
			if difficulty == Difficulty.DIFFICULTY_HARD then
				TargetTab[name].Hard = true
			elseif difficulty == Difficulty.DIFFICULTY_GREEDIER then
				if TargetTab[name].Hard == false then
					TargetTab[name].Hard = true
					PlayAchievement(AchievementGraphics[playerName].Greedier)
					--CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.EdithB.Greedier .. ".png")
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
				--CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.EdithB.PolNegPath .. ".png")
			end
			
			if TargetTab.SoulPath == false
			and TargetTab.BossRush.Unlock == true
			and TargetTab.Hush.Unlock == true
			then
				TargetTab.SoulPath = true
				PlayAchievement(AchievementGraphics[playerName].SoulPath)
				--CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.EdithB.SoulPath .. ".png")
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
					--[[CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.EdithB.FullCompletion .. ".png")]]
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
			mod:OnSave(false)
		elseif roomType == RoomType.ROOM_BOSSRUSH then
			UnlockFunctions.BossRush(room, stageType, difficulty, desc)
			mod:OnSave(false)
		elseif levelStage == LevelStage.STAGE8 and roomType == RoomType.ROOM_DUNGEON then
			UnlockFunctions.Beast(room, stageType, difficulty, desc)
			mod:OnSave(false)
		end
	else
		if levelStage == LevelStage.STAGE7_GREED
		and roomType == RoomType.ROOM_BOSS
		and desc.SafeGridIndex == 45
		then
			UnlockFunctions.Greed(room, nil, difficulty, desc)
			mod:OnSave(false)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.postUpdateAchievements)