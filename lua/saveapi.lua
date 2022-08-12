local mod = Furtherance
local game = Game()

local MOD_VERSION = "1.9"

Furtherance.IsContinued = false
Furtherance.LoadedData = false

local json = require("json")

---This is not a simple array. It's a mapping from player IDs (used by
---Isaac.GetPlayer) to EntityPlayers.
---@type table<integer, EntityPlayer>
local allPlayers = {}

local savedPlayerKeys = {}
local savedModKeys = {}

local shelvedPlayerKeys = {}
local shelvedModKeys = {}

local function isPureLivingLazarus(player)
    return player ~= nil and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS
end

local function isPureDeadLazarus(player)
    return player ~= nil and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2
end

local function isTaintedLivingLazarus(player)
    return player ~= nil and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B
end

local function isTaintedDeadLazarus(player)
    return player ~= nil and player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B
end

local function getPlayerIndex(player)
    if player == nil then
        error("player is nil", 2)
    end

    for index = 0, game:GetNumPlayers() - 1 do
        local indexedPlayer = Isaac.GetPlayer(index)
        if GetPtrHash(player) == GetPtrHash(indexedPlayer) then
            return index
        end
    end

    error("player index not found", 2)
end

---@param playerIndex number
local function getPlayerKey(playerIndex)
    return string.format("player_%.1f", playerIndex)
end

function Furtherance:SavePlayerData(keys)
    for key, default in pairs(keys) do
        savedPlayerKeys[key] = default
    end
end

function Furtherance:ShelvePlayerData(keys)
    for key, default in pairs(keys) do
        shelvedPlayerKeys[key] = default
    end
end

function Furtherance:SaveModData(keys)
    for key, default in pairs(keys) do
        savedModKeys[key] = default
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

local function createSaveData()
    return {
        Version = MOD_VERSION,
        PlayerData = {}
    }
end

function Furtherance:OnLoadData(isContinued)
    mod.IsContinued = isContinued

    local loadedString = mod:LoadData()
    local loadedData
    if loadedString == "" then
        loadedData = createSaveData()
    else
        loadedData = json.decode(mod:LoadData())
    end

    if loadedData.Version ~= MOD_VERSION then
        loadedData = createSaveData()
    end

    if isContinued then
        for key, default in pairs(savedModKeys) do
            mod[key] = loadDecodeOrDefault(loadedData[key], default)
        end
    else
        for key, default in pairs(savedModKeys) do
            mod[key] = loadDefault(default)
        end
    end

    for key, default in pairs(shelvedModKeys) do
        mod[key] = loadDecodeOrDefault(loadedData[key], default)
    end

    mod.LoadedData = loadedData
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_LOADED, nil, isContinued)
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.OnLoadData)

local function savePlayerData(player, i, savedData, keys)
    local data = mod:GetData(player)
    local playerData = savedData.PlayerData[getPlayerKey(i)]

    for key, default in pairs(keys) do
        playerData[key] = saveEncode(data[key], default)
    end
end

function Furtherance:OnSaveData(shouldSave)
    local savedData = {
        PlayerData = {}
    }
    for i in pairs(allPlayers) do
        savedData.PlayerData[getPlayerKey(i)] = {}
    end

    if shouldSave then
        for i, player in pairs(allPlayers) do
            savePlayerData(player, i, savedData, savedPlayerKeys)
        end

        for key, default in pairs(savedModKeys) do
            savedData[key] = saveEncode(mod[key], default)
        end
    end

    for i, player in pairs(allPlayers) do
        savePlayerData(player, i, savedData, shelvedPlayerKeys)
    end

    for key, default in pairs(shelvedModKeys) do
        savedData[key] = saveEncode(mod[key], default)
    end

    mod:SaveData(json.encode(savedData))
    mod.IsContinued = false
    mod.LoadedData = nil
    mod:RunCustomCallback(mod.CustomCallbacks.MC_POST_SAVED, nil, shouldSave)
end
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, mod.OnSaveData)

local lazarusTwins = {}
function Furtherance:GetLazarusOtherTwin(player)
    if player == nil then
        return nil
    end

    local index = mod:GetEntityIndex(player)
    return lazarusTwins[index]
end

local lastLazarus
function mod:ConnectLazarus(lazarus)
    if isPureLivingLazarus(lazarus) or isPureDeadLazarus(lazarus) or isTaintedLivingLazarus(lazarus) or isTaintedDeadLazarus(lazarus) then
        if lastLazarus then
            local index = mod:GetEntityIndex(lazarus)
            local lastIndex = mod:GetEntityIndex(lastLazarus)

            lazarusTwins[index] = lastLazarus
            lazarusTwins[lastIndex] = lazarus
            lastLazarus = nil
        else
            lastLazarus = lazarus
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.ConnectLazarus)

local function loadSavedPlayerData(player, index)
    local data = mod:GetData(player)
    local playerData = mod.LoadedData.PlayerData[getPlayerKey(index)]
    if mod.IsContinued and index ~= nil and playerData ~= nil then
        for key, default in pairs(savedPlayerKeys) do
            data[key] = loadDecodeOrDefault(playerData[key], default)
        end
    else
        for key, default in pairs(savedPlayerKeys) do
            data[key] = loadDefault(default)
        end
    end
end

local function loadShelvedPlayerData(player, index)
    local data = mod:GetData(player)
    local playerData = mod.LoadedData.PlayerData[getPlayerKey(index)]
    if index ~= nil and playerData ~= nil then
        for key, default in pairs(shelvedPlayerKeys) do
            data[key] = loadDecodeOrDefault(playerData[key], default)
        end
    else
        for key, default in pairs(shelvedPlayerKeys) do
            data[key] = loadDefault(default)
        end
    end
end

local function loadAllPlayerData(player, index)
    loadSavedPlayerData(player, index)
    loadShelvedPlayerData(player, index)
    local data = mod:GetData(player)
    data.LoadedData = true
end

function Furtherance:OnLoadPlayerData(player)
    if isTaintedDeadLazarus(player) then return end

    local indexedPlayer = player
    local indexOffset = 0
    if isPureDeadLazarus(player) then
        indexedPlayer = mod:GetLazarusOtherTwin(player)
        indexOffset = 0.5
    end

    local index = getPlayerIndex(indexedPlayer) + indexOffset

    if isTaintedLivingLazarus(player) then
        -- load tainted dead lazarus too now that tainted living lazarus is here
        local deadLazarus = mod:GetLazarusOtherTwin(player)
        allPlayers[index + 0.5] = deadLazarus
        loadAllPlayerData(deadLazarus, index + 0.5)
    end

    allPlayers[index] = player
    loadAllPlayerData(player, index)
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.OnLoadPlayerData)

function mod:SaveCommand(cmd)
    if string.lower(cmd) == "savefurtherance" then
        mod:OnSaveData(true)
        print("saved Furtherance data")
    end
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.SaveCommand)
