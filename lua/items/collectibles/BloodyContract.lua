local mod = Furtherance
local game = Game()

function mod:UseBloodyContract(_, _, player)
    local data = mod:GetData(player)
	data.BloodyContractDMG = 2
    data.BloodyContractTears = 0.5
    data.UsedBloodyContract = true
    player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
    player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
    player:AddCacheFlags(CacheFlag.CACHE_SHOTSPEED)
    player:EvaluateItems()
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseBloodyContract, CollectibleType.COLLECTIBLE_BLOODY_CONTRACT)

function mod:GetBloodyContract(player, flag)
    local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BLOODY_CONTRACT) then
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + data.BloodyContractDMG
		end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay * data.BloodyContractTears
		end
		if flag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + data.BloodyContractDMG
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetBloodyContract)

function mod:BloodyContractGettingTrolledAndDeactivatedByEnteringANewRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        data.BloodyContractDMG = 0
        data.BloodyContractTears = 1
        data.UsedBloodyContract = false
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
        player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
        player:AddCacheFlags(CacheFlag.CACHE_SHOTSPEED)
        player:EvaluateItems()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.BloodyContractGettingTrolledAndDeactivatedByEnteringANewRoom)