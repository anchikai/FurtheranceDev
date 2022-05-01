local mod = Furtherance
local game = Game()

function mod:Mandrake()
	local room = game:GetRoom()
	if room:GetType() == RoomType.ROOM_TREASURE and room:IsFirstVisit() then
		for p = 0, game:GetNumPlayers() - 1 do
			local player = Isaac.GetPlayer(p)
			if player:HasCollectible(CollectibleType.COLLECTIBLE_MANDRAKE) then
				for i, entity in ipairs(Isaac.GetRoomEntities()) do
					if entity.Type == 5 and entity.Variant == 100 then
						entity.Position = entity.Position - Vector(40, 0)
						entity:ToPickup().OptionsPickupIndex = 1
					end
				end
				if player:HasCollectible(CollectibleType.COLLECTIBLE_MORE_OPTIONS) then
					pos = 69
					option = 2
				else
					pos = 68
					option = 1
				end
				-- Thanks Laraz#2909!
				repeat
					ID = player:GetDropRNG():RandomInt(Isaac.GetItemConfig():GetCollectibles().Size - 1) + 1
				until (Isaac.GetItemConfig():GetCollectible(ID).Tags & ItemConfig.TAG_QUEST ~= ItemConfig.TAG_QUEST
				and Isaac.GetItemConfig():GetCollectible(ID).Type == 4)    
					local babee = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, ID, room:GetGridPosition(pos), Vector.Zero, player):ToPickup()
					babee.OptionsPickupIndex = option
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.Mandrake)