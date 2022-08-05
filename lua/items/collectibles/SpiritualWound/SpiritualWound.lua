local mod = Furtherance
local game = Game()

local FindTargets = include("lua.items.collectibles.SpiritualWound.FindTargets")
local UpdateFocus = include("lua.items.collectibles.SpiritualWound.UpdateFocus")
local RenderLasers = include("lua.items.collectibles.SpiritualWound.RenderLasers")
local DamageEnemies = include("lua.items.collectibles.SpiritualWound.DamageEnemies")

local ItemLaserVariant = RenderLasers.ItemLaserVariant

local function hasItem(player)
    return player:HasCollectible(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND) or player:GetPlayerType() == PlayerType.PLAYER_MIRIAM_B
end

local function setCanShoot(player, canShoot) -- Funciton Credit: im_tem
    local oldchallenge = game.Challenge

    game.Challenge = canShoot and Challenge.CHALLENGE_NULL or Challenge.CHALLENGE_SOLAR_SYSTEM
    player:UpdateCanShoot()
    game.Challenge = oldchallenge
end

---@class SpiritualWoundItemData
---@field Synergies { [CollectibleType]: int }
---@field TriggeredSynergies { [CollectibleType]: int|nil }
---@field Owner EntityPlayer
---@field Focus EntityEffect|nil
---@field SnapCooldown int
---@field WasDropPressed boolean
---@field WasAttacking boolean
---@field OldLaserVariant int
---@field LaserVariant int
---@field RNG RNG
---mapping of pointer hashes to lasers
---@field UntargetedLasers { [int]: EntityLaser } 
---@field TargetedLasers EntityLaser[]
---@field HitCount int
---@field GetDamageMultiplier (fun(SpiritualWoundItemData): number)|nil

local SYNERGIES = {
    CollectibleType.COLLECTIBLE_CHOCOLATE_MILK,
    CollectibleType.COLLECTIBLE_HAEMOLACRIA,
    CollectibleType.COLLECTIBLE_CRICKETS_BODY,
    CollectibleType.COLLECTIBLE_IPECAC,
}

---@param player EntityPlayer
---@return SpiritualWoundItemData
local function createItemData(player)
    local itemData = {
        Owner = player,
        Synergies = {},
        TriggeredSynergies = {},

        -- focus data
        SnapCooldown = 0,
        WasDropPressed = false,
        WasAttacking = false,

        -- laser data
        OldLaserVariant = ItemLaserVariant.NORMAL,
        LaserVariant = ItemLaserVariant.NORMAL,
        RNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND),

        -- damage data
        UntargetedLasers = {},
        TargetedLasers = {},
        HitCount = 0,
        GetDamageMultiplier = nil,
    }

    for _, collectible in ipairs(SYNERGIES) do
        itemData.Synergies[collectible] = player:GetCollectibleNum(collectible)
    end

    return itemData
end

---@param player EntityPlayer
function mod:SpiritualWoundUpdate(player)
    local hasItemVar = hasItem(player)
    setCanShoot(player, not hasItemVar)
    if not hasItemVar then return end

    local data = mod:GetData(player)
    local itemData = data.SpiritualWound
    if itemData == nil then
        itemData = createItemData(player)
        data.SpiritualWound = itemData
    end

    local triggeredSynergies = itemData.TriggeredSynergies
    local synergies = itemData.Synergies
    for collectible, oldCount in pairs(itemData.Synergies) do
        local newCount = player:GetCollectibleNum(collectible)
        local delta = newCount - oldCount
        if delta ~= 0 then
            triggeredSynergies[collectible] = delta
        else
            triggeredSynergies[collectible] = nil
        end
        synergies[collectible] = newCount
    end

    local targetQuery = FindTargets(itemData)
    UpdateFocus(itemData, targetQuery)
    RenderLasers(itemData, targetQuery)
    DamageEnemies(itemData, targetQuery)
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.SpiritualWoundUpdate)

---@param player EntityPlayer
function mod:SpiritualWoundPlayerDied(player)
    local data = mod:GetData(player)
    local itemData = data.SpiritualWound
    if itemData == nil then return end

    RenderLasers.RemoveLasers(itemData)
    RenderLasers.StopLaserSounds()
    UpdateFocus.RemoveFocus(itemData)
end
mod:AddCallback(mod.CustomCallbacks.MC_POST_PLAYER_DIED, mod.SpiritualWoundPlayerDied)
