local mod = further
local game = Game()

function mod:UseC(boi, rng, player, slot, data)
	local data = player:GetData()

	player:AnimateCollectible(CollectibleType.COLLECTIBLE_C_KEY, "UseItem", "PlayerPickup")
	player:RemoveCollectible(CollectibleType.COLLECTIBLE_C_KEY)
	Isaac.ExecuteCommand("goto s.library.70055")
	data.Teleported = true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseC, CollectibleType.COLLECTIBLE_C_KEY)

function mod:CKeyTeleported(boi, rng, player, slot, data)
	local room = Game():GetRoom()
	
	for i = 0, Game():GetNumPlayers() - 1 do
		local player = Game():GetPlayer(i)
		local data = player:GetData()
		
		if data.Teleported == true then
		--spawn item pedastols 
		game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetCenterPos(), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(120), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(122, 4), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(124, 4), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(127, 4), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(129, 4), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(131, 4), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		data.Teleported = false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.CKeyTeleported)