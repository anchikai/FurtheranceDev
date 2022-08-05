local laugh = Isaac.GetSoundIdByName("Sitcom_Laugh_Track")

if ModConfigMenu then

    Furtherance:ShelveModData({
        LeahDoubleTapSpeed = 1,
        FlipSpeed = 1,
        FailSound = Furtherance.FailSound,
        PrefferedAPI = 1
    })

    local FurtheranceMCM = "Furtherance"
	ModConfigMenu.UpdateCategory(FurtheranceMCM, {
		Info = {"Configuration for Furtherance.",}
	})

    ModConfigMenu.AddSetting(FurtheranceMCM, "Controls",
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return Furtherance.LeahDoubleTapSpeed
        end,
        Default = 1,
        Minimum = 1,
        Maximum = 5,
        Display = function()
            local sstr
            if Furtherance.LeahDoubleTapSpeed == 1 then
                sstr = "Speedy (Default)"
            elseif Furtherance.LeahDoubleTapSpeed == 2 then
                sstr = "Fast"
            elseif Furtherance.LeahDoubleTapSpeed == 3 then
                sstr = "Medium"
            elseif Furtherance.LeahDoubleTapSpeed == 4 then
                sstr = "Slow"
            elseif Furtherance.LeahDoubleTapSpeed == 5 then
                sstr = "Snail"
            end
            return 'Renovator Double Tap Speed: '..sstr
        end,
        OnChange = function(currentNum)
            Furtherance.LeahDoubleTapSpeed = currentNum
        end,
        Info = "Change how quickly you have to double tap the drop button to use Heart Renovator's counter."
    })

    ModConfigMenu.AddSetting(FurtheranceMCM, "Visuals",
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return Furtherance.FlipSpeed
        end,
        Default = 1,
        Minimum = 1,
        Maximum = 3,
        Display = function()
            local sstr
            if Furtherance.FlipSpeed == 1 then
                sstr = "Slow (Default)"
            elseif Furtherance.FlipSpeed == 2 then
                sstr = "Medium"
            elseif Furtherance.FlipSpeed == 3 then
                sstr = "Fast"
            end
            return 'Tainted Peter Flip Speed: '..sstr
        end,
        OnChange = function(currentNum)
            Furtherance.FlipSpeed = currentNum
        end,
        Info = "Change the speed of the Flip animation for Muddled Cross."
    })

    ModConfigMenu.AddSetting(FurtheranceMCM, "Visuals",
    {
        Type = ModConfigMenu.OptionType.NUMBER,
        CurrentSetting = function()
            return Furtherance.PrefferedAPI
        end,
        Default = 1,
        Minimum = 1,
        Maximum = 3,
        Display = function()
            local sstr
            if Furtherance.PrefferedAPI == 1 then
                sstr = "GiantBook API"
            elseif Furtherance.PrefferedAPI == 2 then
                sstr = "Screen API"
            elseif Furtherance.PrefferedAPI == 3 then
                sstr = "None"
            end
            return 'Preffered API for achievements: '..sstr
        end,
        OnChange = function(currentNum)
            Furtherance.PrefferedAPI = currentNum
        end,
        Info = "Change API for achievements."
    })

    ModConfigMenu.AddSetting(FurtheranceMCM, "SFX",
    {
        Type = ModConfigMenu.OptionType.BOOLEAN,
        CurrentSetting = function()
            return Furtherance.FailSound ~= laugh
        end,
        Display = function()
            local sstr = "???"
            if Furtherance.FailSound == laugh then sstr = "Laugh Track"
            elseif Furtherance.FailSound == SoundEffect.SOUND_EDEN_GLITCH then sstr = "Default" end
            return "Item Fails Sound Effect: " .. sstr
        end,
        OnChange = function(current_bool)
            if current_bool then
                Furtherance.FailSound = SoundEffect.SOUND_EDEN_GLITCH
            else
                Furtherance.FailSound = laugh
            end
        end
    })
end