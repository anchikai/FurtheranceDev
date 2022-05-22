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