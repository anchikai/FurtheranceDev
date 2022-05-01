local mod = Furtherance
local game = Game()

local statObjs = {
    { Name = "Damage", Flag = CacheFlag.CACHE_DAMAGE },
    { Name = "FireDelay", Flag = CacheFlag.CACHE_FIREDELAY },
    { Name = "TearRange", Flag = CacheFlag.CACHE_RANGE },
    { Name = "ShotSpeed", Flag = CacheFlag.CACHE_SHOTSPEED },
    { Name = "MoveSpeed", Flag = CacheFlag.CACHE_SPEED },
    { Name = "Luck", Flag = CacheFlag.CACHE_LUCK },
}

local ALL_BUFFED_FLAGS = 0
for _, obj in ipairs(statObjs) do
    ALL_BUFFED_FLAGS = ALL_BUFFED_FLAGS | obj.Flag
end

---@param player EntityPlayer
function mod:UseApocalypse(_, _, player)
    local data = mod:GetData(player)
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
    end

    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APOCALYPSE)

    local buffs = data.ApocalypseBuffs
    if buffs == nil then
        buffs = {}
        for i = 1, #statObjs do
            buffs[i] = 0
        end
        data.ApocalypseBuffs = buffs
    end

    for _ = 1, itemCount do
        local choice1 = rng:RandomInt(#statObjs) + 1

        local choice2
        repeat
            choice2 = rng:RandomInt(#statObjs) + 1
        until choice2 ~= choice1

        buffs[choice1] = buffs[choice1] + 0.1
        buffs[choice2] = buffs[choice2] + 0.1
    end

    player:AddCacheFlags(ALL_BUFFED_FLAGS)
    player:EvaluateItems()

    return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseApocalypse, CollectibleType.COLLECTIBLE_APOCALYPSE)

function mod:ApocalypseBuffs(player, flag)
    local data = mod:GetData(player)
    local buffs = data.ApocalypseBuffs
    if not buffs then return end

    for i, buff in ipairs(data.ApocalypseBuffs) do
        local stat = statObjs[i]

        if stat.Flag == flag then
            player[stat.Name] = player[stat.Name] + buff
            break
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.ApocalypseBuffs)
