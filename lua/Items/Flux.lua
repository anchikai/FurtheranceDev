local mod = Furtherance
local game = Game()

function mod:FluxTears(tear)
	local player = tear.SpawnerEntity:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then
        if tear.SubType ~= 1 and tear.FrameCount == 1 then
            FluxTear = player:FireTear(player.Position, player.Velocity, true, false, true, player, 1)
            FluxTear.SubType = 1
            FluxTear.Color = Color(0.75, 0, 0, 1, 0.25, 0, 0)
        end
        tear.Velocity = player.Velocity * (2 + player.ShotSpeed)
        FluxTear.Velocity = -player.Velocity * (2 + player.ShotSpeed)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.FluxTears)

function mod:FluxRange(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then
		if flag == CacheFlag.CACHE_RANGE then
            player.TearRange = player.TearRange + 260
        end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.FluxRange)