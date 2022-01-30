local mod = further
local rng = RNG()

function mod:UseAlt(boi, rng, player, slot, data)

	local stage = Game():GetLevel():GetStage()
	local stageType = Game():GetLevel():GetStageType()
	local level = Game():GetLevel()
	
	local randomAB = rng:RandomInt(3)
	local randomREP = rng:RandomInt(2)
	
	player:GetData().NoChargeAlt = true
	
	--if the stage is Blue Womb, Sheol, Cathedral, Dark Room, Chest, The Void, or Home
	if (stage == LevelStage.STAGE4_3) or (stage == LevelStage.STAGE5) or (stage == LevelStage.STAGE6) or (stage == LevelStage.STAGE7) or (stage == LevelStage.STAGE8) then
		mod:playFailSound()
		player:AnimateSad()
	--if alt floor, change to normal floor
	elseif stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW, false, false, true, false, 0)
		player:AnimateCollectible(CollectibleType.COLLECTIBLE_ALT_KEY, "UseItem", "PlayerPickup")
		if randomAB == 1 then
			level:SetStage(stage, (StageType.STAGETYPE_ORIGINAL))
		elseif randomAB == 2 then
			level:SetStage(stage, (StageType.STAGETYPE_WOTL))
		elseif randomAB == 3 then
			level:SetStage(stage, (StageType.STAGETYPE_AFTERBIRTH))
		end
	--if the stage is Womb I or II
	elseif stageType == StageType.STAGETYPE_ORIGINAL or stageType == StageType.STAGETYPE_WOTL or stageType == StageType.STAGETYPE_AFTERBIRTH and (stage == LevelStage.STAGE4_1) or (LevelStage.STAGE4_2) then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW, false, false, true, false, 0)
		player:AnimateCollectible(CollectibleType.COLLECTIBLE_ALT_KEY, "UseItem", "PlayerPickup")
		level:SetStage(stage, (StageType.STAGETYPE_REPENTANCE))
	--if normal floor, change to alt floor
	elseif stageType == StageType.STAGETYPE_ORIGINAL or stageType == StageType.STAGETYPE_WOTL or stageType == StageType.STAGETYPE_AFTERBIRTH then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW, false, false, true, false, 0)
		player:AnimateCollectible(CollectibleType.COLLECTIBLE_ALT_KEY, "UseItem", "PlayerPickup")
		if randomREP == 1 then
			level:SetStage(stage, (StageType.STAGETYPE_REPENTANCE))
		elseif randomREP == 2 then
			level:SetStage(stage, (StageType.STAGETYPE_REPENTANCE_B))
		end
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseAlt, CollectibleType.COLLECTIBLE_ALT_KEY)

function mod:ChargeAlt()
	for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
		if player:GetData().NoChargeAlt == false then
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_ALT_KEY then
				player:FullCharge(ActiveSlot.SLOT_PRIMARY, true)
			elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_ALT_KEY then
				player:FullCharge(ActiveSlot.SLOT_SECONDARY, true)
			end
		end
		player:GetData().NoChargeAlt = false
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ChargeAlt)