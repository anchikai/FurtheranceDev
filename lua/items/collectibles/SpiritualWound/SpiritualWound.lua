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

---@param player EntityPlayer
---@return SpiritualWoundItemData
local function createItemData(player)
    return {
        Owner = player,
        SnapCooldown = 0,
        WasDropPressed = false,
        WasAttacking = false,
        OldLaserVariant = ItemLaserVariant.NORMAL,
        LaserVariant = ItemLaserVariant.NORMAL,
        RNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIRITUAL_WOUND),
        UntargetedLasers = {},
        TargetedLasers = {},
        HitCount = 0,
        GetDamageMultiplier = nil,
    }
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

    local targetQuery = FindTargets(itemData)
    UpdateFocus(itemData, targetQuery)
    RenderLasers(itemData, targetQuery)
    DamageEnemies(itemData, targetQuery)

    
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.SpiritualWoundUpdate)

---@param player EntityPlayer
function mod:SpiritualWoundCheckDead(player)
    local data = mod:GetData(player)
    local itemData = data.SpiritualWound
    if itemData == nil then return end

    local isDead = player:IsDead()
    if isDead ~= itemData.WasDead then
        itemData.WasDead = isDead
        if isDead then
            RenderLasers.RemoveLasers(itemData)
            RenderLasers.StopLaserSounds()
            UpdateFocus.RemoveFocus(itemData)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.SpiritualWoundCheckDead)
