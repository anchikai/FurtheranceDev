local mod = Furtherance
local game = Game()

-- Thank you for all the fixes manaphoenix!

function mod:ChironMapping() -- Apply a random map effect every floor
    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CHIRON) then
            local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_CHIRON)
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

function mod:BossDetection() -- If the room is a boss room
    local room = game:GetRoom()
    if not room:IsCurrentRoomLastBoss() then
        return
    end -- check to make sure its a boss. if not, stop the rest of the checks/code

    for i = 0, game:GetNumPlayers() - 1 do
        local player = Isaac.GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_CHIRON) and room:IsFirstVisit() == true and room:GetFrameCount() == 1 then -- Guwah you legend
            mod:BossBook(player) -- Use a random book
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.BossDetection)

function mod:BossBook(player) -- Roll a random book effect
    local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_CHIRON)
    local rollBook = rng:RandomInt(5) + 1
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
