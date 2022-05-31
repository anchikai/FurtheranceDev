local mod = Furtherance
local game = Game()

local function evalEpitaph(level)
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        -- print(data.EpitaphStage, data.DiedWithEpitaph)
        if data.DiedWithEpitaph == true and level:GetStage() == data.EpitaphStage then
            for _ = 1, 2 do
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_NULL, Isaac.GetFreeNearPosition(player.Position, 0), Vector.Zero, player)
            end
            data.DiedWithEpitaph = false
            data.EpitaphStage = -1
        end
    end
end

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

    local level = game:GetLevel()
    if level:GetStage() ~= LevelStage.STAGE1_1 then return end

    evalEpitaph(level)
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.EpitaphData)

function mod:EpitaphRoom()
    local level = game:GetLevel()
    if level:GetStage() == LevelStage.STAGE1_1 then return end
    evalEpitaph(level)
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.EpitaphRoom)

function mod:EpitaphDied(entity)
    local player = entity:ToPlayer()
    if player and player:HasTrinket(TrinketType.TRINKET_EPITAPH) then
        local data = mod:GetData(player)
        local level = game:GetLevel()
        data.DiedWithEpitaph = true
        data.EpitaphStage = level:GetStage()
        print("epic")
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, mod.EpitaphDied, EntityType.ENTITY_PLAYER)

--[[mod:AddCallback(ModCallbacks.MC_POST_RENDER, function()
	for i = 0, game:GetNumPlayers() - 1 do
		local player = game:GetPlayer(i)
		local data = mod:GetData(player)
        local f = Font()
        local bruh
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
end)
]]