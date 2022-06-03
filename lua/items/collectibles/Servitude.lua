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
	if data.ServitudeCounter == 0 then
		data.CurrentServitudeItem = getNearestCollectible(player).SubType
		data.ServitudeCounter = 7
	end
	return true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseServitude, CollectibleType.COLLECTIBLE_SERVITUDE)

function mod:ServitudeRoom(rng, pos)
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		local data = mod:GetData(player)
		local ServitudeSlot
		if player:GetActiveItem(ActiveSlot.SLOT_PRIMARY) == CollectibleType.COLLECTIBLE_SERVITUDE then
			ServitudeSlot = ActiveSlot.SLOT_PRIMARY
		elseif player:GetActiveItem(ActiveSlot.SLOT_SECONDARY) == CollectibleType.COLLECTIBLE_SERVITUDE then
			ServitudeSlot = ActiveSlot.SLOT_SECONDARY
		elseif player:GetActiveItem(ActiveSlot.SLOT_POCKET) == CollectibleType.COLLECTIBLE_SERVITUDE then
			ServitudeSlot = ActiveSlot.SLOT_POCKET
		end
		if data.ServitudeCounter > 0 then
			player:SetActiveCharge(player:GetActiveCharge(ServitudeSlot)-1, ServitudeSlot)
			SFXManager():Stop(SoundEffect.SOUND_BEEP)
			SFXManager():Stop(SoundEffect.SOUND_BATTERYCHARGE)
			SFXManager():Stop(SoundEffect.SOUND_ITEMRECHARGE)
			data.ServitudeCounter = data.ServitudeCounter - 1
			if data.ServitudeCounter == 0 then
				Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, data.CurrentServitudeItem, Isaac.GetFreeNearPosition(player.Position, 40), Vector.Zero, player)
				data.CurrentServitudeItem = 0
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.ServitudeRoom)

function mod:ResetServitude(entity, amount, flag)
    local player = entity:ToPlayer()
	local data = mod:GetData(player)
    if data.ServitudeCounter > 0 and flag & DamageFlag.DAMAGE_NO_PENALTIES ~= DamageFlag.DAMAGE_NO_PENALTIES then
        data.ServitudeCounter = 0
        data.CurrentServitudeItem = 0
		SFXManager():Play(SoundEffect.SOUND_THUMBS_DOWN)
		player:AddBrokenHearts(1)
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.ResetServitude, EntityType.ENTITY_PLAYER)

function mod:shouldDeHook()
	local reqs = {
	  not game:GetHUD():IsVisible(),
	  game:GetSeeds():HasSeedEffect(SeedEffect.SEED_NO_HUD)
	}
	return reqs[1] or reqs[2]
end

function mod:ServitudeCounter(player)
	local data = mod:GetData(player)
	local room = game:GetRoom()
	if mod:shouldDeHook() then return end

	if data.ServitudeCounter == nil then
		data.ServitudeCounter = 0
	end
	if data.ServitudeCounter > 0 then
		local f = Font()
		local WorldToScreen = room:WorldToScreenPosition(player.Position, Vector.Zero, Vector.Zero)
		f:Load("font/pftempestasevencondensed.fnt")
		f:DrawString(data.ServitudeCounter, WorldToScreen.X - 2, WorldToScreen.Y, KColor(1, 1, 1, 1), 0, false)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_RENDER, mod.ServitudeCounter)

function mod:ServitudeTarget(pickup)
	local room = game:GetRoom()
	for p = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(p)
		local data = mod:GetData(player)
		if mod:shouldDeHook() then return end

		if player:HasCollectible(CollectibleType.COLLECTIBLE_SERVITUDE) and getNearestCollectible(player) ~= nil and data.ServitudeCounter == 0 then
			local item = getNearestCollectible(player)
			local sprite = Sprite()
			sprite:Load("gfx/spiritual_wound_target.anm2", true)
			sprite:Play("Idle", true)
			sprite:Render(room:WorldToScreenPosition(item.Position, Vector.Zero, Vector.Zero))
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, mod.ServitudeTarget)