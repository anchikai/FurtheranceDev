local mod = Furtherance
local game = Game()
local rng = RNG()

function mod:JunoTears(tear, collider)
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_JUNO) then
			if (collider:IsEnemy() and collider:IsVulnerableEnemy() and collider:IsActiveEnemy()) then
				local rollJuno = rng:RandomInt(100)
				local data = mod:GetData(player)
				if player.Luck > 11 then
					if rng:RandomInt(4) == 1 and data.JunoTimer == 0 then
						player:UseActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, UseFlag.USE_NOANIM, -1)
						data.JunoTimer = 300
					end
				elseif rollJuno <= (player.Luck*2+2) and data.JunoTimer == 0 then
					player:UseActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, UseFlag.USE_NOANIM, -1)
					data.JunoTimer = 300
				end
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.JunoTears)				-- Tears
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.JunoTears)				-- Mom's Knife
mod:AddCallback(ModCallbacks.MC_POST_LASER_INIT, function(tear)					-- Brimstone and other lasers
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		if player:HasCollectible(CollectibleType.COLLECTIBLE_JUNO) then
			local rollJuno = rng:RandomInt(100)
			local data = mod:GetData(player)
			if player.Luck > 11 then
				if rng:RandomInt(4) == 1 and data.JunoTimer == 0 then
					player:UseActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, UseFlag.USE_NOANIM, -1)
					data.JunoTimer = 300
				end
			elseif rollJuno <= (player.Luck*2+2) and data.JunoTimer == 0 then
				player:UseActiveItem(CollectibleType.COLLECTIBLE_ANIMA_SOLA, UseFlag.USE_NOANIM, -1)
				data.JunoTimer = 300
			end
		end
	end
end)

function mod:JunoUpdate(player)
	local data = mod:GetData(player)
	if data.JunoTimer == nil then
		data.JunoTimer = 0
	end
	if data.JunoTimer > 0 then
		data.JunoTimer = data.JunoTimer - 1
	end
	if data.JunoTimer < 0 then
		data.JunoTimer = 0
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.JunoUpdate)