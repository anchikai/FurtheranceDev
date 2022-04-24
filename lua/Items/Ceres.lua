local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:GetCeres(player,cacheFlag)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_CERES) then
		local pdata = mod:GetData(player)
		if pdata.tentacle == nil then
			pdata.tentacle = false
		end
		if cacheFlag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + 0.5
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetCeres)

function mod:InitCeresTear(tear) --replaces default tear to the "Seed" tear
    if tear.SpawnerType == EntityType.ENTITY_PLAYER and tear.Parent then
        local player = tear.Parent:ToPlayer()
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CERES) then
			local rollCeres = rng:RandomInt(100)
			local data = tear:GetData()
			if player.Luck > 9 then
				if rng:RandomInt(2) == 1 then
					data.ceres = true
					tear.Color = Color(0, 0.75, 0, 1, 0, 0, 0)
				end
			elseif rollCeres <= (player.Luck*5+5) then
				data.ceres = true
				tear.Color = Color(0, 0.75, 0, 1, 0, 0, 0)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.InitCeresTear)

function mod:CeresTearEffect(tear, collider)
    if tear.SpawnerType == EntityType.ENTITY_PLAYER and tear.Parent then
        local data = tear:GetData()
        if data.ceres and (collider:IsEnemy() and collider:IsVulnerableEnemy() and collider:IsActiveEnemy()) then
			for i = 0, game:GetNumPlayers() - 1 do
				local player = game:GetPlayer(i)
				local pdata = player:GetData()
				
				if pdata.creep == nil or 0 then
					pdata.creep = 90
					collider:SetColor(Color(0, 0.75, 0, 1, 0, 0, 0), 150, 1, true, false) -- Sets enemy color to green
				end
			end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.CeresTearEffect)
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.CeresTearEffect)

function mod:CeresCreep()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local pdata = player:GetData()
		if pdata.creep ~= nil and pdata.creep > 0 then
			pdata.creep = pdata.creep - 1
			if game:GetFrameCount()%5 == 0 then
				Isaac.Spawn(1000, EffectVariant.PLAYER_CREEP_GREEN, 0, player.Position, Vector(0,0), player)
			end
			if pdata.creep <= 0 then
				pdata.creep = 0
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.CeresCreep)

function mod:TouchCreep(_, damage) -- if an enemy walks over the creep
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local pdata = player:GetData()
		if player:HasCollectible(CollectibleType.COLLECTIBLE_CERES) then
			if (pdata.creep ~= nil) and (pdata.creep < 90) and (damage == 1) then
				local slowColor = Color(0.75, 0.75, 0.75, 1, 0, 0, 0)
				local tempEffects = player:GetEffects()
				for _, entity in pairs(Isaac.FindInRadius(player.Position, 100, EntityPartition.ENEMY)) do
					if pdata.tentacle == false then
						tempEffects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_WORM_FRIEND, -1)
						entity:AddSlowing(EntityRef(player), 30, 0.5, slowColor)
						pdata.tentacle = true
					end
				end
				if (pdata.tentacle == true) then
					tempEffects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_WORM_FRIEND, false, 1)
					pdata.tentacle = false
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.TouchCreep)