local mod = further
local game = Game()
local rng = RNG()

normalPeter = Isaac.GetPlayerTypeByName("Peter", false)
taintedPeter = Isaac.GetPlayerTypeByName("PeterB", true)

COSTUME_PETER_A_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002_Peter_Drip.anm2")
COSTUME_PETER_B_DRIP = Isaac.GetCostumeIdByPath("gfx/characters/Character_002b_Peter_Drip.anm2")

function mod:OnInit(player)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then -- If the player is Peter it will apply his drip
		if data.DevilCount == nil or data.AngelCount == nil then
			data.DevilCount = 0
			data.AngelCount = 0
		end
		player:AddNullCostume(COSTUME_PETER_A_DRIP)
		costumeEquipped = true
		player:AddTrinket(TrinketType.TRINKET_ALABASTER_SCRAP, FirstTimePickingUp)
		player:AddCollectible(CollectibleType.COLLECTIBLE_KEYS_TO_THE_KINGDOM, 6, true, ActiveSlot.SLOT_PRIMARY)
		player:SetActiveCharge(12, ActiveSlot.SLOT_PRIMARY)
	elseif player:GetName() == "PeterB" then -- Apply different drip for his tainted variant
		player:AddNullCostume(COSTUME_PETER_B_DRIP)
		costumeEquipped = true
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:PeterUpdate(player)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then
		
	elseif player:GetName() == "PeterB" then
		
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.PeterUpdate)

function mod:PeterStats(player, flag)
	local data = mod:GetData(player)
	if player:GetName() == "Peter" then -- If the player is Peter it will apply his stats
		if flag & CacheFlag.CACHE_SPEED == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + 0.1
		end
		if flag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay - 3
		end
		if flag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
			player.Damage = player.Damage * 0.5 + 1.25
		end
		if flag & CacheFlag.CACHE_RANGE == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - 110
		end
		if flag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
			player.ShotSpeed = player.ShotSpeed + 0.15
		end
		if data.AngelCount > data.DevilCount then -- Peter's stat modifiers for when he has more angel rooms
			if flag & CacheFlag.CACHE_FLYING == CacheFlag.CACHE_FLYING then
				player.CanFly = true
				player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_REVELATION, true)
			end
			if flag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
				player.Damage = player.Damage + data.AngelCount * 1.25
			end
			if flag & CacheFlag.CACHE_SHOTSPEED == CacheFlag.CACHE_SHOTSPEED then
				player.ShotSpeed = player.ShotSpeed - data.AngelCount * 0.1
			end
		end
	elseif player:GetName() == "PeterB" then -- If the player is Tainted Peter it will apply his stats
		
	end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.PeterStats)

function mod:AngelDevil()
	local room = game:GetRoom()
	local roomType = room:GetType()
	local level = game:GetLevel()
	for i = 0, game:GetNumPlayers() - 1 do
        local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:GetName() == "Peter" then
			if roomType == RoomType.ROOM_DEVIL and room:IsFirstVisit() then
				data.DevilCount = data.DevilCount + 1
			end
			if roomType == RoomType.ROOM_ANGEL and room:IsFirstVisit() then
				data.AngelCount = data.AngelCount + 1
			end
			player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
			player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
			player:AddCacheFlags(CacheFlag.CACHE_SHOTSPEED)
			player:AddCacheFlags(CacheFlag.CACHE_FLYING)
			player:EvaluateItems()
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.AngelDevil)

function mod:shouldDeHook()
	local reqs = {
	  not game:GetHUD():IsVisible(),
	  game:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)
	}
	return reqs[1] or reqs[2]
end

mod:AddCallback(ModCallbacks.MC_POST_RENDER, function() -- Peter's Devil/Angel indicator
	if mod:shouldDeHook() then return end
	local offset = Options.HUDOffset * Vector(20, 12)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
		if player:GetName() == "Peter" then
			local f = Font()
			f:Load("font/luaminioutlined.fnt")
			if game:GetNumPlayers() == 1 then
				coopOffset = 0
			else
				coopOffset = 12
			end
			f:DrawString(data.DevilCount, 44 + offset.X, 161 + offset.Y + coopOffset, KColor(1, 1, 1, 0.4, 0, 0, 0), 0, true)
			f:DrawString(data.AngelCount, 44 + offset.X, 173 + offset.Y + coopOffset*1.2, KColor(1, 1, 1, 0.4, 0, 0, 0), 0, true)
		end
	end
end
)