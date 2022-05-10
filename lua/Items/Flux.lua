local mod = Furtherance
local game = Game()

function mod:FluxTears(tear)
    local player = tear.SpawnerEntity:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then
        if tear.SubType == 0 and tear.FrameCount == 1 then
            local fluxTear = player:FireTear(player.Position, -tear.Velocity, true, false, true, player, 1)
            tear.SubType = 1
            fluxTear.SubType = 2
            fluxTear.Color = Color(0.75, 0, 0, 1, 0.25, 0, 0)
        end
    end

    if tear.SubType == 1 then
        tear.Velocity = player.Velocity * (2 + player.ShotSpeed)
    elseif tear.SubType == 2 then
        tear.Velocity = player.Velocity * (2 - player.ShotSpeed)
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
