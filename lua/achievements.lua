local mod = Furtherance

local game = Game()

local normalLeah = Isaac.GetPlayerTypeByName("Leah", false)
local taintedLeah = Isaac.GetPlayerTypeByName("LeahB", true)
local normalPeter = Isaac.GetPlayerTypeByName("Peter", false)
local taintedPeter = Isaac.GetPlayerTypeByName("PeterB", true)
local normalMiriam = Isaac.GetPlayerTypeByName("Miriam", false)
local taintedMiriam = Isaac.GetPlayerTypeByName("MiriamB", true)

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
	if ptype == normalLeah or ptype == normalPeter or ptype == normalMiriam then
		isTainted = false
	elseif ptype == taintedLeah or ptype == taintedPeter or ptype == taintedMiriam then
		isTainted = true
	end
	if isTainted ~= nil then
		return {name,isTainted}
	else
		return nil
	end
end

function mod:StartUnlocks()
	-- Character
	--if mod.Unlocks.Character.Achivement == false then
	--	game:GetItemPool():RemoveCollectible(collectible)
	--end
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
				
				--if AchievementGraphics[playerName][name] then
					PlayAchievement(AchievementGraphics[playerName][name])
					--CCO.AchievementDisplayAPI.PlayAchievement("gfx/ui/achievements/" .. AchievementGraphics.Edith[name] .. ".png")
				--end
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