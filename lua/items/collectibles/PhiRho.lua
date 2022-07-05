local mod = Furtherance
local game = Game()

local LaserHomingType = {
    NORMAL = 0,
    FREEZE = 1,
    FREEZE_HEAD = 2
}

local LaserVariant = {
    BRIMSTONE = 1,
    TECHNOLOGY = 2,
    SHOOP_DA_WHOOP = 3,
    PRIDE = 4,
    LIGHT_BEAM = 5,
    MEGA_BLAST = 6,
    TRACTOR_BEAM = 7,
    LIGHT_RING = 8, -- crashes if you run this with homing
    BRIMTECH = 9,
    JACOBS_LADDER = 10,
    BIG_BRIMSTONE = 11,
    DIARRHEASTONE = 12,
    MEGA_BRIMTECH = 13,
    BIG_BRIMTECH = 14,
    BIGGER_BRIMTECH = 15,
  }

-- something along the lines of upgrading existing lasers...
-- all lasers home
---@param laser EntityLaser
function mod:PostLaserInit(laser)
    local player = laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer()
    if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_PHI_RHO) then return end

    local room = game:GetRoom()
    if room:IsClear() then return end

    if player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then
        laser:SetHomingType(LaserHomingType.FREEZE)
    else
        laser:SetHomingType(LaserHomingType.FREEZE_HEAD)
    end
    if laser.Variant ~= LaserVariant.LIGHT_RING then
        laser:AddTearFlags(TearFlags.TEAR_HOMING)
    end
    laser.DisableFollowParent = true
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_INIT, mod.PostLaserInit)

---@param laser EntityLaser
function mod:PostLaserUpdate(laser)
    local player = laser.SpawnerEntity and laser.SpawnerEntity:ToPlayer()
    if player == nil or not player:HasCollectible(CollectibleType.COLLECTIBLE_PHI_RHO) or laser.FrameCount ~= 1 then return end
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) then
        laser:SetOneHit(true)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, mod.PostLaserUpdate)