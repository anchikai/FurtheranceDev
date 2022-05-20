local mod = Furtherance
local game = Game()

local FamiliarVariantPolaris = Isaac.GetEntityVariantByName("Polaris")

local ColorEnum = {
    RED = 1,
    ORANGE = 2,
    YELLOW = 3,
    WHITE = 4,
    BLUE = 5
}

local BuffWeights = {
    { Weight = 50, ColorEnum = ColorEnum.RED, Color = Color(1, 0, 0, 1, 0, 0, 0) },
    { Weight = 33, ColorEnum = ColorEnum.ORANGE, Color = Color(1, 0.5, 0, 1, 0, 0, 0) },
    { Weight = 45, ColorEnum = ColorEnum.YELLOW, Color = Color(1, 0.8, 0, 1, 0, 0, 0) },
    { Weight = 26, ColorEnum = ColorEnum.WHITE, Color = Color(1, 1, 1, 1, 0.5, 0.5, 0.5) },
    { Weight = 5, ColorEnum = ColorEnum.BLUE, Color = Color(0, 0, 1, 1, 0, 0, 0) }
}

local TotalBuffWeight = 0
for _, buff in ipairs(BuffWeights) do
    TotalBuffWeight = TotalBuffWeight + buff.Weight
end

local function pickColorBuff(player)
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_POLARIS)
    local buffChoice = rng:RandomFloat() * TotalBuffWeight
    local chosenBuff
    for _, buff in ipairs(BuffWeights) do
        buffChoice = buffChoice - buff.Weight
        if buffChoice <= 0 then
            chosenBuff = buff
            break
        end
    end
    return chosenBuff
end

local function updatePolarisBuffForPlayer(player)
    local data = mod:GetData(player)

    -- handling old state
    if data.PolarisBuff ~= nil then
        if data.PolarisBuff.ColorEnum == ColorEnum.YELLOW then
            player:AddMaxHearts(-1, false)
        end
    end
    data.PolarisBuff = pickColorBuff(player)
    -- handling new state
    if data.PolarisBuff.ColorEnum == ColorEnum.YELLOW then
        player:AddMaxHearts(1, false)
        player:AddHearts(1)
    end
end

function mod:UpdatePolarisBuffs()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_POLARIS) then
            updatePolarisBuffForPlayer(player)
            player:AddCacheFlags(CacheFlag.CACHE_ALL)
            player:EvaluateItems()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.UpdatePolarisBuffs)

function mod:AddPlayerBuffs(player, flag)
    if flag == CacheFlag.CACHE_FAMILIARS then
        player:CheckFamiliar(FamiliarVariantPolaris, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_POLARIS, false), player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_POLARIS), Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_POLARIS), 0)
    end
    local data = mod:GetData(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_POLARIS) then
        if data.PolarisBuff == nil then
            updatePolarisBuffForPlayer(player)
        end
        local colorEnum = data.PolarisBuff.ColorEnum
        if colorEnum == ColorEnum.RED then
            if flag == CacheFlag.CACHE_SHOTSPEED then
                player.ShotSpeed = player.ShotSpeed + 2
            end
        elseif colorEnum == ColorEnum.ORANGE then
            if flag == CacheFlag.CACHE_SHOTSPEED then
                player.ShotSpeed = player.ShotSpeed + 1.5
            elseif flag == CacheFlag.CACHE_DAMAGE then
                player.Damage = player.Damage + 0.5
            end
        elseif colorEnum == ColorEnum.YELLOW then
            if flag == CacheFlag.CACHE_SHOTSPEED then
                player.ShotSpeed = player.ShotSpeed + 1
            elseif flag == CacheFlag.CACHE_DAMAGE then
                player.Damage = player.Damage + 1
            end
        elseif colorEnum == ColorEnum.WHITE then
            if flag == CacheFlag.CACHE_SHOTSPEED then
                player.ShotSpeed = player.ShotSpeed + 0.5
            elseif flag == CacheFlag.CACHE_DAMAGE then
                player.Damage = player.Damage + 1.5
            end
        elseif colorEnum == ColorEnum.BLUE then
            if flag == CacheFlag.CACHE_DAMAGE then
                player.Damage = player.Damage + 2
            end
        end
    else
        data.PolarisBuff = nil
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.AddPlayerBuffs)

function mod:PolarisTearBuffs(tear)
    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_POLARIS) then return end

    local data = mod:GetData(player)
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_POLARIS)
    if data.PolarisBuff == nil then
        updatePolarisBuffForPlayer(player)
    end

    if data.PolarisBuff.ColorEnum == ColorEnum.RED then
        tear.Scale = tear.Scale * 0.5
    elseif data.PolarisBuff.ColorEnum == ColorEnum.WHITE then
        if rng:RandomFloat() <= 0.2 then
            tear:AddTearFlags(TearFlags.TEAR_LIGHT_FROM_HEAVEN)
        end
    elseif data.PolarisBuff.ColorEnum == ColorEnum.BLUE then
        tear.Scale = tear.Scale * 2
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.PolarisTearBuffs)

function mod:PolarisTearHit(tear, collider)
    local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
    if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_POLARIS) then return end

    local data = mod:GetData(player)
    if data.PolarisBuff == nil then
        updatePolarisBuffForPlayer(player)
    end
    if data.PolarisBuff.ColorEnum == ColorEnum.BLUE then
        if collider:IsActiveEnemy(false) and collider:IsVulnerableEnemy() then
            collider:TakeDamage(10, DamageFlag.DAMAGE_FIRE, EntityRef(tear), 0)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.PolarisTearHit)

function mod:PolarisFamiliarInit(familiar)
    familiar.IsFollower = true
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.PolarisFamiliarInit, FamiliarVariantPolaris)

function mod:PolarisFamiliarUpdate(familiar)
    local player = familiar.SpawnerEntity:ToPlayer()
    local data = mod:GetData(player)
    if data.PolarisBuff == nil then
        updatePolarisBuffForPlayer(player)
    end
    familiar:SetColor(data.PolarisBuff.Color, 0, 0, false, false)
    familiar:FollowParent()
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.PolarisFamiliarUpdate, FamiliarVariantPolaris)