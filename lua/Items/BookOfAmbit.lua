local mod = Furtherance

function mod:UseBookOfAmbit(_Type, RNG, player)
	local data = mod:GetData(player)
	mod:DoBigbook("gfx/ui/giantbook/Ambit.png", SoundEffect.SOUND_BOOK_PAGE_TURN_12, nil, nil, true)
	data.AmbitPower = data.AmbitPower + 1
    player:AddCacheFlags(CacheFlag.CACHE_RANGE)
	player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
	player:EvaluateItems()
    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBookOfAmbit, CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT)

function mod:OnNewRoom()
	local game = Game()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
        data.AmbitPower = 0
        player:AddCacheFlags(CacheFlag.CACHE_RANGE)
        player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
		player:EvaluateItems()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoom)

function mod:Ambit_CacheEval(player, flag)
	local data = mod:GetData(player)
	if data.AmbitPower == nil then
		data.AmbitPower = 0
	end
	if flag == CacheFlag.CACHE_RANGE then
		player.TearRange = player.TearRange + data.AmbitPower * 200
	end
	if data.AmbitPower > 0 then
		if flag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.Ambit_CacheEval)

function mod:AmbitTear(tear)
	if tear.SpawnerType == EntityType.ENTITY_PLAYER and tear.Parent then
        local player = tear.Parent:ToPlayer()
		local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BOOK_OF_AMBIT) then
			if data.AmbitPower > 0 then
				tear:ChangeVariant(TearVariant.CUPID_BLUE)
			end
		end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.AmbitTear)