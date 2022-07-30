--[[

- Tainted Miriam now has a pocket active item, "Polarity Shift". This item
  charges up with kills that would normally heal her if she was not at full
  health. The item takes 6 charges to fully charge, the equivalent of 6
  healing procs (or 3 full red hearts)
- On use, Tainted Miriam's "Spiritual Wound" attack is converted into Lightning
  bolts for the current room. Additionally, her Fire Rate is increased by 1,
  and her movement speed is increased by 0.4.
- Lightning bolts deal 2x Tainted Miriam's damage on the first frame (along
  with a very satisfying sfx), and continue to do 0.15x damage per frame over
  time while tethered.
- Lightning bolts do not heal.
- Using Polarity Shift again while its effect is active will deactivate the
  effect, returning her to Spiritual Wound and resetting her Fire Rate and
  movement speed boosts.
- It does not charge with clearing rooms or taking batteries.

--]]

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

local mod = Furtherance
local game = Game()

local PolarityShiftCache = CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_SPEED

local SpiritualWoundVariant = {
  NORMAL = LaserVariant.BRIMTECH,
  POLARITY_SHIFT = LaserVariant.JACOBS_LADDER
}

local function getDamageMultiplier(self)
  return self.HitCount == 0 and 2 or 0.15
end

function mod:UsePolarityShift(_, _, player)
  -- spiritual wound attack is converted into lightning bolts for the current room
  local data = mod:GetData(player)
  local spiritualWoundData = data.SpiritualWound
  if spiritualWoundData == nil then return true end

  data.UsedPolarityShift = not data.UsedPolarityShift or nil
  if data.UsedPolarityShift then
    spiritualWoundData.HitCount = 0
    spiritualWoundData.LaserVariant = SpiritualWoundVariant.POLARITY_SHIFT
    spiritualWoundData.GetDamageMultiplier = getDamageMultiplier
  else
    spiritualWoundData.LaserVariant = SpiritualWoundVariant.NORMAL
    spiritualWoundData.GetDamageMultiplier = nil
  end

  -- what is PolarityShift not changing directly?
  -- the damage output of SpiritualWound
  -- the laser visuals from SpiritualWound

  player:AddCacheFlags(PolarityShiftCache)
  player:EvaluateItems()

  return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UsePolarityShift, CollectibleType.COLLECTIBLE_POLARITY_SHIFT)

function mod:PolarityShiftBuffs(player, flag)
  local data = mod:GetData(player)
  if not data.UsedPolarityShift then return end

  if flag == CacheFlag.CACHE_SPEED then
    player.MoveSpeed = player.MoveSpeed + 0.4
  elseif flag == CacheFlag.CACHE_FIREDELAY then
    player.MaxFireDelay = mod:GetFireDelayFromTears(mod:GetTearsFromFireDelay(player.MaxFireDelay) + 1)
  end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.PolarityShiftBuffs)

function mod:ResetPolarityShiftBuffs()
  for i = 0, game:GetNumPlayers() - 1 do
    local player = Isaac.GetPlayer(i)
    local data = mod:GetData(player)

    data.UsedPolarityShift = nil
    local spiritualWoundData = data.SpiritualWound
    if spiritualWoundData then
      if spiritualWoundData.GetDamageMultiplier == getDamageMultiplier then
        spiritualWoundData.GetDamageMultiplier = nil
      end
      if spiritualWoundData.LaserVariant == SpiritualWoundVariant.POLARITY_SHIFT then
        spiritualWoundData.LaserVariant = SpiritualWoundVariant.NORMAL
      end
    end
  end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.ResetPolarityShiftBuffs)