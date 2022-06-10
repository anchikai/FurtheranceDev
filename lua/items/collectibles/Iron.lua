local mod = Furtherance
local game = Game()

local IronOrbital = Isaac.GetEntityVariantByName("Iron")

function mod:IronInit(Iron)
    Iron:AddToOrbit(5)
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.IronInit, IronOrbital)

function mod:IronUpdate(Iron)
    local player = Iron.SpawnerEntity:ToPlayer()
    Iron.OrbitDistance = Vector(128, 128)
    Iron.OrbitSpeed = 0.01
    Iron.Velocity = Iron:GetOrbitPosition(player.Position + player.Velocity) - Iron.Position
    for _, tear in ipairs(Isaac.FindInRadius(Iron.Position, 12, EntityPartition.TEAR)) do
        local data = mod:GetData(tear)
        if data.WentThruIron ~= true then
            tear.CollisionDamage = tear.CollisionDamage * 2
            tear:ToTear().Scale = tear:ToTear().Scale * 2
            tear:ToTear():AddTearFlags(TearFlags.TEAR_BURN)
            tear:SetColor(Color(1, 1, 1, 1, 0.3, 0, 0), 0, 1)
            data.WentThruIron = true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.IronUpdate, IronOrbital)

function mod:WellCache(player, flag)
    if flag == CacheFlag.CACHE_FAMILIARS then
        player:CheckFamiliar(IronOrbital, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_IRON), player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_IRON), Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_IRON))
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.WellCache)