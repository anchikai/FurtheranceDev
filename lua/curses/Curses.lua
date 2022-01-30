local mod = further
local game = Game()
local rng = RNG()
local bhb = Isaac.GetSoundIdByName("BrokenHeartbeat")

LightBeam = Isaac.GetEntityTypeByName("Light Beam")
LightBeamVar = Isaac.GetEntityVariantByName("Light Beam")

local curse = {
	BLESSING_LIGHT = 1 << (Isaac.GetCurseIdByName("Blessing of Light!") - 1),
	BLESSING_ORDER = 1 << (Isaac.GetCurseIdByName("Blessing of Order!") - 1),
	BLESSING_FOUND = 1 << (Isaac.GetCurseIdByName("Blessing of the Found!") - 1),
	BLESSING_KNOWN = 1 << (Isaac.GetCurseIdByName("Blessing of the Known!") - 1),
	BLESSING_UNHINGED = 1 << (Isaac.GetCurseIdByName("Blessing of the Unhinged!") - 1),
	BLESSING_SIGHTED = 1 << (Isaac.GetCurseIdByName("Blessing of the Sighted!") - 1),
	BLESSING_TRIUMPH = 1 << (Isaac.GetCurseIdByName("Blessing of Triumph!") - 1),
	CURSE_SORROW = 1 << (Isaac.GetCurseIdByName("Curse of Sorrow!") - 1)
}

function mod:NewRoomBlessings()
	local room = game:GetRoom()
	local level = game:GetLevel()
	for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		if level:GetCurses() & curse.BLESSING_UNHINGED > 0 and room:IsClear() == false  then												-- Blessing of the Unhinged Effect
			player:UseActiveItem(CollectibleType.COLLECTIBLE_DADS_KEY, false, false, true, false, -1)
			SFXManager():Stop(SoundEffect.SOUND_GOLDENKEY)
			SFXManager():Stop(SoundEffect.SOUND_UNLOCK00)
		end
	end
	if level:GetCurses() & curse.BLESSING_LIGHT > 0 and (room:GetType() == RoomType.ROOM_TREASURE or room:GetType() == RoomType.ROOM_LIBRARY or room:GetType() == RoomType.ROOM_PLANETARIUM) and room:IsFirstVisit() == true then	-- Blessing of Light Effect
		beam = Isaac.Spawn(LightBeam, LightBeamVar, 0, room:GetGridPosition(52), Vector.Zero, nil)
		local sprite = beam:GetSprite()
		sprite:Load("gfx/lightbeam.anm2", true)
		sprite:Play("Appear", true)
	end
	if level:GetCurses() & curse.BLESSING_SIGHTED > 0 and room:GetType() == RoomType.ROOM_SUPERSECRET and room:IsFirstVisit() == true then	-- Blessing of the Sighted Effect
		instance = game:Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, room:GetGridPosition(97), Vector(0, 0), nil, 0, room:GetSpawnSeed())
		instance:ToPickup().ShopItemId = -1
		instance:ToPickup().Price = 15
		instance:ToPickup().AutoUpdatePrice = false
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.NewRoomBlessings)

function mod:BlessingLight(entity, collider)
	for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if collider.Type == EntityType.ENTITY_PLAYER then
			if entity.Type == LightBeam and entity.Variant == LightBeamVar then
				sprite = entity:GetSprite()
				sprite:Load("gfx/lightbeam.anm2", true)
				sprite:Play("Disappear", true)
				SFXManager():Play(SoundEffect.SOUND_POWERUP1)
				entity:Die()
				data.LightTimer = 30
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.BlessingLight)

function mod:RoomClearBlessings()
	local level = game:GetLevel()
	local room = game:GetRoom()
	if room:IsCurrentRoomLastBoss() and level:GetCurses() & curse.BLESSING_ORDER > 0 then
		choice1 = game:GetItemPool():GetCollectible(ItemPoolType.POOL_DEVIL, false, room:GetSpawnSeed())
		choice2 = game:GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL, false, room:GetSpawnSeed())
		devil = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, choice1, room:GetGridPosition(81), Vector(0, 0), nil)
		angel = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, choice2, room:GetGridPosition(83), Vector(0, 0), nil)
		devil:ToPickup().ShopItemId = -1
		angel:ToPickup().ShopItemId = -1
		devil:ToPickup().Price = PickupPrice.PRICE_SPIKES
		angel:ToPickup().Price = 15
		devil:ToPickup().AutoUpdatePrice = false
		angel:ToPickup().AutoUpdatePrice = false
		devil:ToPickup().OptionsPickupIndex = 1
		angel:ToPickup().OptionsPickupIndex = 1
	end
	if room:IsCurrentRoomLastBoss() and level:GetCurses() & curse.BLESSING_TRIUMPH > 0 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_OLDCHEST, ChestSubType.CHEST_CLOSED, room:GetGridPosition(67), Vector(0, 0), nil)
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.RoomClearBlessings)

function mod:CurseUpdate(player)
	local level = game:GetLevel()
	local data = mod:GetData(player)
	if data.IsSpecialRoom == nil then
		data.IsSpecialRoom = false
	end
	if level:GetCurses() & curse.CURSE_SORROW > 0 then
		if data.SorrowPower == nil then
			data.SorrowPower = 0
		elseif data.SorrowPower < 0 then
			data.SorrowPower = 0
		end
		if not IsEnemyNear(player) then
			data.SorrowPower = data.SorrowPower - 1
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:EvaluateItems()
		else
			if player.MaxFireDelay <= 28.75 then
				data.SorrowPower = data.SorrowPower + 1
				player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
				player:EvaluateItems()
			end
		end
	end
	if data.LightTimer == nil then
		data.LightTimer = 0
	end
	if data.LightTimer > 0 then
		data.LightTimer = data.LightTimer - 1
	end
	if data.LightTimer < 0 then
		data.LightTimer = 0
	end
	if data.LightTimer == 1 then
		SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER)
		player:AddHearts(2)
		data.LightCount = data.LightCount + 1
		data.LightCountDMG = data.LightCountDMG + 1
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:AddCacheFlags(CacheFlag.CACHE_SPEED)
		player:EvaluateItems()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.CurseUpdate)

function mod:BlessingLight(player, flag)
	local level = game:GetLevel()
	local data = mod:GetData(player)
	if level:GetCurses() & curse.BLESSING_LIGHT > 0 then
		if data.LightCount == nil then
			data.LightCount = 0
		end
		if data.LightCountDMG == nil then
			data.LightCountDMG = 0
		end
		if flag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage + data.LightCountDMG * 0.25
		end
		if flag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + data.LightCount * 0.1
		end
	end
	if level:GetCurses() & curse.CURSE_SORROW > 0 then
		if data.SorrowPower == nil then
			data.SorrowPower = 0
		end
		if flag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			if data.SorrowPower > 0 then
				for power = 1, data.SorrowPower do
					if player.MaxFireDelay <= 28.75 then
						player.MaxFireDelay = player.MaxFireDelay * 1.01
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.BlessingLight)

function mod:AddCurse()
	local level = game:GetLevel()
	local extraBirthrightBlessing = ExtraBirthright and ExtraBirthright.HasBlessing() or nil
	if (level:GetCurses() == 0 or extraBirthrightBlessing) and level:IsAscent() == false then
		local PickCurse = rng:RandomInt(8)
		local room = game:GetRoom()
		for i = 0, game:GetNumPlayers() - 1 do
			local player = game:GetPlayer(i)
			if rng:RandomInt(4) == 0 then
				if PickCurse == 0 then
					level:AddCurse(curse.BLESSING_LIGHT)
				elseif PickCurse == 1 then
					level:AddCurse(curse.BLESSING_ORDER)
				elseif PickCurse == 2 then
					level:AddCurse(curse.BLESSING_FOUND)
					level:ApplyMapEffect()
				elseif PickCurse == 3 then
					level:AddCurse(curse.BLESSING_KNOWN)
					level:ApplyCompassEffect()
				elseif PickCurse == 4 then
					level:AddCurse(curse.BLESSING_UNHINGED)
				elseif PickCurse == 5 then
					level:AddCurse(curse.BLESSING_SIGHTED)
					level:ApplyBlueMapEffect()
				elseif PickCurse == 6 then
					level:AddCurse(curse.BLESSING_TRIUMPH)
				elseif PickCurse == 7 and not player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
					level:AddCurse(curse.CURSE_SORROW)
				end
				if ExtraBirthright then
					local curse = level:GetCurses()
					for i = 1, #ExtraBirthright.LevelBlessing.Blessings do
						if ExtraBirthright.LevelBlessing.CheckFlag(curse, ExtraBirthright.LevelBlessing.GetId(ExtraBirthright.LevelBlessing.Blessings[i])) then
							level:RemoveCurses(ExtraBirthright.LevelBlessing.GetFlag(ExtraBirthright.LevelBlessing.GetId(ExtraBirthright.LevelBlessing.Blessings[i])))
						end
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.AddCurse)

function mod:RemoveDMG()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		data.LightCountDMG = 0
		player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
		player:EvaluateItems()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.RemoveDMG)