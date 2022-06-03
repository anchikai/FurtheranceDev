local mod = Furtherance
local game = Game()

mod:SavePlayerData({
	CurrentServitudeItem = 0,
	ServitudeCounter = 0,
})

local function getNearestCollectible(player)
	local nearestCollectible = nil
	local nearestDistance = math.huge

	for _, collectible in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
		local delta = (player.Position - collectible.Position)
		local distance = delta:LengthSquared()
		if collectible.SubType ~= CollectibleType.COLLECTIBLE_NULL then
			if distance < nearestDistance then
				nearestDistance = distance
				nearestCollectible = collectible
			end
		end
	end

	return nearestCollectible
end

function mod:UseServitude(_, _, player)
	local data = mod:GetData(player)
	local item = getNearestCollectible(player)

	if item and data.ServitudeCounter == 0 then
		data.CurrentServitudeItem = item.SubType
		data.ServitudeCounter = 7
		return { Discharge = true, ShowAnim = true, Remove = false }
	else
		return { Discharge = false, ShowAnim = false, Remove = false }
	end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseServitude, CollectibleType.COLLECTIBLE_SERVITUDE)

local function getActiveSlot(player, collType)
	for _, slot in pairs(ActiveSlot) do
		if player:GetActiveItem(slot) == collType then
			return slot
		end
	end

	return nil
end

local function decrementServitudeCounter(player)
	local data = mod:GetData(player)
	if data.ServitudeCounter == nil or data.ServitudeCounter == 0 then return end

	local ServitudeSlot = getActiveSlot(player, CollectibleType.COLLECTIBLE_SERVITUDE)
	if ServitudeSlot == nil then return end

	player:SetActiveCharge(player:GetActiveCharge(ServitudeSlot) - 1, ServitudeSlot)

	SFXManager():Stop(SoundEffect.SOUND_BEEP)
	SFXManager():Stop(SoundEffect.SOUND_BATTERYCHARGE)
	SFXManager():Stop(SoundEffect.SOUND_ITEMRECHARGE)

	data.ServitudeCounter = data.ServitudeCounter - 1
	if data.ServitudeCounter == 0 then
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, data.CurrentServitudeItem, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
		data.CurrentServitudeItem = 0
	end
end

function mod:ServitudeRoom(rng, pos)
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		decrementServitudeCounter(player)
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.ServitudeRoom)

function mod:ResetServitude(entity, amount, flag)
	local player = entity:ToPlayer()
	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_SERVITUDE) and data.ServitudeCounter > 0 and flag & DamageFlag.DAMAGE_NO_PENALTIES == 0 then
		data.ServitudeCounter = 0
		data.CurrentServitudeItem = 0
		SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
		player:AddBrokenHearts(1)
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.ResetServitude, EntityType.ENTITY_PLAYER)

function mod:shouldDeHook()
	return not game:GetHUD():IsVisible() or game:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)
end

function mod:ServitudeCounter(player)
	local data = mod:GetData(player)
	local room = game:GetRoom()
	if mod:shouldDeHook() then return end

	data.ServitudeCounter = data.ServitudeCounter or 0
	if data.ServitudeCounter > 0 then
		local f = Font()
		local WorldToScreen = room:WorldToScreenPosition(player.Position, Vector.Zero, Vector.Zero)
		f:Load("font/pftempestasevencondensed.fnt")
		f:DrawString(data.ServitudeCounter, WorldToScreen.X - 2, WorldToScreen.Y, KColor(1, 1, 1, 1), 0, false)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mod.ServitudeCounter)

function mod:ServitudeTarget(pickup)
	if mod:shouldDeHook() then return end

	local room = game:GetRoom()
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		local data = mod:GetData(player)

		local item = getNearestCollectible(player)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_SERVITUDE) and item ~= nil and data.ServitudeCounter == 0 then

			local sprite = Sprite()
			sprite:Load("gfx/spiritual_wound_target.anm2", true)
			sprite:Play("Idle", true)
			sprite:Render(room:WorldToScreenPosition(item.Position, Vector.Zero, Vector.Zero))
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, mod.ServitudeTarget)

function mod:RemoveCharge()

end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.RemoveCharge)

local activeSlots = {
	ActiveSlot.SLOT_PRIMARY,
	ActiveSlot.SLOT_SECONDARY,
	ActiveSlot.SLOT_POCKET,
	ActiveSlot.SLOT_POCKET2,
}

local batteryCharges = {
	[BatterySubType.BATTERY_MICRO] = 2,
	[BatterySubType.BATTERY_NORMAL] = 6,
	[BatterySubType.BATTERY_GOLDEN] = 6,
	[BatterySubType.BATTERY_MEGA] = 24
}

---@param battery EntityPickup
---@param collider Entity
function mod:IgnoreBatteries(battery, collider)

	local player = collider and collider:ToPlayer()
	if player == nil then return end

	local data = mod:GetData(player)
	if player:HasCollectible(CollectibleType.COLLECTIBLE_SERVITUDE) and data.ServitudeCounter > 0 then
		local propagateCharge
		for i, slot in ipairs(activeSlots) do
			local item = player:GetActiveItem(slot)
			if item == CollectibleType.COLLECTIBLE_SERVITUDE then
				-- we still need to move the charge to a later item though!
				propagateCharge = i + 1
				break
			elseif item ~= CollectibleType.COLLECTIBLE_SERVITUDE and item ~= CollectibleType.COLLECTIBLE_NULL and player:NeedsCharge(slot) then
				return nil -- Don't ignore the collision if an item BEFORE Servitude needs a charge
			end
		end

		if propagateCharge then
			for i = propagateCharge, #activeSlots do
				local slot = activeSlots[i]
				local item = player:GetActiveItem(slot)
				if item ~= CollectibleType.COLLECTIBLE_SERVITUDE and item ~= CollectibleType.COLLECTIBLE_NULL and player:NeedsCharge(slot) then
					local charges = batteryCharges[battery.SubType]
					player:SetActiveCharge(player:GetActiveCharge(slot) + charges, slot)
				end
			end
		end

		return false
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.IgnoreBatteries, PickupVariant.PICKUP_LIL_BATTERY)
