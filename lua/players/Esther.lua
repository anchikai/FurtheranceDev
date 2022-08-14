local mod = Furtherance
local game = Game()

COSTUME_ESTHER_A_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_004_Esther_Hair.anm2")
COSTUME_ESTHER_B_HAIR = Isaac.GetCostumeIdByPath("gfx/characters/Character_004b_Esther_Hair.anm2")

local MIN_SPEED = 1.5
local MAX_SPEED = 2.5
local INVULN_SPEED = 2.0

local function clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

local function isEstherMoving(player)
	if player.Velocity:LengthSquared() > 0 and (Input.IsActionPressed(ButtonAction.ACTION_LEFT, player.ControllerIndex) or Input.IsActionPressed(ButtonAction.ACTION_RIGHT, player.ControllerIndex)
	or Input.IsActionPressed(ButtonAction.ACTION_UP, player.ControllerIndex) or Input.IsActionPressed(ButtonAction.ACTION_DOWN, player.ControllerIndex)) then
		return true
	else
		return false
	end
end

function mod:OnInit(player)
	if mod.IsContinued then return end

	local data = mod:GetData(player)
	data.Init = true

	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then -- If the player is Esther it will apply her hair
		player:AddNullCostume(COSTUME_ESTHER_A_HAIR)
		data.EstherSpeedGain = MIN_SPEED
		data.EstherCollideDebounce = 0
	elseif player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B then -- Apply different hair for her tainted variant
		player:AddNullCostume(COSTUME_ESTHER_B_HAIR)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnInit)

function mod:GiveEstherItems(player)
	local data = mod:GetData(player)
	if not data.Init then return end

	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		if player.FrameCount == 1 and not mod.IsContinued then

		elseif player.FrameCount > 1 then
			data.Init = nil
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B then
		if player.FrameCount == 1 and not mod.IsContinued then

		elseif player.FrameCount > 1 then
			data.Init = nil
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.GiveEstherItems)

function mod:EstherSpeed(player)
	local data = mod:GetData(player)
	if data.EstherSpeedGain == nil then return end

	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		if isEstherMoving(player) then
			data.EstherSpeedGain = data.EstherSpeedGain + 0.01
		else
			data.EstherSpeedGain = data.EstherSpeedGain - 0.04
		end
		data.EstherSpeedGain = clamp(data.EstherSpeedGain, MIN_SPEED, MAX_SPEED)
		player.MoveSpeed = data.EstherSpeedGain
		data.EstherCollideDebounce = math.max(data.EstherCollideDebounce - 1, 0)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.EstherSpeed)

function mod:EstherDamage(entity)
    local player = entity:ToPlayer()
    if player and player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
        if player.MoveSpeed >= 2 then
			return false
		end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.EstherDamage, EntityType.ENTITY_PLAYER)

function mod:EstherRamming(player, collider)
    if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		local data = mod:GetData(player)
        if player.MoveSpeed >= INVULN_SPEED and collider:IsActiveEnemy(false) and collider:IsVulnerableEnemy() then
			collider:TakeDamage(player.Damage/2, 0, EntityRef(player), 1)
		end
		if data.EstherCollideDebounce <= 0 then
			data.EstherSpeedGain = data.EstherSpeedGain - 0.15
			data.EstherCollideDebounce = 3
		end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, mod.EstherRamming)

function mod:EstherStats(player, flag)
	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		if flag == CacheFlag.CACHE_SPEED then
			player.MoveSpeed = player.MoveSpeed + 0.5
		end
		if flag == CacheFlag.CACHE_FIREDELAY then
			player.MaxFireDelay = player.MaxFireDelay + 1
		end
		if flag == CacheFlag.CACHE_RANGE then
			player.TearRange = player.TearRange - 60
		end
		if flag == CacheFlag.CACHE_LUCK then
			player.Luck = player.Luck + 1
		end
	elseif player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B then
		
	end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EstherStats)

function mod:ClickerFix(_, _, player)
	player:TryRemoveNullCostume(COSTUME_ESTHER_A_HAIR)
	player:TryRemoveNullCostume(COSTUME_ESTHER_B_HAIR)
	if player:GetPlayerType() == PlayerType.PLAYER_ESTHER then
		player:AddNullCostume(COSTUME_ESTHER_A_HAIR)
	elseif player:GetPlayerType() == PlayerType.PLAYER_ESTHER_B then
		player:AddNullCostume(COSTUME_ESTHER_B_HAIR)
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.ClickerFix, CollectibleType.COLLECTIBLE_CLICKER)


function mod:TaintedEstherHome()
	local level = game:GetLevel()
	local room = game:GetRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		if player:GetPlayerType() == PlayerType.PLAYER_ESTHER and level:GetCurrentRoomIndex() == 94 and level:GetStage() == LevelStage.STAGE8 and mod.Unlocks.Esther.Tainted ~= true then
			local RememberPocket = player:GetActiveCharge(ActiveSlot.SLOT_POCKET)
			for _, entity in ipairs(Isaac.GetRoomEntities()) do
				if (((entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_COLLECTIBLE)
				or (entity.Type == EntityType.ENTITY_SHOPKEEPER)) and room:IsFirstVisit())
				or (entity.Type == EntityType.ENTITY_SLOT and entity.Variant == 14) then
					entity:Remove()
					player:ChangePlayerType(PlayerType.PLAYER_ESTHER_B)
					Isaac.Spawn(EntityType.ENTITY_SLOT, 14, 0, entity.Position, Vector.Zero, nil)
					player:ChangePlayerType(PlayerType.PLAYER_ESTHER)
					-- player:SetPocketActiveItem(CollectibleType.COLLECTIBLE_, ActiveSlot.SLOT_POCKET, false)
					player:SetActiveCharge(RememberPocket, ActiveSlot.SLOT_POCKET)
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.TaintedEstherHome)

function mod:UnlockTaintedEsther(player)
	if player:GetPlayerType() ~= PlayerType.PLAYER_ESTHER or mod.Unlocks.Esther.Tainted then return end

	for _, entity in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT, 14)) do
		local sprite = entity:GetSprite()
		if sprite:IsFinished("PayPrize") then
			mod.Unlocks.Esther.Tainted = true
			GiantBookAPI.ShowAchievement("achievement_taintedesther.png")
			for _, poof in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.POOF01)) do
				poof:Remove()
			end
			break
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.UnlockTaintedEsther)