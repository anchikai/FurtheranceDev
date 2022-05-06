local mod = Furtherance
local game = Game()

local KTTKinCleared = false
local KTTKslot = ActiveSlot.SLOT_PRIMARY
local spareTime = 30 * 30
local finalBossIDs = { 6, 8, 24, 25, 39, 40, 54, 55, 63, 70, 88, 99, 100 }

local statObjs = {
	{ Name = "Damage", Flag = CacheFlag.CACHE_DAMAGE },
	{ Name = "FireDelay", Flag = CacheFlag.CACHE_FIREDELAY },
	{ Name = "TearRange", Flag = CacheFlag.CACHE_RANGE },
	{ Name = "ShotSpeed", Flag = CacheFlag.CACHE_SHOTSPEED },
	{ Name = "MoveSpeed", Flag = CacheFlag.CACHE_SPEED },
	{ Name = "Luck", Flag = CacheFlag.CACHE_LUCK }
}

local ALL_BUFFED_FLAGS = 0
for _, obj in ipairs(statObjs) do
	ALL_BUFFED_FLAGS = ALL_BUFFED_FLAGS | obj.Flag
end


-- Determine effect --
function checkForKTTK(enemy)
	if not ((enemy.Type == 79 and enemy.Variant == 20) or enemy.Type == 802 or (enemy.Type == 39 and enemy.Variant == 22) or (enemy.Type == 239 and enemy.Parent ~= nil)
	or ((enemy.Type == 35 or enemy.Type == 216 or enemy.Type == 228 or enemy.Type == 251 or enemy.Type == 311 or enemy.Type == 830 or enemy.Type == 865 or enemy.Type == 903) and enemy.Variant == 10)) then
		return true
	end
end


---@param player EntityPlayer
function mod:UseKTTK(_, _, player, _, slot, _)
	local data = mod:GetData(player)
	local room = game:GetRoom()
	local roomType = room:GetType()
	local level = game:GetLevel()
	local hasSpareTarget = false


	-- Free Devil items
	if roomType == RoomType.ROOM_DEVIL then
		-- TODO: only make one item takeable
		player:UseCard(Card.CARD_CREDIT, 257)


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
	elseif room:GetAliveEnemiesCount() == 0 then
		KTTKinCleared = true
		KTTKslot = slot
		return false


	else
		-- Give Holy Mantle effect in final boss rooms and don't do anything else
		for i, ID in pairs(finalBossIDs) do
			if room:GetBossID() == ID then
				player:UseCard(Card.CARD_HOLY, 257)
				return true
			end
		end

		local buffs = data.KTTKTempBuffs
		if buffs == nil then
			buffs = {}
			for i = 1, #statObjs do
				buffs[i] = 0
			end
			data.KTTKTempBuffs = buffs
		end

		for _, enemy in pairs(Isaac.GetRoomEntities()) do
			if enemy:IsActiveEnemy(false) and not enemy:IsInvincible() then -- This makes stonies and other fuckers not get spared so don't change it :)
				-- Spare timer for bosses
				if enemy:IsBoss() then
					if hasSpareTarget == false and not ((enemy.Type == 19 or enemy.Type == 62) and enemy.Parent ~= nil) and not enemy:GetData().spareTimer then
						enemy:GetData().spareTimer = spareTime
						
						-- Spotlight
						if not enemy:GetData().spareSpotlight then
							enemy:GetData().spareSpotlight = Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 200, enemy.Position, Vector.Zero, nil):ToEffect()
							enemy:GetData().spareSpotlight:GetSprite():Play("LightAppear", true)
							enemy:GetData().spareSpotlight:FollowParent(enemy)
							enemy:GetData().spareSpotlight.Parent = enemy
							enemy:GetData().spareSpotlight:GetSprite().Scale = Vector(0.75 + spareTime * 0.001, 1.25)
						end
						hasSpareTarget = true
					end

				
				-- Spare regular enemies
				elseif checkForKTTK(enemy) == true then
					Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.GROUND_GLOW, 0, enemy.Position, Vector.Zero, nil):ToEffect():GetSprite().PlaybackSpeed = 0.1
					Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 100, enemy.Position, Vector.Zero, nil):ToEffect()

					-- Remove segments if needed
					if enemy.Type == 239 then
						for i, segments in pairs(Isaac.GetRoomEntities()) do
							if segments.Type == enemy.Type and segments.Variant == enemy.Variant and segments:HasCommonParentWithEntity(enemy.Child) then
								segments:Die()
							end
						end
					else
						enemy:Remove()
					end

					-- Give stats
					local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)
					local buffChoice = rng:RandomInt(#statObjs) + 1
					buffs[buffChoice] = buffs[buffChoice] + 0.1
				end
			end
		end

		player:AddCacheFlags(ALL_BUFFED_FLAGS)
		player:EvaluateItems()
	end

	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseKTTK, CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)


-- Give the charge back if the room is cleared --
function mod:KTTKrecharge(player, flag)
	if KTTKinCleared then
		KTTKinCleared = false
		player:FullCharge(KTTKslot, true)
		SFXManager():Stop(SoundEffect.SOUND_BATTERYCHARGE)
		SFXManager():Stop(SoundEffect.SOUND_ITEMRECHARGE)
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.KTTKrecharge)


-- Stats --
function mod:KTTKbuffs(player, flag)
	local data = mod:GetData(player)
	if data.KTTKBuffs == nil then return end

	for i, buff in ipairs(data.KTTKBuffs) do
		local stat = statObjs[i]

		if stat.Flag == flag then
			player[stat.Name] = player[stat.Name] + buff
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.KTTKbuffs)


function mod:KTTKTempbuffs(player, flag)
	local data = mod:GetData(player)
	if data.KTTKTempBuffs == nil then return end

	for i, buff in ipairs(data.KTTKTempBuffs) do
		local stat = statObjs[i]

		if stat.Flag == flag then
			player[stat.Name] = player[stat.Name] + buff
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.KTTKTempbuffs)

function mod:removeKTTKTbuffs()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		
		data.KTTKTempBuffs = nil
		
		player:AddCacheFlags(ALL_BUFFED_FLAGS)
		player:EvaluateItems()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.removeKTTKTbuffs)


-- Spawn souls --
function mod:kttkKills(entity)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)

		if player:HasCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM) then
			if entity:IsBoss() then -- Bosses always give a soul with 3 charges
				Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 1, entity.Position, Vector.Zero, player):ToEffect()

			elseif entity:IsActiveEnemy(true) and checkForKTTK(entity) == true and not entity:IsInvincible() then
				local kttkRNG = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)
				
				if (kttkRNG:RandomInt(100) + 1) <= (entity.MaxHitPoints * 2.5) then -- Regular enemies have a chance to give a soul based on their Max HP
					Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 0, entity.Position, Vector.Zero, player):ToEffect()
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.kttkKills)


-- Effects --
function mod:EnemySouls(effect)
	local sprite = effect:GetSprite()

	-- Soul charge
	if effect.SubType == 0 or effect.SubType == 1 then
		local suffix = ""
		local charges = 1
		if effect.SubType == 1 then
			suffix = "Boss"
			charges = 3
		end
		
		if not sprite:IsPlaying("Move" .. suffix) then
			sprite:Play("Move" .. suffix, true)
		end
		sprite.Offset = Vector(0, -14)


		for i = 0, game:GetNumPlayers() - 1 do
			local player = game:GetPlayer(i)
			local data = mod:GetData(player)

			effect.Velocity = (effect.Velocity + (((player.Position - effect.Position):Normalized() * 20) - effect.Velocity) * 0.4)
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
						player:SetActiveCharge(player:GetActiveCharge(slot) + charges, slot)
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


	-- Rising soul
	elseif effect.SubType == 100 or effect.SubType == 101 then
		local suffix = ""
		local soundID = SoundEffect.SOUND_HOLY
		if effect.SubType == 101 then
			suffix = "Boss"
			soundID = SoundEffect.SOUND_DOGMA_ANGEL_TRANSFORM_END
		end
		
		if not sprite:IsPlaying("Spared" .. suffix) then
			sprite:Play("Spared" .. suffix, true)
		end
		if sprite:IsEventTriggered("Sound") then
			SFXManager():Play(soundID, 1.2)
		end
	
	
	-- Spotlight
	elseif effect.SubType == 200 then
		if not effect.Parent and not sprite:IsPlaying("LightDisappear") then
			sprite:Play("LightDisappear", true)
		end
	end
	
	
	-- Works on both spotlights and rising souls
	if sprite:IsEventTriggered("Remove") then
		effect:Remove()
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.EnemySouls, 7887)


-- Sparing --
function mod:spareTimer(entity)
	if entity:IsBoss() then
		local data = entity:GetData()

		-- Timer
		if data.spareTimer then
			data.spareSpotlight.DepthOffset = entity.DepthOffset - 1

			if data.spareTimer <= 0 then
				data.spared = true
				data.spareTimer = nil
				
			else
				-- Shrink spotlight, whiten boss
				data.spareTimer = data.spareTimer - 1
				data.whiteColoring = 0.45 - (data.spareTimer / 2000)
				
				data.spareSpotlight:GetSprite().Scale = Vector(0.75 + data.spareTimer * 0.001, 1.25)
				entity:SetColor(Color(1,1,1, 1, data.whiteColoring, data.whiteColoring, data.whiteColoring), 5, 1, true, false)
				
				-- Tint body segments
				if entity.Type == 19 or entity.Type == 62 then
					for i, segments in pairs(Isaac.GetRoomEntities()) do
						if segments.Type == entity.Type and segments.Variant == entity.Variant and segments:HasCommonParentWithEntity(entity.Child) then
							segments:SetColor(Color(1,1,1, 1, data.whiteColoring, data.whiteColoring, data.whiteColoring), 5, 1, true, false)
						end
					end
				end
				
				-- Extra coloring right before sparing
				if data.spareTimer <= 3 then
					entity:SetColor(Color(1,1,1, 1, 10,10,10), 10, 1, true, false)
					SFXManager():Play(SoundEffect.SOUND_DOGMA_GODHEAD, 0.75, 0, false, 1.1, 0)
				elseif data.spareTimer <= 5 then
					entity:SetColor(Color(1,1,1, 1, 0.75,0.75,0.75), 10, 1, true, false)
				end
			end
		
		
		-- Spared
		elseif data.spared == true then
			Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.GROUND_GLOW, 0, entity.Position, Vector.Zero, nil):ToEffect():GetSprite().PlaybackSpeed = 0.1
			Isaac.Spawn(EntityType.ENTITY_EFFECT, 7887, 101, entity.Position, Vector.Zero, nil):ToEffect()
			data.spareSpotlight:GetSprite():Play("LightDisappear", true)
			
			-- CUNT
			if entity.Type == 19 or entity.Type == 62 or (entity.Type == 79 and entity.Variant == 0) then
				local checkVar = entity.Variant
				if entity.Type == 79 then
					checkVar = 20
				end
				
				for _, removee in pairs(Isaac.GetRoomEntities()) do
					if removee.Type == entity.Type and removee.Variant == checkVar and removee:HasCommonParentWithEntity(entity.Child) then
						removee:Remove()
					end
				end
			end

			-- Properly kill the boss without playing the death animation (just removing it causes certain things to not work)
			entity:AddEntityFlags(EntityFlag.FLAG_NO_BLOOD_SPLASH)
			entity:Die()
			entity:GetSprite():SetFrame("Death", 99)
			entity.Visible = false
			
			-- Give stats
			for i = 0, game:GetNumPlayers() - 1 do
				local player = game:GetPlayer(i)

				if player:HasCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM) then
					local pdata = mod:GetData(player)
					local buffs = pdata.KTTKBuffs
					if buffs == nil then
						buffs = {}
						for i = 1, #statObjs do
							buffs[i] = 0
						end
						pdata.KTTKBuffs = buffs
					end

					local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM)
					local buffChoice = rng:RandomInt(#statObjs) + 1
					buffs[buffChoice] = buffs[buffChoice] + 0.5

					player:AddCacheFlags(ALL_BUFFED_FLAGS)
					player:EvaluateItems()
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.spareTimer)


function mod:spareResetBoss(target, damageAmount, damageFlags, damageSource, damageCountdownFrames)
	if target:IsBoss() then
		local data = target:GetData()
		if data.spareTimer and data.spareTimer > 0 and damageSource.Entity then -- TODO: make bosses hurting themselves not reset timer (checking damageSource doesn't work because Isaac API)
			data.spareTimer = spareTime
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.spareResetBoss)

function mod:spareResetPlayer(target, damageAmount, damageFlags, damageSource, damageCountdownFrames)
	if damageSource.Entity and damageSource.Entity:IsBoss() then
		local spareCancel = false
		local data = nil
		if damageSource.Entity:GetData().spareTimer then
			data = damageSource.Entity:GetData()
			spareCancel = true
		elseif damageSource.Entity.SpawnerEntity and damageSource.Entity.SpawnerEntity:GetData().spareTimer then
			data = damageSource.Entity.SpawnerEntity:GetData()
			spareCancel = true
		end
		
		if spareCancel == true then
			data.spareTimer = nil
			data.spareSpotlight:GetSprite():Play("LightDisappear", true)
			data.spareSpotlight = nil
			SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN, 1.35, 0, false, 0.9, 0)
			SFXManager():Play(SoundEffect.SOUND_BISHOP_HIT, 1.5)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.spareResetPlayer, EntityType.ENTITY_PLAYER)