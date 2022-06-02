local mod = Furtherance
local game = Game()

Furtherance.CustomModCallbacks = {
    MC_POST_GAME_STARTED = ModCallbacks.MC_POST_GAME_STARTED,
    MC_POST_NEW_LEVEL = ModCallbacks.MC_POST_NEW_LEVEL,
    MC_POST_NEW_ROOM = ModCallbacks.MC_POST_NEW_ROOM,
}

local allCallbacks = {}

function Furtherance:AddCustomCallback(callbackEnum, callback)
    local callbacks = allCallbacks[callbackEnum]
    if callbacks == nil then
        callbacks = {}
        allCallbacks[callbackEnum] = callbacks
    end

    table.insert(callbacks, callback)
end

local function runCallback(callbackEnum, ...)
    local callbacks = allCallbacks[callbackEnum]
    if callbacks == nil then return end

    for _, callback in ipairs(callbacks) do
        callback(mod, ...)
    end
end

--[
-- Adapted from:
-- https://github.com/IsaacScript/isaacscript/blob/76853840cf19b4ef8da72b35e709b99895114ad9/packages/isaacscript-common/src/callbacks/reorderedCallbacks.ts

local currentStage
local currentStageType
local usedGlowingHourGlass
do
    local level = game:GetLevel()
    currentStage = level:GetStage()
    currentStageType = level:GetStageType()
end

local function hasSubscriptions()
    for _, callbacks in pairs(allCallbacks) do
        if #callbacks > 0 then
            return true
        end
    end

    return false
end

local function recordCurrentStage()
    local level = game:GetLevel()
    local stage = level:GetStage()
    local stageType = level:GetStageType()

    currentStage = stage
    currentStageType = stageType
end

function mod:UsedGlowingHourGlass()
    usedGlowingHourGlass = true
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UsedGlowingHourGlass, CollectibleType.GLOWING_HOUR_GLASS)

function mod:PostGameStarted(isContinued)
    if not hasSubscriptions() then return end

    runCallback(mod.CustomModCallbacks.MC_POST_GAME_STARTED, isContinued)
    recordCurrentStage()
    runCallback(mod.CustomModCallbacks.MC_POST_NEW_LEVEL)
    runCallback(mod.CustomModCallbacks.MC_POST_NEW_ROOM)
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.PostGameStarted)

function mod:PostNewLevel()
    if not hasSubscriptions() then return end
    if game:GetFrameCount() == 0 then return end

    recordCurrentStage()
    runCallback(mod.CustomModCallbacks.MC_POST_NEW_LEVEL)
    runCallback(mod.CustomModCallbacks.MC_POST_NEW_ROOM)
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.PostNewLevel)

function mod:PostNewRoom()
    if not hasSubscriptions() then
        return
    end

    local gameFrameCount = game:GetFrameCount()
    local level = game:GetLevel()
    local stage = level:GetStage()
    local stageType = level:GetStageType()

    if usedGlowingHourGlass then
        usedGlowingHourGlass = false

        if currentStage ~= stage or currentStageType ~= stageType then
            -- The player has used the Glowing Hour Glass to take them to the previous floor (which does
            -- not trigger the PostNewLevel callback). Emulate what happens in the PostNewLevel callback.
            recordCurrentStage()
            runCallback(mod.CustomModCallbacks.MC_POST_NEW_LEVEL)
            runCallback(mod.CustomModCallbacks.MC_POST_NEW_ROOM)
            return
        end
    end

    if gameFrameCount == 0 or
        currentStage ~= stage or
        currentStageType ~= stageType
    then
        return
    end

    runCallback(mod.CustomModCallbacks.MC_POST_NEW_ROOM)
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.PostNewRoom)

--]]
