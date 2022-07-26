local mod = Furtherance
local game = Game()

function mod:SetGoldenPortData(player)
    local data = mod:GetData(player)
    data.GoldenPortCooldown = 0
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.SetGoldenPortData)

function mod:HasPort(_, _, player, useFlags)
    local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_GOLDEN_PORT) and useFlags == UseFlag.USE_OWNED then
        data.GoldenPortCooldown = 15
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.HasPort)

function mod:UseGoldenPort(player)
    local data = mod:GetData(player)
    local UsedActive = Input.IsActionPressed(ButtonAction.ACTION_ITEM, player.ControllerIndex)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_GOLDEN_PORT) then
        if data.GoldenPortCooldown > 0 then
            data.GoldenPortCooldown = data.GoldenPortCooldown - 1
        end
        if UsedActive and data.GoldenPortCooldown == 0 then
            if player:GetNumCoins() >= 5 and player:NeedsCharge(ActiveSlot.SLOT_PRIMARY) then
                player:SetActiveCharge(player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) + 6, ActiveSlot.SLOT_PRIMARY)
                player:AddCoins(-5)
                game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_PRIMARY)
                if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) < 6 then
                    SFXManager():Play(SoundEffect.SOUND_BEEP)
                else
                    SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
                    SFXManager():Play(SoundEffect.SOUND_ITEMRECHARGE)
                end
            end
        end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.UseGoldenPort)