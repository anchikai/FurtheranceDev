local mod = further
local game = Game()

function mod:UseKTTK(_, _, player)
	local room = game:GetRoom()
	local roomType = room:GetType()
	local level = game:GetLevel()
	local kttkRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)
	if roomType == RoomType.ROOM_DEVIL then
		player:UseCard(Card.CARD_CREDIT, 257)
	elseif roomType == RoomType.ROOM_ANGEL then
		if player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) == false and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) == false then
			if kttkRNG:RandomInt(2) == 0 then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_1, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector(0, 0), player)
			else
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_2, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector(0, 0), player)
			end
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) == false then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_2, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector(0, 0), player)
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) == false and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_1, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector(0, 0), player)
		elseif player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) and player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector(0, 0), player)
		end
	elseif room:IsClear() then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, 0, 0, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector(0, 0), player)
	else
		player:UseActiveItem(CollectibleType.COLLECTIBLE_CRACK_THE_SKY)
	end
	player:AnimateCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, "UseItem", "PlayerPickup")
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseKTTK, CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)