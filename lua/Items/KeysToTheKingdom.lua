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
]] --

local mod = Furtherance
local game = Game()

local KTTKinCleared = false
local KTTKslot = ActiveSlot.SLOT_PRIMARY

local statObjs = {
	{ Name = "Damage", Flag = CacheFlag.CACHE_DAMAGE },
	{ Name = "FireDelay", Flag = CacheFlag.CACHE_FIREDELAY },
	{ Name = "TearRange", Flag = CacheFlag.CACHE_RANGE },
	{ Name = "ShotSpeed", Flag = CacheFlag.CACHE_SHOTSPEED },
	{ Name = "MoveSpeed", Flag = CacheFlag.CACHE_SPEED },
	{ Name = "Luck", Flag = CacheFlag.CACHE_LUCK },
}

local ALL_BUFFED_FLAGS = 0
for _, obj in ipairs(statObjs) do
	ALL_BUFFED_FLAGS = ALL_BUFFED_FLAGS | obj.Flag
end

---@param player EntityPlayer
function mod:UseKTTK(_, _, player, _, slot, _)
	local data = mod:GetData(player)
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
	elseif room:GetAliveEnemiesCount() == 0 and roomType ~= RoomType.ROOM_CHALLENGE then
		KTTKinCleared = true
		KTTKslot = slot
		return false

		-- Spare enemies in the room
	else
		local buffs = data.KTTKBuffs
		if buffs == nil then
			buffs = {}
			for i = 1, #statObjs do
				buffs[i] = 0
			end
			data.KTTKBuffs = buffs
		end

		local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)

		for _, enemy in pairs(Isaac.GetRoomEntities()) do
			if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy(false) then
				if enemy:IsBoss() then -- Boss
					spareTimer = 30 * 30

				else
					local glow = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.GROUND_GLOW, 0, enemy.Position, Vector.Zero, player):ToEffect()
					glow:GetSprite().Scale = (enemy.Size / 15) * enemy.SizeMulti
					glow:GetSprite().PlaybackSpeed = 0.1
					local soul = Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 1, enemy.Position, Vector.Zero, player):ToEffect()
					soul:GetSprite():Play("Spared", true)

					SFXManager():Play(SoundEffect.SOUND_HOLY, 1.25)
					enemy:Remove()

					-- TODO: Give stats
					local buffChoice = rng:RandomInt(#statObjs) + 1
					buffs[buffChoice] = buffs[buffChoice] + 0.1

					if data.SpareCount == nil then
						data.SpareCount = 0
					else
						data.SpareCount = data.SpareCount + 1
					end
				end
			end
		end

		player:AddCacheFlags(ALL_BUFFED_FLAGS)
		player:EvaluateItems()
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

function mod:KTTKbuffs(player, flag)
	local data = mod:GetData(player)
	for i, buff in ipairs(data.KTTKBuffs) do
		local stat = statObjs[i]

		if stat.Flag == flag then
			player[stat.Name] = player[stat.Name] + buff
			break
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.KTTKbuffs)

function mod:kttkKills(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)

		if player:HasCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM) then
			local kttkRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)

			if entity:IsBoss() then
				-- give more or something idk
			elseif (kttkRNG:RandomInt(100) + 1) <= (entity.MaxHitPoints * 3) then
				Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 0, entity.Position, Vector.Zero, player):ToEffect()
			end
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
		sprite.Offset = Vector(0, -14)

		for i = 0, game:GetNumPlayers() - 1 do
			local player = game:GetPlayer(i)
			local data = mod:GetData(player)

			effect.Velocity = (effect.Velocity + (((player.Position - effect.Position):Normalized() * 25) - effect.Velocity) * 0.4)
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

					player:SetColor(Color(1, 1, 1, 1, 0.25, 0.25, 0.25), 5, 1, true, false)
					SFXManager():Play(SoundEffect.SOUND_SOUL_PICKUP)
				end

				data.Soul = false
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.EnemySouls, 7887)

function mod:ResetKeys(continued)
	if continued == false then
		for i = 0, game:GetNumPlayers() - 1 do
			local player = game:GetPlayer(i)
			local data = mod:GetData(player)
			data.SpareCount = 0
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.ResetKeys)
