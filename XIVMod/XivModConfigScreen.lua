XivMod_Config = {
	Buffs = {
		Enabled = false,
		Locked = false,
		BuffFrameOffset = { point = "CENTER", x = 0, y = 0 },
		DebuffFrameOffset = { point = "CENTER", x = 0, y = 0 }
	}
};

function BuffsEnable_Toggle()
	local checked = BuffsEnable:GetChecked();
	
	BuffFrames_Toggle(checked);

end

function BuffFramesLocked_Toggle()
	local locked = LockBuffFrames:GetChecked();
	
	LockFrames_Toggle(locked);
end


function XivModConfig_InitialiseFromConfig()
	BuffFrames_Toggle(true);

	if (not XivMod_Config.Buffs.Enabled) then
		BuffFrames_Toggle(false);
	end

	if (XivMod_Config.Buffs.Locked) then
		LockFrames_Toggle(true);
	end
end

function XivModConfigScreen_OnShow()
	BuffsEnable:SetChecked(XivMod_Config.Buffs.Enabled);
	LockBuffFrames:SetChecked(XivMod_Config.Buffs.Locked);
end

function XivModConfigScreen_OnLoad(screen)
	screen:SetScript("OnEvent", function(self, event, eventArgs)
		if (event == "ADDON_LOADED" and eventArgs == "XIVMod") then
			XivModConfig_InitialiseFromConfig();
		end
	end);

	screen:RegisterEvent("ADDON_LOADED");
end
