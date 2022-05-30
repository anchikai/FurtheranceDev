local mod = Furtherance

function mod:UseBookOfAmbit(_Type, RNG, player)
	mod:DoBigbook("gfx/ui/giantbook/Ambit.png", SoundEffect.SOUND_BOOK_PAGE_TURN_12, nil, nil, true)
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBookOfAmbit, CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT)

function mod:Ambit_CacheEval(player, flag)
	local tempEffects = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT)
	if tempEffects > 0 then
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange + tempEffects * 200
		end
		if flag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + tempEffects * 1.5
		end
		if flag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Ambit_CacheEval)

function mod:Ambit_InitTear(tear)
	local player = mod:GetPlayerFromTear(tear)
	if player then
		if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT) > 0 then
			tear:ChangeVariant(TearVariant.CUPID_BLUE)
		end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.Ambit_InitTear)