resource.AddWorkshop("790576613") -- vox audio files

AddCSLuaFile("sh_core.lua")
AddCSLuaFile("sh_locations.lua")
AddCSLuaFile("cl_core.lua")
AddCSLuaFile("cl_vox.lua")
AddCSLuaFile("cl_voxlist.lua")
AddCSLuaFile("stages/sh_idle.lua")
AddCSLuaFile("stages/cl_exploding.lua")
AddCSLuaFile("stages/cl_overloading.lua")
AddCSLuaFile("stages/cl_intro.lua")

include("sv_televators.lua") -- metastruct televators specific code
include("sh_locations.lua") -- metastruct specific entity placements
include("stages/sh_idle.lua")
include("stages/sv_exploding.lua")
include("stages/sv_overloading.lua")
include("stages/sv_intro.lua")

mgn.AlarmEntities = mgn.AlarmEntities or {}

mgn.LightEntities = mgn.LightEntities or {}

function mgn.InitiateOverload()
	assert(IsValid(mgn.ControlComputer), "Attempting to set activation status when the control computer was not found.")

	if mgn.IsOverloading() then
		return
	end

	local curtime = CurTime()
	mgn.OverloadStage = mgn.Stage.Intro
	mgn.OverloadStart = curtime
	mgn.ControlComputer:SetOverloadStart(curtime)
end

function mgn.InterruptOverload()
	assert(IsValid(mgn.ControlComputer), "Attempting to set activation status when the control computer was not found.")

	if not mgn.IsOverloading() then
		return
	end

	if mgn.OverloadStage.End then
		mgn.OverloadStage:End(CurTime())
	end

	mgn.OverloadStage.Started = false
	mgn.OverloadStage.StartedAt = 0

	mgn.OverloadStage = mgn.Stage.Idle
	mgn.OverloadStart = 0
	mgn.ControlComputer:SetOverloadStart(0)
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
			local position, angles, light =
				mgn.LightLocations[i].Position,
				mgn.LightLocations[i].Angles,
				mgn.LightEntities[i]

			if IsValid(light) then
				light:SetID(i)
				light:SetPos(position)
				light:SetAngles(angles)
			else
				light = ents.Create("mgn_floor_lights")
				light:SetID(i)
				light:SetPos(position)
				light:SetAngles(angles)
				light:Spawn()

				mgn.LightEntities[i] = light
			end
		end
	end
end
hook.Add("InitPostEntity", "mgn.Initialize", mgn.Initialize)
hook.Add("PostCleanupMap", "mgn.PostCleanupMap", mgn.Initialize)
