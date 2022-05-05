--[[
Keys to the Kingdom
     Charge: Soul Charged like the Jar of Urns, 12 Charges
     Flavor Text: “Divine Control + Strength in Salvation”
     Item Quality: 4
     Item Pool: Angel Room
     Unlock Condition: Defeat Delirium as Peter

Notes:
When used, it has a variety of effects on Isaac's immediate surroundings (based on the room he's in).

Whilst held, Isaac will receive an additional 12.5% chance toward angel/devil rooms, mirroring Bethany's Book of Virtues. (tho the api hates this so we might not get this one)

When used in a room full of lesser enemies, they will all be spared instantly and clear the room, giving peter either a temporary floor-wide stat up or a small perma stat up

In a boss room, the key fills the room with holy light and a spare timer akin to Plum's own ability to be spared will begin. Isaac must not damage the boss or the light will disappear and he must fight the boss as normal. Upon the timer ending, the light shrinks into a pillar in the center and absorbs the boss, "saving" their soul. Isaac receives a small assortment of permanent random stat increases (health excluded).
When used in a "final boss" room, Isaac will only receive a single-use holy mantle effect, as those bosses cannot be saved. Mom is too far gone, Isaac is dead, and Satan is Satan (same logic applies to Moms's Heart/It Lives, ???, Lamb, Delirium, Mother, Ultra Greed(ier), Mother, Dogma, and the Beast).

When used in a devil room, all items become free for you to pick only one as usual with zero penalty (if he can even get inside, as Bethany and Peter require some tricky maneuvering to squeeze in deals).

X When used in an angel room, Isaac can summon a key piece so he doesn't have to challenge Gabriel and Uriel. Any further uses will give him an additional angel room item considering the luck required to get into one and the likely late game state he will be in to get to that point.
]]--




local mod = Furtherance
local game = Game()

local KTTKinCleared = false
local KTTKslot = ActiveSlot.SLOT_PRIMARY

function mod:UseKTTK(_, _, player, _, slot, _)
	local room = game:GetRoom()
	local roomType = room:GetType()
	local level = game:GetLevel()
	
	-- Free Devil items
	if roomType == RoomType.ROOM_DEVIL then
		player:UseCard(Card.CARD_CREDIT, 257) -- replace with gay lost type of free items
	
	-- Get key piece / random item in Angel room
	elseif roomType == RoomType.ROOM_ANGEL then
		if not player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_1) then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_1, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector.Zero, player)
		elseif not player:HasCollectible(CollectibleType.COLLECTIBLE_KEY_PIECE_2) then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_KEY_PIECE_2, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector.Zero, player)
		else -- Random item
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0, Isaac.GetFreeNearPosition(room:GetCenterPos(), 0), Vector.Zero, player)
		end
	
	-- Give the charge back if the room is cleared
	elseif room:IsClear() and not (roomType == RoomType.ROOM_CHALLENGE) then
		KTTKinCleared = true
		KTTKslot = slot
		return false
	
	-- Spare enemies in the room
	else
		for _, v in pairs(Isaac.GetRoomEntities()) do
			if v:IsActiveEnemy(false) and v:IsVulnerableEnemy() then
				if v:IsBoss() then -- Boss
					spareTimer = 30 * 30
					
				else
					local glow = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.GROUND_GLOW, 0, v.Position, Vector.Zero, player):ToEffect()
					glow:GetSprite().Scale = (v.Size / 15) * v.SizeMulti
					glow:GetSprite().PlaybackSpeed = 0.1
					local soul = Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 1, v.Position, Vector.Zero, player):ToEffect()
					soul:GetSprite():Play("Spared", true)
					
					SFXManager():Play(SoundEffect.SOUND_HOLY, 1.25)
					v:Remove()
					-- TODO: Give stats
				end
			end
		end
	end
	
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseKTTK, CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)


-- Give the charge back if the room is cleared
function mod:KTTKrecharge(player, flag)
	if KTTKinCleared then
		KTTKinCleared = false
		player:FullCharge(KTTKslot, true)
		SFXManager():Stop(SoundEffect.SOUND_BATTERYCHARGE)
		SFXManager():Stop(SoundEffect.SOUND_ITEMRECHARGE)
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.KTTKrecharge)


function mod:kttkKills(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM) then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 0, entity.Position, Vector.Zero, player):ToEffect()
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.kttkKills)


function mod:EnemySouls(effect)
	if effect.SubType == 0 then
		local sprite = effect:GetSprite()
		if not sprite:IsPlaying("Move") then
			sprite:Play("Move", true)
		end
		sprite.Offset = Vector(0,-14)
	
		for i = 0, game:GetNumPlayers() - 1 do
			local player = game:GetPlayer(i)
			local data = mod:GetData(player)
			
			effect.Velocity = (effect.Velocity + (((player.Position - effect.Position):Normalized() * 27) - effect.Velocity) * 0.45)
			
			sprite.Rotation = effect.Velocity:GetAngleDegrees() + 90

			-- Collect soul
			if effect.Position:DistanceSquared(player.Position) < 400 then
				data.Soul = true
				effect:Remove()
			end
			
			-- Get charge from soul
			if data.Soul == true then
				local slot = nil
				if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM then
					slot = ActiveSlot.SLOT_PRIMARY
				elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM then
					slot = ActiveSlot.SLOT_SECONDARY
				elseif player:GetActiveItem(ActiveSlot.SLOT_POCKET) == CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM then
					slot = ActiveSlot.SLOT_POCKET
				end
				
				if slot ~= nil then
					if player:GetActiveCharge(slot) < 12 then
						player:SetActiveCharge(player:GetActiveCharge(slot) + 1, slot)
						game:GetHUD():FlashChargeBar(player, slot)
						SFXManager():Play(SoundEffect.SOUND_BEEP)
						
						-- Play charged sound if soul charges it to max
						if player:GetActiveCharge(slot) >= 12 then
							SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
						end
						
					else
						game:GetHUD():FlashChargeBar(player, slot)
						SFXManager():Play(SoundEffect.SOUND_BATTERYCHARGE)
					end
					
					player:SetColor(Color(1,1,1, 1, 0.25,0.25,0.25), 5, 1, true, false)
					SFXManager():Play(SoundEffect.SOUND_SOUL_PICKUP)
				end
				
				data.Soul = false
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.EnemySouls, 7887)