local mod = Furtherance
local game = Game()

Furtherance.CustomCallbacks = {
    MC_POST_GAME_STARTED = ModCallbacks.MC_POST_GAME_STARTED,
    MC_POST_NEW_LEVEL = ModCallbacks.MC_POST_NEW_LEVEL,
    MC_POST_NEW_ROOM = ModCallbacks.MC_POST_NEW_ROOM,
    MC_POST_LOADED = 20001,
    MC_POST_SAVED = 20003,
}

local GeneralCallbacks = {}

local allCallbacks = {}
for _, callbackEnum in pairs(mod.CustomCallbacks) do
    allCallbacks[callbackEnum] = {
        [GeneralCallbacks] = {}
    }
end


Furtherance.AddVanillaCallback = mod.AddCallback

function Furtherance:AddCallback(modCallback, callback, specifier)
    local callbacks = allCallbacks[modCallback]
    if callbacks == nil then
        mod:AddVanillaCallback(modCallback, callback, specifier)
    else
        if specifier == nil then
            specifier = GeneralCallbacks
        end

        local specifierCallbacks = callbacks[specifier]
        if specifierCallbacks == nil then
            specifierCallbacks = {}
            callbacks[specifier] = specifierCallbacks
        end
        table.insert(specifierCallbacks, callback)
    end
end

local function runCallbackSafely(callback, self, ...)
    local success, message = pcall(callback, self, ...)
    if not success then
        print("ERROR:\n", message)
    end
end

function Furtherance:RunCustomCallback(callbackEnum, specifier, ...)
    local callbacks = allCallbacks[callbackEnum]
    if not callbacks then
        error(string.format("Unsupported custom callback %d", callbackEnum), 2)
    end

    if specifier == nil then
        -- run all callbacks for the enum
        for _, specifierCallbacks in pairs(callbacks) do
            for _, callback in ipairs(specifierCallbacks) do
                runCallbackSafely(callback, self, ...)
            end
        end
    else
        -- run callbacks for this specifier (if it exists)
        local specifierCallbacks = callbacks[specifier]
        if specifierCallbacks ~= nil then
            for _, callback in ipairs(specifierCallbacks) do
                runCallbackSafely(callback, self, ...)
            end
        end

        -- as well as general callbacks
        local generalCallbacks = callbacks[GeneralCallbacks]
        for _, callback in ipairs(generalCallbacks) do
            runCallbackSafely(callback, self, ...)
        end
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

local function hasCallbacks()
    for _, callbacks in pairs(allCallbacks) do
        for _, specifierCallbacks in pairs(callbacks) do
            if #specifierCallbacks > 0 then
                return true
            end
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
mod:AddVanillaCallback(ModCallbacks.MC_USE_ITEM, mod.UsedGlowingHourGlass, CollectibleType.GLOWING_HOUR_GLASS)

function mod:PostGameStarted(isContinued)
    if not hasCallbacks() then return end

    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_GAME_STARTED, nil, isContinued)
    recordCurrentStage()
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_NEW_LEVEL)
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_NEW_ROOM)
end
mod:AddVanillaCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.PostGameStarted)

function mod:PostNewLevel()
    if not hasCallbacks() then return end
    if game:GetFrameCount() == 0 then return end

    recordCurrentStage()
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_NEW_LEVEL)
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_NEW_ROOM)
end
mod:AddVanillaCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.PostNewLevel)

function mod:PostNewRoom()
    if not hasCallbacks() then
        return
    end

    local level = game:GetLevel()
    local stage = level:GetStage()
    local stageType = level:GetStageType()

    if usedGlowingHourGlass then
        usedGlowingHourGlass = false

        if currentStage ~= stage or currentStageType ~= stageType then
            -- The player has used the Glowing Hour Glass to take them to the previous floor (which does
            -- not trigger the PostNewLevel callback). Emulate what happens in the PostNewLevel callback.
            recordCurrentStage()
            mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_NEW_LEVEL)
            mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_NEW_ROOM)
            return
        end
    end

    if game:GetFrameCount() == 0 or
        currentStage ~= stage or
        currentStageType ~= stageType
    then
        return
    end

    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_NEW_ROOM)
end
mod:AddVanillaCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.PostNewRoom)

--]]