local mod = Furtherance
local rng = RNG()

-- Thank you for all the fixes manaphoenix!

local game = Game() -- Don't keep regetting Game(), store it.

local function GetPlayers() -- its better to turn this into a utility function with how much your using it.
    local t = {}
    for i = 0, game:GetNumPlayers() - 1 do table.insert(t, game:GetPlayer(i)) end
    return t
end

function mod:ChironMapping() -- Apply a random map effect every floor
    local players = GetPlayers()
    for _, player in pairs(players) do
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CHIRON) then
            local level = game:GetLevel()
            local rollMap = rng:RandomInt(3)
            if rollMap == 1 then
                level:ApplyCompassEffect(true)
            elseif rollMap == 2 then
                level:ApplyMapEffect()
            elseif rollMap == 3 then
                level:ApplyBlueMapEffect()
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.ChironMapping)

local function IsActiveEnemy(player) -- Enemy detection
    local enemies = Isaac.FindInRadius(player.position, 1000, EntityPartition.ENEMY) -- this method of doing it gets only the enemies, instead of every entity in the entire room.
    for _, enemy in pairs(enemies) do
        if enemy:IsVulnerableEnemy() and enemy:IsActiveEnemy() and
            not EntityRef(enemy).IsCharmed then return true end
    end
    return false
end

function mod:BossDetection() -- If the room is a boss room
    local room = game:GetRoom()
    if not room:IsCurrentRoomLastBoss() then
        return
    end -- check to make sure its a boss. if not, stop the rest of the checks/code

    local players = GetPlayers()
    for _, player in pairs(players) do
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CHIRON) and room:IsFirstVisit() == true and room:GetFrameCount() == 1 then -- Guwah you legend
			mod:BossBook(player) -- Use a random book
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.BossDetection)

function mod:BossBook(player) -- Roll a random book effect
    local rollBook = rng:RandomInt(5)
    if rollBook == 1 then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL, UseFlag.USE_NOANNOUNCER, -1)
    elseif rollBook == 2 then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_SHADOWS, UseFlag.USE_NOANNOUNCER, -1)
    elseif rollBook == 3 then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_BOOK_OF_REVELATIONS, UseFlag.USE_NOANNOUNCER, -1)
    elseif rollBook == 4 then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_TELEPATHY_BOOK, UseFlag.USE_NOANNOUNCER, -1)
    elseif rollBook == 5 then
        player:UseActiveItem(CollectibleType.COLLECTIBLE_MONSTER_MANUAL, UseFlag.USE_NOANNOUNCER, -1)
    end
end

function mod:GetChiron(player, cacheFlag) -- Speed up
    if player:HasCollectible(CollectibleType.COLLECTIBLE_CHIRON) then
        if cacheFlag == CacheFlag.CACHE_SPEED then -- this is the correct way to compare bitflags :)
            player.MoveSpeed = player.MoveSpeed + 0.2
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.GetChiron)
