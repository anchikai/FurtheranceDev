local mod = Furtherance
local game = Game()

local json = require("json")

local playerKeys = {}
local modKeys = {}

local shelvedPlayerKeys = {}
local shelvedModKeys = {}

function Furtherance:SavePlayerData(keys)
    for key, default in pairs(keys) do
        playerKeys[key] = default
    end
end

function Furtherance:SaveModData(keys)
    for key, default in pairs(keys) do
        modKeys[key] = default
    end
end

function Furtherance:ShelvePlayerData(keys)
    for key, default in pairs(keys) do
        shelvedPlayerKeys[key] = default
    end
end

function Furtherance:ShelveModData(keys)
    for key, default in pairs(keys) do
        shelvedModKeys[key] = default
    end
end

local serializers = {
    [Vector] = {
        Encode = function(vector)
            return { X = vector.X, Y = vector.Y }
        end,

        Decode = function(data)
            return Vector(data.X, data.Y)
        end
    }
}

local serializedData = {}

Furtherance.SaveNil = {}
local function saveEncode(value, default)
    if serializedData[default] then
        return default.Serializer.Encode(value)
    else
        return value
    end
end

local function loadDefault(default)
    if default == mod.SaveNil then
        return nil
    elseif type(default) == "function" then
        return default()
    else
        return default
    end
end

local function loadDecodeOrDefault(value, default)
    if serializedData[default] then
        return loadDecodeOrDefault(default.Serializer.Decode(value), default.Default)
    elseif value ~= nil then
        return value
    else
        return loadDefault(default)
    end
end

function Furtherance:Serialize(datatype, default)
    local serializer = serializers[datatype]
    if serializer == nil then
        error(string.format("Serializer not found for '%s'", datatype), 2)
    end

    if default == Furtherance.SaveNil then
        default = nil
    end

    local serialObject = {
        Serializer = serializer,
        Default = default
    }

    serializedData[serialObject] = true

    return serializer
end

function mod:OnSaveData(canContinue)
    local savedData = {
        PlayerData = {}
    }

    for i = 1, game:GetNumPlayers() do
        savedData.PlayerData[string.format("player_%d", i)] = {}
    end

    if canContinue then
        for i = 0, game:GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(i)
            local data = mod:GetData(player)
            local playerData = savedData.PlayerData[string.format("player_%d", i + 1)]

            for key, default in pairs(playerKeys) do
                playerData[key] = saveEncode(data[key], default)
            end
        end

        for key, default in pairs(modKeys) do
            savedData[key] = saveEncode(mod[key], default)
        end
    end

    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        local playerData = savedData.PlayerData[string.format("player_%d", i + 1)]

        for key, default in pairs(shelvedPlayerKeys) do
            playerData[key] = saveEncode(data[key], default)
        end
    end

    for key, default in pairs(shelvedModKeys) do
        savedData[key] = saveEncode(mod[key], default)
    end

    mod:SaveData(json.encode(savedData))
    mod.isLoadingData = false
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_SAVED, canContinue)
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.OnSaveData)

function mod:OnLoadData(isContinued)
    local loadedData = json.decode(mod:LoadData())

    mod.isLoadingData = isContinued
    if isContinued then
        for i = 0, game:GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(i)
            local data = mod:GetData(player)
            local playerData = loadedData.PlayerData[string.format("player_%d", i + 1)]

            for key, default in pairs(playerKeys) do
                data[key] = loadDecodeOrDefault(playerData[key], default)
            end
        end

        for key, default in pairs(modKeys) do
            mod[key] = loadDecodeOrDefault(loadedData[key], default)
        end
    else
        for i = 0, game:GetNumPlayers() - 1 do
            local player = Isaac.GetPlayer(i)
            local data = mod:GetData(player)

            for key, default in pairs(playerKeys) do
                data[key] = loadDefault(default)
            end
        end

        for key, default in pairs(modKeys) do
            mod[key] = loadDefault(default)
        end
    end

    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        local data = mod:GetData(player)
        local playerData = loadedData.PlayerData[string.format("player_%d", i + 1)]

        for key, default in pairs(shelvedPlayerKeys) do
            data[key] = loadDecodeOrDefault(playerData[key], default)
        end
    end

    for key, default in pairs(shelvedModKeys) do
        mod[key] = loadDecodeOrDefault(loadedData[key], default)
    end

    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_LOADED, isContinued)
end
mod:AddCustomCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.OnLoadData)