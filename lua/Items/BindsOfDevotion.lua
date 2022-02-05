local mod = further
local game = Game()

function mod:addJacob(player, isJacob)
	local id = game:GetNumPlayers() - 1
	local playerType = player:GetPlayerType()
	Isaac.ExecuteCommand('addplayer '..PlayerType.PLAYER_JACOB..' '..player.ControllerIndex)
	local _p = Isaac.GetPlayer(id + 1)
	local d = mod:GetData(_p)
	if isJacob then
		_p.Parent = player
		game:GetHUD():AssignPlayerHUDs()
		
		_p:AddMaxHearts(-_p:GetMaxHearts())
		_p:AddSoulHearts(-_p:GetSoulHearts())
		_p:AddBoneHearts(-_p:GetBoneHearts())
		_p:AddGoldenHearts(-_p:GetGoldenHearts())
		_p:AddEternalHearts(-_p:GetEternalHearts())
		_p:AddHearts(-_p:GetHearts())
		
		_p:AddMaxHearts(2)
		_p:AddHearts(2)
		_p.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
		d.IsJacob = true

		Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, -1, _p.Position, _p.Velocity, _p)
	end
	return _p
end

function mod:addNewJacob(player, flag)
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_BINDS_OF_DEVOTION) and data.HasJacob ~= true then
		data.HasJacob = true
		mod:addJacob(player, true)
		return true
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.addNewJacob)

function mod:preUseItem(_, _, player) 
	local data = mod:GetData(player)
	if data.IsJacob then --for some reason jacob can use items so (not me) has to do this
		return true
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.preUseItem)

function mod:onEntityTakeDamage(tookDamage) 
	local data = mod:GetData(tookDamage)
	if data.IsJacob then
		for i = 0, game:GetNumPlayers() - 1 do
			local player = game:GetPlayer(i)
			player:Revive()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.onEntityTakeDamage, EntityType.ENTITY_PLAYER)


-----------------------------------
--Helper Functions (thanks piber)--
-----------------------------------

function mod:GetMaxCollectibleID()
    return Isaac.GetItemConfig():GetCollectibles().Size -1
end

function mod:GetData(entity)
	if entity and entity.GetData then
		local data = entity:GetData()
		if not data.mod then
			data.mod = {}
		end
		return data.mod
	end
	return nil
end

OnRenderCounter = 0
IsEvenRender = true
mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	OnRenderCounter = OnRenderCounter + 1
	
	IsEvenRender = false
	if Isaac.GetFrameCount()%2 == 0 then
		IsEvenRender = true
	end
end)

--ripairs stuff from revel
function ripairs_it(t,i)
	i=i-1
	local v=t[i]
	if v==nil then return v end
	return i,v
end
function ripairs(t)
	return ripairs_it, t, #t+1
end

--delayed functions
DelayedFunctions = {}

function DelayFunction(func, delay, args, removeOnNewRoom, useRender)
	local delayFunctionData = {
		Function = func,
		Delay = delay,
		Args = args,
		RemoveOnNewRoom = removeOnNewRoom,
		OnRender = useRender
	}
	table.insert(DelayedFunctions, delayFunctionData)
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
	for i, delayFunctionData in ripairs(DelayedFunctions) do
		if delayFunctionData.RemoveOnNewRoom then
			table.remove(DelayedFunctions, i)
		end
	end
end)

local function delayFunctionHandling(onRender)
	if #DelayedFunctions ~= 0 then
		for i, delayFunctionData in ripairs(DelayedFunctions) do
			if (delayFunctionData.OnRender and onRender) or (not delayFunctionData.OnRender and not onRender) then
				if delayFunctionData.Delay <= 0 then
					if delayFunctionData.Function then
						if delayFunctionData.Args then
							delayFunctionData.Function(table.unpack(delayFunctionData.Args))
						else
							delayFunctionData.Function()
						end
					end
					table.remove(DelayedFunctions, i)
				else
					delayFunctionData.Delay = delayFunctionData.Delay - 1
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	delayFunctionHandling(false)
end)

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	delayFunctionHandling(true)
end)

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function()
	DelayedFunctions = {}
end)