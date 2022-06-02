local mod = Furtherance
local game = Game()

local TombstoneVariant = Isaac.GetEntityVariantByName("Epitaph Tombstone")

local Tombstone = {}
Tombstone.__index = Tombstone

function Tombstone.new(owner, position)
    local instance = Isaac.Spawn(EntityType.ENTITY_EFFECT, TombstoneVariant, 0, position, Vector.Zero, owner):ToEffect()

    local self = mod:GetData(instance)
    self.Instance = instance
    self.Owner = owner
    self.Health = 3

    setmetatable(self, Tombstone)
    return self
end

function Tombstone:TakeDamage()
    local sprite = self.Instance:GetSprite()
    self.Health = math.max(self.Health - 1, -1)
    if self.Health == 2 then
        sprite:Play("Damaged1", true)
    elseif self.Health == 1 then
        sprite:Play("Damaged2", true)
    elseif self.Health == 0 then
        sprite:Play("Destroyed", true)
        self:Die()
    end
end

function Tombstone:Die()
    local rng = self.Owner:GetTrinketRNG(TrinketType.TRINKET_EPITAPH)

    local coinCount = rng:RandomInt(3) + 3
    for _ = 1, coinCount do
        local velocity = 10 * Vector(
            rng:RandomFloat() - 0.5,
            rng:RandomFloat() - 0.5
        )
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, CoinSubType.COIN_PENNY, self.Instance.Position, velocity, self.Instance)
    end

    local keyCount = rng:RandomInt(2) + 2
    for _ = 1, keyCount do
        local velocity = 10 * Vector(
            rng:RandomFloat() - 0.5,
            rng:RandomFloat() - 0.5
        )
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_KEY, KeySubType.KEY_NORMAL, self.Instance.Position, velocity, self.Instance)
    end

    local ownerData = mod:GetData(self.Owner)
    if ownerData.EpitaphFirstPassiveItem then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ownerData.EpitaphFirstPassiveItem, Isaac.GetFreeNearPosition(self.Instance.Position, 40), Vector.Zero, self.Instance)
    end
    if ownerData.EpitaphLastPassiveItem then
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ownerData.EpitaphLastPassiveItem, Isaac.GetFreeNearPosition(self.Instance.Position, 40), Vector.Zero, self.Instance)
    end

    ownerData.EpitaphTombstoneDestroyed = true
end

return Tombstone