local core_info_screen
local function GetCoreInfoScreen()
	if not IsValid(core_info_screen) then
		core_info_screen = nil

		local screens = ents.FindByClass("lua_screen")
		for i = 1, #screens do
			local screen = screens[i]
			if screen:GetPlace() == "corectrl" then
				core_info_screen = screen
				break
			end
		end
	end

	return core_info_screen
end

mgn.Stage.Overloading = {
	Started = false,
	StartTime = 0,
	Next = mgn.Stage.Exploding,
	Start = function(self, time)
		for i = 1, #mgn.AlarmEntities do
			local pair = mgn.AlarmEntities[i]
			pair.Light:SetEnabled(true)
			pair.Siren:SetEnabled(true)
		end

		for i = 1, #mgn.LightEntities do
			mgn.LightEntities[i]:SetEnabled(true)
		end

		mgn.SetEmergencyTelevationMode(true)

		local screen = GetCoreInfoScreen()
		if IsValid(screen) then
			screen:SetDTInt(3, 100) -- damage status
			screen:SetDTInt(4, -1) -- radiation status
			SetGlobalBool("core_door", false) -- door status
		end
	end,
	Think = function(self, chrono)
		return chrono < 206
	end,
	End = function(self, time)
	end
}
