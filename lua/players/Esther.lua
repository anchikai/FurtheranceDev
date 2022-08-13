local mod = Furtherance
local game = Game()

COSTUME_ESTHER_A_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_004_Esther_Hair.anm2")
COSTUME_ESTHER_B_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_004b_Esther_Hair.anm2")

function mod:OnInit(player)
	if mod.IsContinued then return end

	local data = mod:GetData(player)
	data.Init = true

	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then -- If the player is Esther it will apply her hair
		player:AddNullCostume(COSTUME_ESTHER_A_HAIR)
	elseif player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B then -- Apply different hair for her tainted variant
		player:AddNullCostume(COSTUME_ESTHER_B_HAIR)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:GiveEstherItems(player)
	local data = mod:GetData(player)
	if not data.Init then return end

	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		if player.FrameCount == 1 and not mod.IsContinued then
			
		elseif player.FrameCount > 1 then
			data.Init = nil
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B then
		if player.FrameCount == 1 and not mod.IsContinued then
			
		elseif player.FrameCount > 1 then
			data.Init = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.GivePeterItems)

function mod:EstherStats(player, flag)
	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		
	elseif player:GetPlayerType() == PlayerType.PLAYER_PETER_B then
		
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EstherStats)

function mod:ClickerFix(_, _, player)
	player:TryRemoveNullCostume(COSTUME_ESTHER_A_HAIR)
	player:TryRemoveNullCostume(COSTUME_ESTHER_B_HAIR)
	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		player:AddNullCostume(COSTUME_ESTHER_A_HAIR)
	elseif player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B then
		player:AddNullCostume(COSTUME_ESTHER_B_HAIR)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_CLICKER)


function mod:TaintedEstherHome()
	local level = game:GetLevel()
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == PlayerType.PLAYER_ESTHER and level:GetCurrentRoomIndex() == 94 and level:GetStage() == LevelStage.STAGE8 and mod.Unlocks.Esther.Tainted ~= true then
			local RememberPocket = player:GetActiveCharge(ActiveSlot.SLOT_POCKET)
			for _, entity in ipairs(Isaac.GetRoomEntities()) do
				if (((entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE)
				or (entity.Type == EntityType.ENTITY_SHOPKEEPER)) and room:IsFirstVisit())
				or (entity.Type == EntityType.ENTITY_SLOT and entity.Variant == 14) then
					entity:Remove()
					player:ChangePlayerType(PlayerType.PLAYER_ESTHER_B)
					Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, entity.Position, Vector.Zero, nil)
					player:ChangePlayerType(PlayerType.PLAYER_ESTHER)
					-- player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_, ActiveSlot.SLOT_POCKET, false)
					player:SetActiveCharge(RememberPocket, ActiveSlot.SLOT_POCKET)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.TaintedEstherHome)

function mod:UnlockTaintedEsther(player)
	if player:GetPlayerType() ~= PlayerType.PLAYER_ESTHER or mod.Unlocks.Esther.Tainted then return end

	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, 14)) do
		local sprite = entity:GetSprite()
		if sprite:IsFinished("PayPrize") then
			mod.Unlocks.Esther.Tainted = true
			GiantBookAPI.ShowAchievement("achievement_taintedesther.png")
			for _, poof in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.POOF01)) do
				poof:Remove()
			end
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.UnlockTaintedEsther)