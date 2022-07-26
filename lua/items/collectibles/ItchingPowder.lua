local mod = Furtherance

function mod:SetItchingPowderData(player)
    local data = mod:GetData(player)
    data.ItchCountdown = -1
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.SetItchingPowderData)

function mod:DoubleHit(entity, amount, flag)
	local player = entity:ToPlayer()
    local data = mod:GetData(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_ITCHING_POWDER) then
        if flag & DamageFlag.DAMAGE_FAKE ~= DamageFlag.DAMAGE_FAKE then
            data.ItchCountdown = 30
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.DoubleHit, EntityType.ENTITY_PLAYER)

function mod:ItchTimer(player)
    local data = mod:GetData(player)
    if data.ItchCountdown == nil then
        data.ItchCountdown = -1
    end

    if data.ItchCountdown > -1 then
        data.ItchCountdown = data.ItchCountdown - 1
    end
    if data.ItchCountdown == 0 then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_DULL_RAZOR, false, false, true, false, -1)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ItchTimer)