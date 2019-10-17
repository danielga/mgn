local mgn = mgn

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
			-- pair.Siren:SetEnabled(true) handled by mgn_alarms_enabled
		end

		--[[
		for i = 1, #mgn.LightEntities do
			mgn.LightEntities[i]:SetEnabled(true)
		end
		]]

		SetGlobalBool("mgn_alarms_enabled", true)

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
			if ply:GetInfoNum(mgn.HideCVarName, 0) ~= 0 then continue end
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

			-- handled by mgn_alarms_enabled
			-- pair.Siren:SetEnabled(false)
			-- net.Start("mgn_siren")
			-- net.Broadcast()
		end

		--[[
		for i = 1, #mgn.LightEntities do
			mgn.LightEntities[i]:SetEnabled(false)
		end
		]]

		SetGlobalBool("mgn_alarms_enabled", false)

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
