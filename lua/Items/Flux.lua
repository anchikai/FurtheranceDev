local mod = Furtherance
local game = Game()

function mod:FluxTears(tear)
    local player = tear.SpawnerEntity:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then
        local tearData = mod:GetData(tear)
        if tear.SubType == 0 and tear.FrameCount == 1 then
            local fluxTear = player:FireTear(player.Position, Vector.Zero, true, false, true, player, 1)
            tear.Velocity = Vector.Zero
            tear.SubType = 1
            fluxTear.SubType = 2
            fluxTear.Color = Color(0.75, 0, 0, 1, 0.25, 0, 0)

            tearData.OriginalPosition = player.Position
            tearData.Flux = fluxTear
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.FluxTears)

function mod:RenderFluxTears(tear)
    local player = tear.SpawnerEntity:ToPlayer()

    local tearData = mod:GetData(tear)

    if tear.SubType ~= 1 then return end

    local offset = (player.Position - tearData.OriginalPosition) * 1.2

    tear.Velocity = player.Velocity * 1.2
    tearData.Flux.Velocity = -player.Velocity * 1.2
    tear.Position = tearData.OriginalPosition + offset
    tearData.Flux.Position = tearData.OriginalPosition - offset
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_RENDER, mod.RenderFluxTears)

function mod:FluxRange(player, flag)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then
        if flag == CacheFlag.CACHE_RANGE then
            player.TearRange = player.TearRange + 260
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.FluxRange)
