local mod = further
local game = Game()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

function mod:UseShattered(_, _, player)
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR, "UseItem", "PlayerPickup")
	if player:GetBrokenHearts() > 0 then
		local data = mod:GetData(player)
		SFXManager():Play(SoundEffect.SOUND_HEARTBEAT)
		player:AddBrokenHearts(-1)
		local shRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_HEART_RENOVATOR)
		if player.MaxFireDelay > 1 then
			if shRNG:RandomInt(2) == 0 then
				data.shD = data.shD + 1
				player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			else
				data.shT = data.shT + 1
				player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			end
			player:EvaluateItems()
		else
			data.shD = data.shD + 1
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:EvaluateItems()
		end
	end
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseShattered, CollectibleType.COLLECTIBLE_HEART_RENOVATOR)

function mod:NewRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		local room = game:GetRoom()
		if room:HasCurseMist() == false and room:IsFirstVisit() and player:HasCollectible(CollectibleType.COLLECTIBLE_HEART_RENOVATOR) then
			if game:GetFrameCount() > 0 then
				SFXManager():Play(bhb)
			end
			player:AddBrokenHearts(1)
		end
		data.shD = 0
		data.shT = 0
		player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.NewRoom)

function mod:DMGorTears(player, flag)
	local data = mod:GetData(player)
	if data.shD == nil or data.shT == nil then
		data.shD = 0
		data.shT = 0
	end
	if flag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage + data.shD * 0.5
	end
	if flag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
		player.MaxFireDelay = player.MaxFireDelay - (data.shT * 0.8)
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.DMGorTears)