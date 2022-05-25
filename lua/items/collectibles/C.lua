local mod = Furtherance
local game = Game()

function mod:UseC(boi, rng, player, slot, data)
	local data = mod:GetData(player)

	player:RemoveCollectible(CollectibleType.COLLECTIBLE_C_KEY)
	Isaac.ExecuteCommand("goto s.library.0")
	data.Teleported = true
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseC, CollectibleType.COLLECTIBLE_C_KEY)

function mod:CKeyTeleported(boi, rng, player, slot, data)
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if data.Teleported == true then
			--spawn item pedestals
			game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetCenterPos(), Vector.Zero, nil, 0, room:GetSpawnSeed())
			game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(63), Vector.Zero, nil, 0, room:GetSpawnSeed())
			game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(71), Vector.Zero, nil, 0, room:GetSpawnSeed())
			data.Teleported = false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.CKeyTeleported)
