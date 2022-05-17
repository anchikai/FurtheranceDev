local mod = Furtherance
local game = Game()

function mod:CollectCoin(pickup, collider)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = Isaac.GetPlayer(i)
		local goldenbox = player:GetTrinketMultiplier(TrinketType.TRINKET_ABYSSAL_PENNY)
		if player:HasTrinket(TrinketType.TRINKET_ABYSSAL_PENNY, false) then
			if collider.Type == EntityType.ENTITY_PLAYER then
				if pickup.SubType ~= CoinSubType.COIN_STICKYNICKEL then
					local Water = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_HOLYWATER, 0, pickup.Position, Vector.Zero, player)
					local sprite = Water:GetSprite()
					sprite.Scale = Vector.Zero
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.CollectCoin, PickupVariant.PICKUP_COIN)