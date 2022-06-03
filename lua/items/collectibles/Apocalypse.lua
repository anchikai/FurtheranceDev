local mod = Furtherance
local game = Game()

local statObjs = {
    { Name = "Damage", Flag = CacheFlag.CACHE_DAMAGE, Buff = 1 },
    { Name = "MaxFireDelay", Flag = CacheFlag.CACHE_FIREDELAY, Buff = -0.5 }, -- MaxFireDelay buffs should be negative!
    { Name = "TearRange", Flag = CacheFlag.CACHE_RANGE, Buff = 12.5 },
    { Name = "ShotSpeed", Flag = CacheFlag.CACHE_SHOTSPEED, Buff = 0.1 },
    { Name = "MoveSpeed", Flag = CacheFlag.CACHE_SPEED, Buff = 0.05 },
    { Name = "Luck", Flag = CacheFlag.CACHE_LUCK, Buff = 1 },
}

local ALL_BUFFED_FLAGS = 0
for _, obj in ipairs(statObjs) do
    ALL_BUFFED_FLAGS = ALL_BUFFED_FLAGS | obj.Flag
end

mod:SavePlayerData({
    ApocalypseBuffs = function()
        local default = {}
        for i = 1, #statObjs do
            default[i] = 0
        end

        return default
    end
})

function mod:UseApocalypse(_, _, player)
    local data = mod:GetData(player)
    if player:GetActiveItem(ActiveSlot.SLOT_POCKET) ~= nil then
        PocketActive = player:GetActiveItem(ActiveSlot.SLOT_POCKET)
    end
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_APOCALYPSE)

    local itemCount = player:GetCollectibleCount()
    if itemCount <= 0 then
        return
    end

    for i = 1, Isaac.GetItemConfig():GetCollectibles().Size - 1 do
        while player:HasCollectible(i) do
            player:RemoveCollectible(i, false, ActiveSlot.SLOT_PRIMARY, true)
            player:TryRemoveCollectibleCostume(i, true)
        end
        player:SetPocketActiveItem(PocketActive, ActiveSlot.SLOT_POCKET, false)
    end

    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APOCALYPSE)

    local buffs = data.ApocalypseBuffs

    for _ = 1, itemCount do
        local choice1 = rng:RandomInt(#statObjs) + 1

        local choice2
        repeat
            choice2 = rng:RandomInt(#statObjs) + 1
        until choice2 ~= choice1

        buffs[choice1] = buffs[choice1] + 1
        buffs[choice2] = buffs[choice2] + 1
    end

    player:AddCacheFlags(ALL_BUFFED_FLAGS)
    player:EvaluateItems()

    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseApocalypse, CollectibleType.COLLECTIBLE_APOCALYPSE)

function mod:ApocalypseBuffs(player, flag)
    local data = mod:GetData(player)
    if not data.ApocalypseBuffs then return end

    for i, buffCount in ipairs(data.ApocalypseBuffs) do
        local stat = statObjs[i]

        if stat.Flag == flag then
            player[stat.Name] = player[stat.Name] + buffCount * stat.Buff
            break
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.ApocalypseBuffs)
