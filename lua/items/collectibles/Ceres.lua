local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:GetCeres(player, flag)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_CERES) then
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetCeres)

local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

function mod:InitCeresTear(tear) -- Replaces default tear to the "Seed" tear
	if tear.SpawnerType == EntityType.ENTITY_PLAYER and tear.Parent then
		local player = tear.Parent:ToPlayer()
		if player:HasCollectible(CollectibleType.COLLECTIBLE_CERES) then

			-- min is 5%, max is 50%
			local chance = clamp(player.Luck, 0, 9) * 0.05 + 0.05
			if player:HasTrinket(TrinketType.TRINKET_TEARDROP_CHARM) then
				chance = 1 - (1 - chance) ^ 2
			end

			if rng:RandomFloat() <= chance then
				local data = mod:GetData(tear)
				data.ceres = true
				tear.Color = Color(0, 0.75, 0, 1, 0, 0, 0)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.InitCeresTear)

function mod:CeresTearEffect(tear, collider)
	if tear.SpawnerType == EntityType.ENTITY_PLAYER and tear.Parent then
		local data = mod:GetData(tear)
		if data.ceres and (collider:IsEnemy() and collider:IsVulnerableEnemy() and collider:IsActiveEnemy()) then
			for i = 0, game:GetNumPlayers() - 1 do
				local player = Isaac.GetPlayer(i)
				local pdata = mod:GetData(player)

				if pdata.CeresCreep == nil or 0 then
					pdata.CeresCreep = 90
					collider:SetColor(Color(0, 0.75, 0, 1, 0, 0, 0), 150, 1, true, false) -- Sets enemy color to green
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.CeresTearEffect)
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.CeresTearEffect)

function mod:CeresCreep(player)
	local pdata = mod:GetData(player)
	if pdata.CeresTentacle == nil then
		pdata.CeresTentacle = false
	end
	if pdata.CeresCreep ~= nil and pdata.CeresCreep > 0 then
		pdata.CeresCreep = pdata.CeresCreep - 1
		if game:GetFrameCount() % 5 == 0 then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_GREEN, 0, player.Position, Vector.Zero, player)
		end
		if pdata.CeresCreep <= 0 then
			pdata.CeresCreep = 0
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.CeresCreep)

function mod:TouchCreep(entity, collider) -- If an enemy walks over the creep
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local pdata = mod:GetData(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_CERES) then
			if (pdata.CeresCreep ~= nil and pdata.CeresCreep < 90) and entity.Variant == EffectVariant.PLAYER_CREEP_GREEN then
				local tempEffects = player:GetEffects()
				if pdata.CeresTentacle == false then
					tempEffects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_WORM_FRIEND, -1)
					collider:AddSlowing(EntityRef(player), 30, 0.5, Color(0.75, 0.75, 0.75, 1, 0, 0, 0))
					pdata.CeresTentacle = true
				elseif pdata.CeresTentacle == true then
					tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_WORM_FRIEND, false, 1)
					pdata.CeresTentacle = false
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.TouchCreep, EntityType.ENTITY_EFFECT)
