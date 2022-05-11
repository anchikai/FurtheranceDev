local mod = Furtherance

---@param tear EntityTear
function mod:AddFluxTears(tear)
    local data = mod:GetData(tear)

    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then return end

    if tear.FrameCount ~= 1 or not data.FiredByPlayer or data.AppliedTearFlags.Flux then return end

    data.AppliedTearFlags.Flux = 1

    local extraTear = player:FireTear(tear.Position, -tear.Velocity, true, false, true, player, 1)
    extraTear.Color = Color(0.1, 0.5, 0.75, 0.75, 0, 0, 0.25)

    local extraData = mod:GetData(extraTear)
    extraData.AppliedTearFlags.PharaohCat = data.AppliedTearFlags.PharaohCat
    extraData.AppliedTearFlags.Flux = 2
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.AddFluxTears)

function mod:FluxTears(tear)
    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then return end

    local data = mod:GetData(tear)
    if data.AppliedTearFlags.Flux == 1 then
        tear.Velocity = player.Velocity * (2 + player.ShotSpeed * 1.25)
    elseif data.AppliedTearFlags.Flux == 2 then
        tear.Velocity = player.Velocity * (2 + -player.ShotSpeed * 1.25)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.FluxTears)

---@param tear EntityTear
function mod:AddFiredByPlayerField(tear)
    local data = mod:GetData(tear)
    data.FiredByPlayer = true
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.AddFiredByPlayerField)

function mod:TearInit(tear)
    local data = mod:GetData(tear)
    if data.AppliedTearFlags == nil then
        data.AppliedTearFlags = {}
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.TearInit)

function mod:FluxFlags(player, flag)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_FLUX) then
        if flag == CacheFlag.CACHE_TEARFLAG then
            player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL
        end
        if flag == CacheFlag.CACHE_RANGE then
            player.TearRange = player.TearRange + 390
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.FluxFlags)
