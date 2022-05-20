local mod = Furtherance
local game = Game()

local PLAYERTYPE_FAKE_JACOB = Isaac.GetPlayerTypeByName("FakeJacob", false)

function mod:addJacob(player, isJacob)
	local id = game:GetNumPlayers() - 1
	Isaac.ExecuteCommand('addplayer '..PLAYERTYPE_FAKE_JACOB..' '..player.ControllerIndex)
	local jacob = Isaac.GetPlayer(id + 1)
	if isJacob then
		local jacobData = mod:GetData(jacob)

		jacob.Parent = player
		
		-- remove all hearts
		jacob:AddMaxHearts(-jacob:GetMaxHearts())
		jacob:AddSoulHearts(-jacob:GetSoulHearts())
		jacob:AddBoneHearts(-jacob:GetBoneHearts())
		jacob:AddGoldenHearts(-jacob:GetGoldenHearts())
		jacob:AddEternalHearts(-jacob:GetEternalHearts())
		jacob:AddHearts(-jacob:GetHearts())
		
		-- add hearts and max hearts
		jacob:AddMaxHearts(6)
		jacob:AddHearts(6)
		
		jacobData.FromBinds = true

		Isaac.Spawn(
			EntityType.ENTITY_EFFECT,
			EffectVariant.POOF01,
			-1,
			jacob.Position,
			jacob.Velocity,
			jacob
		)
		game:GetHUD():AssignPlayerHUDs()
	end

	return jacob
end

function mod:FakeJacobStats(player, flag)
	local data = mod:GetData(player)
	if player:GetPlayerType() == PLAYERTYPE_FAKE_JACOB then -- If the player is Peter it will apply his stats
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - 1
		end
		if flag == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage - 0.75
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - 60
		end
		if flag == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.15
		end
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + 1
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.FakeJacobStats)

function mod:addNewJacob(player, flag)
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION) and data.HasBinds ~= true then
		data.HasBinds = true
		mod:addJacob(player, true)
		return true
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.addNewJacob)

function mod:preUseItem(_, _, player) 
	local data = mod:GetData(player)
	if data.FromBinds then -- for some reason Jacob/Esau can use items so (not me) has to do this
		-- don't let him use the item
		return true
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.preUseItem)