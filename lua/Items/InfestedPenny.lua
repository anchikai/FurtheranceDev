local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:CollectCoin(pickup, collider)
	for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
		local goldenbox = player:GetTrinketMultiplier(TrinketType.TRINKET_INFESTED_PENNY)
		if player:HasTrinket(TrinketType.TRINKET_INFESTED_PENNY, false) then
			if collider.Type == EntityType.ENTITY_PLAYER then
				if pickup.SubType == CoinSubType.COIN_PENNY or pickup.SubType == CoinSubType.COIN_NICKEL or pickup.SubType == CoinSubType.COIN_DIME or pickup.SubType == CoinSubType.COIN_DOUBLEPACK or pickup.SubType == CoinSubType.COIN_LUCKYPENNY or pickup.SubType == CoinSubType.COIN_GOLDEN then
					if (goldenbox > 2 or goldenbox > 4) then		-- Golden Trinket + Mom's Box
						Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, 0, player.Position, Vector.Zero, player)
						Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, 0, player.Position, Vector.Zero, player)
						Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, 0, player.Position, Vector.Zero, player)
					elseif goldenbox > 1 and goldenbox < 3 then		-- Golden Trinket or Mom's Box
						Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, 0, player.Position, Vector.Zero, player)
						Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER, 0, player.Position, Vector.Zero, player)
					elseif goldenbox < 2 then						-- Normal Trinket
						player:AddBlueSpider(player.Position)
					end
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.CollectCoin)