local mod = Furtherance

function mod:UseHeartRen(_, _, player)
	if player:GetBrokenHearts() > 0 then
		SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_CAR_BATTERY) then
			player:AddBrokenHearts(-2)
		else
			player:AddBrokenHearts(-1)
		end
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseHeartRen, CollectibleType.COLLECTIBLE_SHATTERED_HEART)