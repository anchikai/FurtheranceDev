local mod = Furtherance

function mod:GetHollowHorn(player, flag)
	if player:HasTrinket(TrinketType.TRINKET_HOLLOW_HORN) then
        local goldenbox = player:GetTrinketMultiplier(TrinketType.TRINKET_HOLLOW_HORN)
		player.Damage = player.Damage * (1.2^goldenbox)
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetHollowHorn, CacheFlag.CACHE_DAMAGE)