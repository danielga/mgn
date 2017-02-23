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
	StartedAt = 0,
	StartTime = 60,
	Length = 206,
	EndTime = 266,
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

		local plys = player.GetAll()
		for i = 1, #plys do
			local ply = plys[i]
			ply:SetMoveType(MOVETYPE_WALK)
			ply._fly_restrict = true
		end
	end,
	Think = function(self, chrono)
		return chrono < self.Length
	end,
	End = function(self, time)
		for i = 1, #mgn.AlarmEntities do
			local pair = mgn.AlarmEntities[i]
			pair.Light:SetEnabled(false)
			pair.Siren:SetEnabled(false)
		end

		for i = 1, #mgn.LightEntities do
			mgn.LightEntities[i]:SetEnabled(false)
		end

		mgn.SetEmergencyTelevationMode(false)

		local screen = GetCoreInfoScreen()
		if IsValid(screen) then
			screen:SetDTInt(3, 0) -- damage status
			screen:SetDTInt(4, 0) -- radiation status
			SetGlobalBool("core_door", true) -- door status
		end

		local plys = player.GetAll()
		for i = 1, #plys do
			plys[i]._fly_restrict = nil
		end
	end
}
