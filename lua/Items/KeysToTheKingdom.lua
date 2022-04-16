local mod = further
local game = Game()

function mod:UseKTTK(_, _, player)
	local room = game:GetRoom()
	local roomType = room:GetType()
	local level = game:GetLevel()
	local kttkRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)
	if roomType == RoomType.ROOM_DEVIL then
		if kttkRNG:RandomInt(2) == 0 then
			player:UseCard(Card.CARD_CREDIT, 257)
		else
			Isaac.Spawn(EntityType.ENTITY_FALLEN, 1, 0, room:GetCenterPos(), Vector.Zero, nilx)
		end
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
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseKTTK, CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)

function mod:kttkKills(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM) then
			soul = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ENEMY_SOUL, 0, entity.Position, Vector.Zero, player):ToEffect()
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.kttkKills)

function mod:EnemySouls(effect)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		local direction = (player.Position - soul.Position):Normalized()
		soul.Velocity = direction * 12
		if soul.Position:DistanceSquared(player.Position) < 400 then
			data.Soul = true
			soul:Remove()
		end
		if data.Soul == true then
			data.Soul = false
			if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM then
				if player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY) < 12 then
					player:SetActiveCharge(player:GetActiveCharge(ActiveSlot.SLOT_PRIMARY)+1, ActiveSlot.SLOT_PRIMARY)
					game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_PRIMARY)
					SFXManager():Play(SoundEffect.SOUND_BEEP)
				else
					game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_PRIMARY)
					SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
				end
			elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM then
				player:SetActiveCharge(player:GetActiveCharge(ActiveSlot.SLOT_SECONDARY)+1, ActiveSlot.SLOT_SECONDARY)
				game:GetHUD():FlashChargeBar(player, ActiveSlot.SLOT_SECONDARY)
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.EnemySouls, EffectVariant.ENEMY_SOUL)