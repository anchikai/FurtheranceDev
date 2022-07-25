local mod = Furtherance

function mod:UsePrayerJournal(_, _, player)
	local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PRAYER_JOURNAL)
    if rng:RandomFloat() <= 0.1 then
        player:AddBrokenHearts(1)
    else
        if rng:RandomFloat() <= 0.5 then
            player:AddBlackHearts(2)
        else
            player:AddSoulHearts(2)
        end
    end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UsePrayerJournal, CollectibleType.COLLECTIBLE_PRAYER_JOURNAL)