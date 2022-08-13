local mod = Furtherance

local unlockEvents = {
    "MomsHeart", "Isaac", "Satan", "BlueBaby", "Lamb",
    "BossRush", "Hush", "MegaSatan", "Delirium", "Mother",
    "Beast", "GreedMode", "FullCompletion",
}

local function setUnlocks(playerName, isUnlocked)
    local playerUnlockInfo = mod.Unlocks[playerName]
    for _, event in ipairs(unlockEvents) do
        local eventUnlockInfo = playerUnlockInfo[event]
        eventUnlockInfo.Unlock = isUnlocked
        eventUnlockInfo.Hard = isUnlocked
    end
end

local commands = {}

function commands.furtherancehelp()
    return "Reset a character's unlocks: reset[name]\nExamples: resetleahb, resetpeter\n\nUnlock all of a character's unlocks: unlock[name]\nExamples: unlockleah, unlockmiriamb"
end

-- Pure Players

function commands.resetfurtherance()
    commands.resetleah()
    commands.resetpeter()
    commands.resetmiriam()
    commands.resetesther()
    commands.resetleahb()
    commands.resetpeterb()
    commands.resetmiriamb()
    commands.resetestherb()
    return "All Furtherance marks have been reset."
end

function commands.resetleah()
    setUnlocks("Leah", false)
    return "Leah has been reset."
end

function commands.unlockleah()
    setUnlocks("Leah", true)
    return "All Leah marks have been unlocked."
end

function commands.resetpeter()
    setUnlocks("Peter", false)
    return "Peter has been reset."
end

function commands.unlockpeter()
    setUnlocks("Peter", true)
    return "All Peter marks have been unlocked."
end

function commands.resetmiriam()
    setUnlocks("Miriam", false)
    return "Miriam has been reset."
end

function commands.unlockmiriam()
    setUnlocks("Miriam", true)
    return "All Miriam marks have been unlocked."
end

function commands.resetesther()
    setUnlocks("Esther", false)
    return "Esther has been reset."
end

function commands.unlockesther()
    setUnlocks("Esther", true)
    return "All Esther marks have been unlocked."
end

-- Tainted Players

function commands.resetleahb()
    setUnlocks("LeahB", false)
    return "Tainted Leah has been reset."
end

function commands.unlockleahb()
    setUnlocks("LeahB", true)
    return "All Tainted Leah marks have been unlocked."
end

function commands.resetpeterb()
    setUnlocks("PeterB", false)
    return "Tainted Peter has been reset."
end

function commands.unlockpeterb()
    setUnlocks("PeterB", true)
    return "All Tainted Peter marks have been unlocked."
end

function commands.resetmiriamb()
    setUnlocks("MiriamB", false)
    return "Tainted Miriam has been reset."
end

function commands.unlockmiriamb()
    setUnlocks("MiriamB", true)
    return "All Tainted Miriam marks have been unlocked."
end

function commands.resetestherb()
    setUnlocks("EstherB", false)
    return "All Tainted Esther marks have been unlocked."
end

function commands.unlockestherb()
    setUnlocks("EstherB", true)
    return "Tainted Esther has been reset."
end

function mod:RunUnlockCommand(cmd)
    local handler = commands[string.lower(cmd)]
    if not handler then return end

    local response = handler()
    if response then
        print(response)
    end
end
mod:AddCallback(ModCallbacks.MC_EXECUTE_CMD, mod.RunUnlockCommand)