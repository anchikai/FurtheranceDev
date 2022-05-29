local MOD = Furtherance
local GAME = Game()

function MOD:ZZZZ()
	local ROOM = GAME:GetRoom()
	if ROOM:GetType() == RoomType.ROOM_TREASURE and ROOM:IsFirstVisit() then
		for P = 0, GAME:GetNumPlayers() - 1 do
			local PLAYER = Isaac.GetPlayer(P)
			if PLAYER:HasCollectible(CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ) then
				for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
					entity:ToPickup().OptionsPickupIndex = 2
				end
				PLAYER:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
				local AAAAAAAAAAAAAA = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetRandomPosition(), Vector.Zero, PLAYER):ToPickup()
				AAAAAAAAAAAAAA.OptionsPickupIndex = 2
				PLAYER:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
			end
		end
	end
end
MOD:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, MOD.ZZZZ)