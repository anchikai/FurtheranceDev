local mod = Furtherance
local game = Game()
local rng = RNG()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

function mod:UseSoulOfLeah(card, player, useflags)
	local data = mod:GetData(player)
	local solRNG = rng:RandomInt(5)+1
	player:AddBrokenHearts(solRNG)
	SFXManager():Play(bhb)
	if player.MaxFireDelay > 5 then
		if rng:RandomInt(2) == 0 then
			data.solDMG = data.solDMG + solRNG
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		else
			data.solTR = data.solTR + solRNG
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
		end
	else
		data.solDMG = data.solDMG + solRNG
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
	end
	player:EvaluateItems()
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulOfLeah, RUNE_SOUL_OF_LEAH)

function mod:solStats(player, flag)
	local data = mod:GetData(player)
	if data.solDMG == nil or data.solTR == nil then
		data.solDMG = 0
		data.solTR = 0
	end
	if flag == CacheFlag.CACHE_FIREDELAY then
		player.MaxFireDelay = player.MaxFireDelay - (data.solTR * 0.9)
	end
	if flag == CacheFlag.CACHE_DAMAGE then
		player.Damage = player.Damage + data.solDMG
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.solStats)