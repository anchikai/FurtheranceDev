local mod = Furtherance
local game = Game()

function mod:UseAceOfShields(card, player, useflags)
	local data = mod:GetData(player)
	local room = game:GetRoom()
	for i, entity in ipairs(Isaac.GetRoomEntities()) do
		if (entity.Type == EntityType.ENTITY_PICKUP and entity.Variant ~= 100 and entity.Variant ~= 150 and entity.Variant ~= 340 and entity.Variant ~= 370 and entity.Variant ~= 380 and entity.Variant ~= 390 and entity.Variant ~= 41) or (entity:IsActiveEnemy(false) and entity:IsDead() == false and entity:IsVulnerableEnemy()) then
			entity:ToPickup():Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MICRO)
		end
		entity.Velocity = Vector.Zero
		room:SetClear(true)
	end
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseAceOfShields, CARD_ACE_OF_SHIELDS)