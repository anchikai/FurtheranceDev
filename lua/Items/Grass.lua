local mod = Furtherance
local game = Game()
local laugh = Isaac.GetSoundIdByName("Sitcom_Laugh_Track")

function mod:Grass(player)
	local data = mod:GetData(player)
	local goldenbox = player:GetTrinketMultiplier(TrinketType.TRINKET_GRASS)
	if data.GrassTimer == nil then -- Set the timer
		data.GrassTimer = 108000
	end
	if data.GrassTimer < 0 then -- do the dumb thing
		data.GrassTimer = 108000
		SFXManager():Play(laugh)
		player:TryRemoveTrinket(TrinketType.TRINKET_GRASS)
		player:AnimateHappy()
		Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_GNAWED_LEAF, Isaac.GetFreeNearPosition(player.Position, 50), Vector.Zero, player)
	end
	if player:HasTrinket(TrinketType.TRINKET_GRASS, false) then -- 1 hour countdown
		if (goldenbox > 2 or goldenbox > 4) then		-- Golden Trinket + Mom's Box
			data.GrassTimer = data.GrassTimer - 3
		elseif goldenbox > 1 and goldenbox < 3 then	-- Golden Trinket or Mom's Box
			data.GrassTimer = data.GrassTimer - 2
		elseif goldenbox < 2 then						-- Normal Trinket
			data.GrassTimer = data.GrassTimer - 1
		end
	else -- Reset timer if you drop it
		data.GrassTimer = 108000
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.Grass)