local mod = Furtherance
local game = Game()

function mod:UseAlt(_, _, player)
	local stage = game:GetLevel():GetStage()
	local stageType = game:GetLevel():GetStageType()
	local level = game:GetLevel()
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ALT_KEY)
	local randomAB = rng:RandomInt(3)
	local randomREP = rng:RandomInt(2)
	local data = mod:GetData(player)
	data.NoChargeAlt = true

	--if the stage is Blue Womb, Sheol, Cathedral, Dark Room, Chest, The Void, or Home
	if (stage == LevelStage.STAGE4_3) or (stage == LevelStage.STAGE5) or (stage == LevelStage.STAGE6) or (stage == LevelStage.STAGE7) or (stage == LevelStage.STAGE8) then
		mod:playFailSound()
		player:AnimateSad()
		return false
	--if alt floor, change to normal floor
	elseif stageType == StageType.STAGETYPE_REPENTANCE or stageType == StageType.STAGETYPE_REPENTANCE_B then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW, false, false, true, false, 0)
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
		level:SetStage(stage, (StageType.STAGETYPE_REPENTANCE))
	--if normal floor, change to alt floor
	elseif stageType == StageType.STAGETYPE_ORIGINAL or stageType == StageType.STAGETYPE_WOTL or stageType == StageType.STAGETYPE_AFTERBIRTH then
		player:UseActiveItem(CollectibleType.COLLECTIBLE_FORGET_ME_NOW, false, false, true, false, 0)
		if randomREP == 1 then
			level:SetStage(stage, (StageType.STAGETYPE_REPENTANCE))
		elseif randomREP == 2 then
			level:SetStage(stage, (StageType.STAGETYPE_REPENTANCE_B))
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseAlt, CollectibleType.COLLECTIBLE_ALT_KEY)

function mod:ChargeAlt()
	for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if data.NoChargeAlt == false then
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_ALT_KEY then
				AltSlot = ActiveSlot.SLOT_PRIMARY
			elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_ALT_KEY then
				AltSlot = ActiveSlot.SLOT_SECONDARY
			end
			if player:GetActiveCharge(AltSlot) < 2 then
				player:SetActiveCharge(player:GetActiveCharge(AltSlot)+1, AltSlot)
			end
			game:GetHUD():FlashChargeBar(player, AltSlot)
			if player:GetActiveCharge(AltSlot) < 2 then
				SFXManager():Play(SoundEffect.SOUND_BEEP)
			else
				SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
				SFXManager():Play(SoundEffect.SOUND_ITEMRECHARGE)
			end
		end
		data.NoChargeAlt = false
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ChargeAlt)