local mod = Furtherance
local game = Game()

function mod:GetBarfBag(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BARF_BAG) then
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - (120 * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BARF_BAG, false))
		end
		if flag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed - (0.2 * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BARF_BAG, false))
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetBarfBag)

function mod:VomitTears(tear)
    local player = tear.Parent:ToPlayer()
    if player:HasCollectible(CollectibleType.COLLECTIBLE_BARF_BAG) then
        if game:GetFrameCount()%3 == 0 then
            local barf = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, tear.Position, Vector.Zero, player):ToEffect()
            barf.Color = Color(0, 1, 0, 1, 0, 0.5, 0)
            barf.CollisionDamage = barf.CollisionDamage / 2
            tear.Color = Color(0.4, 0.97, 0.5, 1, 0, 0.2, 0)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.VomitTears)