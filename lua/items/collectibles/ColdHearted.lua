local mod = Furtherance
local game = Game()

function mod:FrozenTouch(player, collider)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_COLD_HEARTED) then
        if collider:IsActiveEnemy(false) and collider:IsVulnerableEnemy() and collider:IsBoss() == false then
            collider:AddEntityFlags(EntityFlag.FLAG_ICE)
            collider:TakeDamage(math.huge, 0, EntityRef(player), 0)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, mod.FrozenTouch)