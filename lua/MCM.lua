local laugh = Isaac.GetSoundIdByName("Sitcom_Laugh_Track")

if ModConfigMenu then

    local FurtheranceMCM = "Furtherance"
	ModConfigMenu.UpdateCategory(FurtheranceMCM, {
		Info = {"Configuration for Furtherance.",}
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