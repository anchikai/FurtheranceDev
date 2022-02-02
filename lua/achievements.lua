local mod = further
local game = Game()
mod.Unlocks = {LeahIsaac = 0, LeahBlueBaby = 0, LeahSatan = 0, LeahLamb = 0, LeahMegaSatan = 0, LeahBossRush = 0, LeahHush = 0, LeahGreed = 0, LeahGreedier = 0, LeahDeli = 0, LeahMother = 0, LeahBeast = 0, LeahAll = 0, LeahBMegaSatan = 0, LeahBGreedier = 0, LeahBDeli = 0, LeahBMother = 0, LeahBBeast = 0}
local json = require("json")

function mod:StartUnlocks()
	if mod:HasData() then
		local unlockedData = json.decode(mod:LoadData())
		mod.Unlocks = json.decode(unlockedData.Unlocks)
		-- Leah
		if mod.Unlocks.LeahIsaac == 0 then
			game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_HOLY_HEART)
		end
		if mod.Unlocks.LeahBlueBaby == 0 then
			
		end
		if mod.Unlocks.LeahSatan == 0 then
			
		end
		if mod.Unlocks.LeahLamb == 0 then
			
		end
		if mod.Unlocks.LeahMegaSatan == 0 then
			
		end
		if mod.Unlocks.LeahBossRush == 0 then
			
		end
		if mod.Unlocks.LeahHush == 0 then
			
		end
		if mod.Unlocks.LeahGreed == 0 then
			
		end
		if mod.Unlocks.LeahGreedier == 0 then
			
		end
		if mod.Unlocks.LeahDeli == 0 then
			
		end
		if mod.Unlocks.LeahMother == 0 then
			
		end
		if mod.Unlocks.LeahBeast == 0 then
			
		end
		if mod.Unlocks.LeahAll == 0 then
			
		end
		
		-- Tainted Leah
		if mod.Unlocks.LeahBMegaSatan == 0 then
			
		end
		if mod.Unlocks.LeahBGreedier == 0 then
			
		end
		if mod.Unlocks.LeahBDeli == 0 then
			game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART)
		end
		if mod.Unlocks.LeahBMother == 0 then
			
		end
		if mod.Unlocks.LeahBBeast == 0 then
			
		end
	else
		-- Leah
		game:GetItemPool():RemoveTrinket(TrinketType.TRINKET_HOLY_HEART)
		
		-- Tainted Leah
		game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_SHATTERED_HEART)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.StartUnlocks)

function mod:update(entity)
	local save = false
	local saveData = {}
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetName() == "Leah" then	-- Leah
			if entity.Type == EntityType.ENTITY_ISAAC then
				mod.Unlocks.LeahIsaac = mod.Unlocks.LeahIsaac + 1
				save = true
				if mod.Unlocks.LeahIsaac == 1 then
				game:GetHUD():ShowFortuneText("Holy Heart", "Has appeared", "in the basement")
				end
			end
		end
		if player:GetName() == "LeahB" then	-- Tainted Leah
			if entity.Type == EntityType.ENTITY_DELIRIUM then
				mod.Unlocks.LeahBDeli = mod.Unlocks.LeahBDeli + 1
				save = true
				if mod.Unlocks.LeahBDeli == 1 then
					game:GetHUD():ShowFortuneText("Shattered Heart", "Has appeared", "in the basement")
				end
			end
		end
	end
	if save then
		saveData.Unlocks = json.encode(mod.Unlocks)
		mod:SaveData(json.encode(saveData))
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_ISAAC)
-- where blue baby?
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_SATAN)
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_THE_LAMB)
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_MEGA_SATAN_2)
-- boss rush later
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_HUSH)
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_ULTRA_GREED)
-- where ultra greedier?
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_DELIRIUM)
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_MOTHER)
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.update, EntityType.ENTITY_BEAST)


function mod:FurtheranceCommands(cmd)
	local save = false
	local saveData = {}
	if cmd == "leahreset" or cmd == "LeahReset" or cmd == "LEAHRESET" then
		mod.Unlocks.LeahIsaac = 0
		mod.Unlocks.LeahBlueBaby = 0
		mod.Unlocks.LeahSatan = 0
		mod.Unlocks.LeahLamb = 0
		mod.Unlocks.LeahMegaSatan = 0
		mod.Unlocks.LeahBossRush = 0
		mod.Unlocks.LeahHush = 0
		mod.Unlocks.LeahGreed = 0
		mod.Unlocks.LeahGreedier = 0
		mod.Unlocks.LeahDeli = 0
		mod.Unlocks.LeahMother = 0
		mod.Unlocks.LeahBeast = 0
		mod.Unlocks.LeahAll = 0
		save = true
		print("Completion mark progress for Leah has been reset.")
	end
	if cmd == "taintedleahreset" or cmd == "TaintedLeahReset" or cmd == "TAINTEDLEAHRESET" then
		mod.Unlocks.LeahBMegaSatan = 0
		mod.Unlocks.LeahBGreedier = 0
		mod.Unlocks.LeahBDeli = 0
		mod.Unlocks.LeahBMother = 0
		mod.Unlocks.LeahBBeast = 0
		save = true
		print("Completion mark progress for Tainted Leah has been reset.")
	end
end

mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.FurtheranceCommands)