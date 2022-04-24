local mod = Furtherance
local game = Game()

function mod:UseAceOfShields(card, player, useflags)
	local data = mod:GetData(player)
	local room = game:GetRoom()
	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		if entity.Type == EntityType.ENTITY_PICKUP then
			entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MICRO)
		elseif entity:IsActiveEnemy(false) and entity:IsDead() == false and entity:IsVulnerableEnemy() then
			entity:ToNPC():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MICRO, -1)
			room:SetClear(true)
		end
		entity.Velocity = Vector.Zero
	end
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseAceOfShields, CARD_ACE_OF_SHIELDS)