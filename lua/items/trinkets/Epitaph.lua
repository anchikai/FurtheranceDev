local mod = Furtherance
local game = Game()

function mod:EpitaphData(continued)
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        if data.DiedWithEpitaph ~= true then
            data.DiedWithEpitaph = false
        end
        if data.EpitaphStage == nil then
            data.EpitaphStage = -1
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.EpitaphData)

function mod:EpitaphRoom()
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        local level = game:GetLevel()
        -- print(data.EpitaphStage, data.DiedWithEpitaph)
        if data.DiedWithEpitaph == true and level:GetStage() == data.EpitaphStage then
            data.DiedWithEpitaph = false
            for _ = 1, 2 do
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_NULL, Isaac.GetFreeNearPosition(player.Position, 0), Vector.Zero, player)
            end
            print("You died here earlier dumbass, here you go.")
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.EpitaphRoom)

function mod:EpitaphDied(entity)
    local player = entity:ToPlayer()
    local data = mod:GetData(player)
    if player and player:HasTrinket(TrinketType.TRINKET_EPITAPH) then
        local level = game:GetLevel()
        data.DiedWithEpitaph = true
        data.EpitaphStage = level:GetStage()
    end
end

mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.EpitaphDied, EntityType.ENTITY_PLAYER)

--[[mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
        local f = Font()
        if data.DiedWithEpitaph == true then
            bruh = "Yes"
        else
            bruh = "No"
        end
        f:Load("font/pftempestasevencondensed.fnt")
        f:DrawString("Stage you died on: ", 75, 250, KColor(1, 1, 1, 1), 0, true)
        f:DrawString(data.EpitaphStage, 146+25, 250, KColor(1, 1, 1, 1), 0, true)
        f:DrawString("Died with Epitaph? ", 75, 240, KColor(1, 1, 1, 1), 0, true)
        f:DrawString(bruh, 148+25, 240, KColor(1, 1, 1, 1), 0, true)
	end
end)]]