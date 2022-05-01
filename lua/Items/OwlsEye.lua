local mod = Furtherance
local rng = RNG()

function mod:OwlTear(tear)
	if tear.SpawnerType == EntityType.ENTITY_PLAYER and tear.Parent then
        local player = tear.Parent:ToPlayer()
		local data = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE) then
			local rollOwl = rng:RandomInt(100)+1
			if data.OwlShot == true then
				tear:ChangeVariant(TearVariant.CUPID_BLUE)
			end
			if rollOwl <= (player.Luck*8+8) then
				data.OwlShot = true
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
				player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
				player:EvaluateItems()
			elseif rollOwl > player.Luck then
				data.OwlShot = false
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
				player:AddCacheFlags(CacheFlag.CACHE_TEARFLAG)
				player:EvaluateItems()
			end
		end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.OwlTear)

function mod:OwlFlags(player, flag)
	local data = mod:GetData(player)
	if data.OwlShot == true and player:HasCollectible(CollectibleType.COLLECTIBLE_OWLS_EYE) then
		if flag == CacheFlag.CACHE_TEARFLAG then
			player.TearFlags = player.TearFlags | TearFlags.TEAR_PIERCING | TearFlags.TEAR_HOMING
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 2
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.OwlFlags)

function mod:InitOwl(player)
	local data = mod:GetData(player)
	if data.OwlShot == nil or data.OwlShot == true then
		data.OwlShot = false
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.InitOwl)