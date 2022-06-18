local mod = Furtherance
local game = Game()
local rng = RNG()

local WhirlpoolVariant = Isaac.GetEntityVariantByName("Miriam Whirlpool")

local function hasItem(player)
	return player ~= nil and player:HasCollectible(CollectibleType.COLLECTIBLE_POLYDIPSIA)
end

local function isMiriam(player)
	return player ~= nil and player:GetPlayerType() == PlayerType.PLAYER_MIRIAM
end

function mod:GetPolydipsia(player, cacheFlag)
	if hasItem(player) or isMiriam(player) then
		if cacheFlag == CacheFlag.CACHE_RANGE then
			player.TearFallingSpeed = player.TearFallingSpeed + 20
			player.TearFallingAcceleration = player.TearFallingAcceleration + 1
		end
	end

	if hasItem(player) and not isMiriam(player) then
		if cacheFlag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = (player.MaxFireDelay * 2) + 10
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetPolydipsia)

local function makeMiriamPuddle(miriam, tear)
	local data = mod:GetData(tear)
	local playerData = mod:GetData(miriam)
	if data.MiriamPullEnemies then
		local whirlpool = Isaac.Spawn(EntityType.ENTITY_EFFECT, WhirlpoolVariant, 0, tear.Position, Vector.Zero, miriam):ToEffect()
		whirlpool.CollisionDamage = miriam.Damage * 0.33
		whirlpool.LifeSpan = 60
	else
		local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 1, tear.Position, Vector.Zero, miriam):ToEffect()
		puddle.CollisionDamage = miriam.Damage * 0.33

		puddle.SpriteScale = Vector.One * playerData.MiriamAOE
		puddle.Scale = playerData.MiriamAOE
	end

	if hasItem(miriam) and tear.SubType == 0 then
		local PolyMiriam = miriam:FireTear(tear.Position, tear.Velocity, true, true, false, miriam, 1)
		PolyMiriam.SubType = 1
	end
end

function mod:OnTearImpact(tear)
	local player = tear.SpawnerEntity and tear.SpawnerEntity:ToPlayer()
	if not hasItem(player) and not isMiriam(player) then return end

	if isMiriam(player) then
		makeMiriamPuddle(player, tear)
	else
		local puddle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER_TRAIL, 1, tear.Position, Vector.Zero, player):ToEffect()
		puddle.CollisionDamage = player.Damage * 0.33
	end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, mod.OnTearImpact, EntityType.ENTITY_TEAR)

function mod:MakePolydipsiaTear(tear)
    local player = tear.Parent:ToPlayer()
	if hasItem(player) or isMiriam(player) then
		tear.Scale = tear.Scale * 1.4
		tear:AddTearFlags(TearFlags.TEAR_KNOCKBACK)
		tear:SetKnockbackMultiplier(tear.KnockbackMultiplier*2)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.MakePolydipsiaTear)