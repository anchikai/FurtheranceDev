local mod = Furtherance
local game = Game()

-- NOTE: -- functions are defined on Furtherance so my autocomplete picks it up

-----------------------------------
--Helper Functions (thanks piber)--
-----------------------------------

function Furtherance:GetPlayers(functionCheck, ...)
	local args = { ... }
	local players = {}
	for i = 1, game:GetNumPlayers() do
		local player = Isaac.GetPlayer(i - 1)
		local argsPassed = true

		if type(functionCheck) == "function" then
			for j = 1, #args do
				if args[j] == "player" then
					args[j] = player
				elseif args[j] == "currentPlayer" then
					args[j] = i
				end
			end

			if not functionCheck(table.unpack(args)) then
				argsPassed = false
			end
		end

		if argsPassed then
			table.insert(players, player)
		end
	end
	return players
end

function Furtherance:GetPlayerFromTear(tear)
	local check = tear.Parent or mod:GetSpawner(tear) or tear.SpawnerEntity
	if check then
		if check.Type == EntityType.ENTITY_PLAYER then
			return mod:GetPtrHashEntity(check):ToPlayer()
		elseif check.Type == EntityType.ENTITY_FAMILIAR and check.Variant == FamiliarVariant.INCUBUS then
			local data = mod:GetData(tear)
			data.IsIncubusTear = true
			return mod:GetPtrHashEntity(check:ToFamiliar().Player):ToPlayer()
		end
	end
	return nil
end

function Furtherance:GetSpawner(entity)
	if entity and entity.GetData then
		local spawnData = mod:GetSpawnData(entity)
		if spawnData and spawnData.SpawnerEntity then
			local spawner = mod:GetPtrHashEntity(spawnData.SpawnerEntity)
			return spawner
		end
	end
	return nil
end

function Furtherance:GetSpawnData(entity)
	if entity and entity.GetData then
		local data = mod:GetData(entity)
		return data.SpawnData
	end
	return nil
end

function Furtherance:GetPtrHashEntity(entity)
	if entity then
		if entity.Entity then
			entity = entity.Entity
		end
		for _, matchEntity in pairs(Isaac.FindByType(entity.Type, entity.Variant, entity.SubType, false, false)) do
			if GetPtrHash(entity) == GetPtrHash(matchEntity) then
				return matchEntity
			end
		end
	end
	return nil
end

function Furtherance:GetData(entity)
	if type(entity) ~= "userdata" or not entity.GetData then
		error("Invalid argument, expected an Entity", 2)
	end

	local data = entity:GetData()
	if not data.Furtherance then
		data.Furtherance = {}
	end

	return data.Furtherance
end

--[[mod.entitySpawnData = {}
mod:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, function(_, type, variant, subType, position, velocity, spawner, seed)
	mod.entitySpawnData[seed] = {
		Type = type,
		Variant = variant,
		SubType = subType,
		Position = position,
		Velocity = velocity,
		SpawnerEntity = spawner,
		InitSeed = seed
	}
end)
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, entity)
	local seed = entity.InitSeed
	local data = mod:GetData(entity)
	data.SpawnData = mod.entitySpawnData[seed]
end)
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_REMOVE, function(_, entity)
	local data = mod:GetData(entity)
	data.SpawnData = nil
end)
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	mod.entitySpawnData = {}
end)]]

function Furtherance:Contains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end

function Furtherance:GetRandomNumber(numMin, numMax, rng)
	if not numMax then
		numMax = numMin
		numMin = nil
	end

	rng = rng or RNG()

	if type(rng) == "number" then
		local seed = rng
		rng = RNG()
		rng:SetSeed(seed, 1)
	end

	if numMin and numMax then
		return rng:Next() % (numMax - numMin + 1) + numMin
	elseif numMax then
		return rng:Next() % numMin
	end
	return rng:Next()
end

OnRenderCounter = 0
IsEvenRender = true
mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	OnRenderCounter = OnRenderCounter + 1

	IsEvenRender = false
	if Isaac.GetFrameCount() % 2 == 0 then
		IsEvenRender = true
	end
end)

--ripairs stuff from revel
local function ripairs_it(t, i)
	i = i - 1
	if i <= 0 then return nil end

	local v = t[i]
	if v == nil then return nil end

	return i, v
end

function ripairs(t)
	return ripairs_it, t, #t + 1
end

--delayed functions
mod.UpdateDelayedFunctions = {}
mod.RenderDelayedFunctions = {}

function Furtherance:DelayFunction(func, delay, args, removeOnNewRoom, useRender)
	local delayFunctionData = {
		Function = func,
		Delay = delay,
		Args = args,
		RemoveOnNewRoom = removeOnNewRoom
	}

	if useRender then
		table.insert(mod.RenderDelayedFunctions, delayFunctionData)
	else
		table.insert(mod.UpdateDelayedFunctions, delayFunctionData)
	end
end

-- clear delayed functions that have .RemoveOnNewRoom = true
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	for i, delayFunctionData in ripairs(mod.RenderDelayedFunctions) do
		if delayFunctionData.RemoveOnNewRoom then
			table.remove(mod.RenderDelayedFunctions, i)
		end
	end

	for i, delayFunctionData in ripairs(mod.UpdateDelayedFunctions) do
		if delayFunctionData.RemoveOnNewRoom then
			table.remove(mod.UpdateDelayedFunctions, i)
		end
	end
end)

local function handleDelayedFunction(delayFunctionData)
	local shouldInvoke = delayFunctionData.Delay <= 0

	if shouldInvoke then
		if delayFunctionData.Function then
			if delayFunctionData.Args then
				delayFunctionData.Function(table.unpack(delayFunctionData.Args))
			else
				delayFunctionData.Function()
			end
		end
	else
		delayFunctionData.Delay = delayFunctionData.Delay - 1
	end

	return shouldInvoke
end

local function handleDelayedFunctions(delayedFunctions)
	for i, delayFunctionData in ripairs(delayedFunctions) do
		local shouldRemove = handleDelayedFunction(delayFunctionData)
		if shouldRemove then
			table.remove(delayedFunctions, i)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	handleDelayedFunctions(mod.UpdateDelayedFunctions)
end)

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	handleDelayedFunctions(mod.RenderDelayedFunctions)
end)

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	mod.UpdateDelayedFunctions = {}
	mod.RenderDelayedFunctions = {}
end)

function Furtherance:EsauCheck(player)
	if not player or not player.GetData then
		return nil
	end
	local currentPlayer = nil
	for i = 0, game:GetNumPlayers() - 1 do
		local otherPlayer = Isaac.GetPlayer(i)
		if otherPlayer.ControllerIndex == player.ControllerIndex and otherPlayer:GetPlayerType() == player:GetPlayerType() then
			currentPlayer = i + 1
		end
	end
	return currentPlayer
end
