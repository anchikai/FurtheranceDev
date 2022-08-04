local mod = Furtherance

function mod:Invulnerability(entity)
    local player = entity:ToPlayer()
    local data = mod:GetData(player)
    if data.PickedUpRedHPCardio == nil then
        data.PickedUpRedHPCardio = 0
    end

    if data.PickedUpRedHPCardio > 0 then
        return false
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.Invulnerability, EntityType.ENTITY_PLAYER)

function mod:CollectHeart(pickup, collider)
	if collider.Type == EntityType.ENTITY_PLAYER then
        local player = collider:ToPlayer()
        local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_CARDIOMYOPATHY) and player:CanPickRedHearts()
        and (pickup.SubType <= HeartSubType.HEART_HALF or pickup.SubType == HeartSubType.HEART_DOUBLEPACK or pickup.SubType == HeartSubType.HEART_SCARED)  then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_CARDIOMYOPATHY)
            if rng:RandomFloat() <= player.Luck/100 then
                player:AddMaxHearts(2)
            else
			    data.PickedUpRedHPCardio = 15
            end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.CollectHeart, PickupVariant.PICKUP_HEART)

function mod:UpdateHP(player)
    local data = mod:GetData(player)
    if data.PickedUpRedHPCardio == nil then
        data.PickedUpRedHPCardio = 0
    elseif data.PickedUpRedHPCardio > 0 then
        data.PickedUpRedHPCardio = data.PickedUpRedHPCardio - 1
    end
    if player:HasCollectible(CollectibleType.COLLECTIBLE_CARDIOMYOPATHY) and player:GetBoneHearts() > 0 then
        player:AddMaxHearts(player:GetBoneHearts()*2, true)
        player:AddBoneHearts(-player:GetBoneHearts())
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.UpdateHP)