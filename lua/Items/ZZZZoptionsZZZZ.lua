local MOD = further

function MOD:ZZZZ()
	local ROOM = Game():GetRoom()
	if ROOM:GetType() == RoomType.ROOM_TREASURE and ROOM:IsFirstVisit() then
		for p = 0, Game():GetNumPlayers() - 1 do
			local PLAYER = Isaac.GetPlayer(p)
			if PLAYER:HasCollectible(CollectibleType.COLLECTIBLE_ZZZZoptionsZZZZ) then
				PLAYER:AddCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
				Isaac.Spawn(5, 100, 0, Isaac.GetRandomPosition(), Vector(0, 0), player)
				PLAYER:RemoveCollectible(CollectibleType.COLLECTIBLE_TMTRAINER)
			end
		end
	end
end

MOD:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, MOD.ZZZZ)