local MOD = Furtherance
local GAME = Game()

function MOD:ZZZZ()
	local ROOM = GAME:GetRoom()
	if ROOM:GetType() == RoomType.ROOM_TREASURE and ROOM:IsFirstVisit() then
		for P = 0, GAME:GetNumPlayers() - 1 do
			local PLAYER = Isaac.GetPlayer(P)
			if PLAYER:HasCollectible(CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ) then
				PLAYER:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetRandomPosition(), Vector.Zero, PLAYER)
				PLAYER:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
			end
		end
	end
end
MOD:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, MOD.ZZZZ)