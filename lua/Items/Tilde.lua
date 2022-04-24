local mod = Furtherance
local game = Game()

function mod:UseTilde(_, _, player)
	local data = player:GetData()
	local randomDebug = rng:RandomInt(13)
	local hud = game:GetHUD()

	if data.Debug1 == true and data.Debug2 == true and data.Debug3 == true and data.Debug4 == true and data.Debug5 == true and data.Debug6 == true and data.Debug7 == true and data.Debug8 == true and data.Debug9 == true and data.Debug10 == true and data.Debug11 == true and data.Debug12 == true and data.Debug13 == true then
		mod:playFailSound()
		player:AnimateSad()
		hud:ShowFortuneText("All Debug", "Is enabled!")
		return false
	elseif randomDebug == 1 then
		if data.Debug1 == false then
			Isaac.ExecuteCommand("debug 1")
			hud:ShowFortuneText("Entity Positions")
			data.Debug1 = true
		end
	end
	if randomDebug == 2 then
		if data.Debug2 == false then
			Isaac.ExecuteCommand("debug 2")
			hud:ShowFortuneText("Grid")
			data.Debug2 = true
		end
	end
	if randomDebug == 3 then
		if data.Debug3 == false then
			Isaac.ExecuteCommand("debug 3")
			hud:ShowFortuneText("Infinite HP")
			data.Debug3 = true
		end
	end
	if randomDebug == 4 then
		if data.Debug4 == false then
			Isaac.ExecuteCommand("debug 4")
			hud:ShowFortuneText("High Damage")
			data.Debug4 = true
		end
	end 
	if randomDebug == 5 then
		if data.Debug5 == false then
			Isaac.ExecuteCommand("debug 5")
			hud:ShowFortuneText("Show Room Info")
			data.Debug5 = true
		end
	end 
	if randomDebug == 6 then
		if data.Debug6 == false then
			Isaac.ExecuteCommand("debug 6")
			hud:ShowFortuneText("Show Hitspheres")
			data.Debug6 = true
		end
	end 
	if randomDebug == 7 then
		if data.Debug7 == false then
			Isaac.ExecuteCommand("debug 7")
			hud:ShowFortuneText("Show Damage Values")
			data.Debug7 = true
		end
	end 
	if randomDebug == 8 then
		if data.Debug8 == false then
			Isaac.ExecuteCommand("debug 8")
			hud:ShowFortuneText("Infinite Item Charges")
			data.Debug8 = true
		end
	end
	if randomDebug == 9 then
		if data.Debug9 == false then
			Isaac.ExecuteCommand("debug 9")
			hud:ShowFortuneText("High Luck")
			data.Debug9 = true
		end
	end
	if randomDebug == 10 then
		if data.Debug10 == false then
			Isaac.ExecuteCommand("debug 10")
			hud:ShowFortuneText("Quick Kill")
			data.Debug10 = true
		end
	end
	if randomDebug == 11 then
		if data.Debug11 == false then
			Isaac.ExecuteCommand("debug 11")
			hud:ShowFortuneText("Grid Info")
			data.Debug11 = true
		end
	end
	if randomDebug == 12 then
		if data.Debug12 == false then
			Isaac.ExecuteCommand("debug 12")
			hud:ShowFortuneText("Player Item Info")
			data.Debug12 = true
		end
	end
	if randomDebug == 13 then
		if data.Debug13 == false then
			Isaac.ExecuteCommand("debug 13")
			hud:ShowFortuneText("Show Grid", "Collision Points")
			data.Debug13 = true
		end
	end
	return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseTilde, CollectibleType.COLLECTIBLE_TILDE_KEY)

function mod:OnNewRoom()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = player:GetData()

		if data.Debug1 == true then
			Isaac.ExecuteCommand("debug 1")
			data.Debug1 = false
		end
		if data.Debug2 == true then
			Isaac.ExecuteCommand("debug 2")
			data.Debug2 = false
		end
		if data.Debug3 == true then
			Isaac.ExecuteCommand("debug 3")
			data.Debug3 = false
		end
		if data.Debug4 == true then
			Isaac.ExecuteCommand("debug 4")
			data.Debug4 = false
		end
		if data.Debug5 == true then
			Isaac.ExecuteCommand("debug 5")
			data.Debug5 = false
		end
		if data.Debug6 == true then
			Isaac.ExecuteCommand("debug 6")
			data.Debug6 = false
		end
		if data.Debug7 == true then
			Isaac.ExecuteCommand("debug 7")
			data.Debug7 = false
		end
		if data.Debug8 == true then
			Isaac.ExecuteCommand("debug 8")
			data.Debug8 = false
		end
		if data.Debug9 == true then
			Isaac.ExecuteCommand("debug 9")
			data.Debug9 = false
		end
		if data.Debug10 == true then
			Isaac.ExecuteCommand("debug 10")
			data.Debug10 = false
		end
		if data.Debug11 == true then
			Isaac.ExecuteCommand("debug 11")
			data.Debug11 = false
		end
		if data.Debug12 == true then
			Isaac.ExecuteCommand("debug 12")
			data.Debug12 = false
		end
		if data.Debug13 == true then
			Isaac.ExecuteCommand("debug 13")
			data.Debug13 = false
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoom)

function mod:InitTilde(player)
	local data = player:GetData()
	--Initialize Debug Data
	if data.Debug1 == nil then
		data.Debug1 = false
	end
	if data.Debug2 == nil then
		data.Debug2 = false
	end
	if data.Debug3 == nil then
		data.Debug3 = false
	end
	if data.Debug4 == nil then
		data.Debug4 = false
	end
	if data.Debug5 == nil then
		data.Debug5 = false
	end
	if data.Debug6 == nil then
		data.Debug6 = false
	end
	if data.Debug7 == nil then
		data.Debug7 = false
	end
	if data.Debug8 == nil then
		data.Debug8 = false
	end
	if data.Debug9 == nil then
		data.Debug9 = false
	end
	if data.Debug10 == nil then
		data.Debug10 = false
	end
	if data.Debug11 == nil then
		data.Debug11 = false
	end
	if data.Debug12 == nil then
		data.Debug12 = false
	end
	if data.Debug13 == nil then
		data.Debug13 = false
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.InitTilde)