resource.AddWorkshop("790576613") -- vox audio files

AddCSLuaFile("sh_core.lua")
AddCSLuaFile("cl_explosion.lua")
AddCSLuaFile("cl_core.lua")
AddCSLuaFile("cl_vox.lua")
AddCSLuaFile("cl_voxlist.lua")

include("sv_explosion.lua")
include("sv_televators.lua") -- metastruct televators specific code
include("sv_locations.lua") -- metastruct specific entity placements

mgn.AlarmEntities = mgn.AlarmEntities or {}

mgn.LightEntities = mgn.LightEntities or {}

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

function mgn.SetAlertActive(activate)
	assert(IsValid(mgn.ControlComputer), "Attempting to set activation status when the control computer was not found.")
	assert(type(activate) == "boolean", "Attempting to set activation status with a non-boolean.")

	if (activate and mgn.IsAlertActive()) or (not activate and not mgn.IsAlertActive()) then
		return
	end

	for i = 1, #mgn.AlarmEntities do
		local pair = mgn.AlarmEntities[i]
		pair.Light:SetEnabled(activate)
		pair.Siren:SetEnabled(activate)
	end

	for i = 1, #mgn.LightEntities do
		mgn.LightEntities[i]:SetEnabled(activate)
	end

	mgn.SetEmergencyTelevationMode(activate)

	local screen = GetCoreInfoScreen()
	if IsValid(screen) then
		screen:SetDTInt(3, activate and 100 or 0) -- damage status
		screen:SetDTInt(4, activate and -1 or 0) -- radiation status
		SetGlobalBool("core_door", not activate) -- door status
	end

	mgn.Exploded = false
	mgn.ExplosionActive = false
	mgn.ExplosionLastTick = 0
	mgn.ExplosionStart = 0

	mgn.AlertActive = activate
	mgn.AlertStart = activate and CurTime() or 0
	mgn.ControlComputer:SetAlertStart(mgn.AlertStart)
end

function mgn.Initialize()
	for i = 1, math.max(#mgn.AlarmLocations, #mgn.AlarmEntities) do
		if not mgn.AlarmLocations[i] then
			local pair = mgn.AlarmEntities[i]
			if IsValid(pair.Light) then
				pair.Light:Remove()
			end

			if IsValid(pair.Siren) then
				pair.Siren:Remove()
			end

			mgn.AlarmEntities[i] = nil
		else
			local position = mgn.AlarmLocations[i].Position
			local normal = mgn.AlarmLocations[i].Normal

			local pair = mgn.AlarmEntities[i]
			if not pair then
				pair = {}
				mgn.AlarmEntities[i] = pair
			end

			if IsValid(pair.Light) then
				pair.Light:SetPos(position + normal)
				pair.Light:SetAngles(normal:Angle())
			else
				local light = ents.Create("mgn_rotating_light")
				light:SetPos(position + normal)
				light:SetAngles(normal:Angle())
				light:Spawn()

				pair.Light = light
			end

			if IsValid(pair.Siren) then
				pair.Siren:SetPos(position + Vector(0, 0, 30) + normal * 10)
				pair.Siren:SetAngles(normal:Angle())
			else
				local siren = ents.Create("mgn_siren")
				siren:SetPos(position + Vector(0, 0, 30) + normal * 10)
				siren:SetAngles(normal:Angle())
				siren:Spawn()

				pair.Siren = siren
			end
		end
	end

	for i = 1, math.max(#mgn.LightLocations, #mgn.LightEntities) do
		if not mgn.LightLocations[i] then
			local light = mgn.LightEntities[i]
			if IsValid(light) then
				light:Remove()
			end

			mgn.LightEntities[i] = nil
		else
			local position, angles, dstriped, width, depth, ssize, lcount, light =
				mgn.LightLocations[i].Position,
				mgn.LightLocations[i].Angles,
				mgn.LightLocations[i].DoubleStriped,
				mgn.LightLocations[i].Width,
				mgn.LightLocations[i].Depth,
				mgn.LightLocations[i].SpriteSize,
				mgn.LightLocations[i].LightCount,
				mgn.LightEntities[i]

			if IsValid(light) then
				light:SetPos(position)
				light:SetAngles(angles)
				light:SetDoubleStriped(dstriped)
				light:SetWidth(width)
				light:SetDepth(depth)
				light:SetSpriteSize(ssize)
				light:SetLightCount(lcount)
			else
				light = ents.Create("mgn_floor_lights")
				light:SetPos(position)
				light:SetAngles(angles)
				light:SetDoubleStriped(dstriped)
				light:SetWidth(width)
				light:SetDepth(depth)
				light:SetSpriteSize(ssize)
				light:SetLightCount(lcount)
				light:Spawn()

				mgn.LightEntities[i] = light
			end
		end
	end

	mgn.SetAlertActive(false)
end
hook.Add("Initialize", "mgn.Initialize", mgn.Initialize)
