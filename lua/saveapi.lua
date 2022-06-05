local mod = Furtherance
local game = Game()

Furtherance.isLoadingData = false
Furtherance.LoadedData = false

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
            return { vector.X, vector.Y }
        end,

        Decode = function(data)
            return Vector(data[1], data[2])
        end
    },

    [Color] = {
        Encode = function(color)
            return { color.R, color.G, color.B, color.A, color.RO, color.GO, color.BO }
        end,

        Decode = function(data)
            return Color(data[1], data[2], data[3], data[4], data[5], data[6], data[7])
        end
    }
}

local serializedData = {}

Furtherance.SaveNil = {}
local function loadDefault(default)
    if serializedData[default] then
        return loadDefault(default.Default)
    elseif default == mod.SaveNil then
        return nil
    elseif type(default) == "function" then
        return default()
    else
        return default
    end
end

local function saveEncode(value, default)
    if serializedData[default] then
        if value ~= nil then
            return default.Serializer.Encode(value)
        else
            return loadDefault(default.Default)
        end
    else
        return value
    end
end

local function loadDecodeOrDefault(value, default)
    if serializedData[default] then
        if value ~= nil then
            return loadDecodeOrDefault(default.Serializer.Decode(value), default.Default)
        else
            return loadDefault(default.Default)
        end
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

    return serialObject
end

function mod:OnLoadData(isContinued)
    mod.isLoadingData = isContinued

    local loadedData = json.decode(mod:LoadData())

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

    mod.LoadedData = true
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_LOADED, nil, isContinued)
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.OnLoadData)

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
    mod.LoadedData = false
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_SAVED, nil, canContinue)
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.OnSaveData)