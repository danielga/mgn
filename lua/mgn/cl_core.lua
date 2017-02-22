include("cl_vox.lua")
include("stages/sh_idle.lua")
include("stages/cl_exploding.lua")
include("stages/cl_overloading.lua")
include("stages/cl_intro.lua")

hook.Add("Think", "mgn.Activation", function()
	-- CLIENTSIDE HACK TIME

	if IsValid(mgn.ControlComputer) then
		local overload_active = mgn.ControlComputer:IsOverloading()
		local system_active = mgn.IsOverloading()
		if not overload_active and system_active then
			mgn.InterruptOverload()
		elseif overload_active and not system_active then
			mgn.InitiateOverload(mgn.ControlComputer:GetOverloadStart())
		end
	end

	-- END CLIENTSIDE HACK TIME
end)

function mgn.InitiateOverload(start)
	assert(IsValid(mgn.ControlComputer), "Attempting to initiate overload when the control computer was not found.")

	if mgn.IsOverloading() then
		return
	end

	mgn.OverloadStage = mgn.Stage.Intro
	mgn.OverloadStart = start or CurTime()
end

function mgn.InterruptOverload()
	assert(IsValid(mgn.ControlComputer), "Attempting to shutdown overload when the control computer was not found.")

	if not mgn.IsOverloading() then
		return
	end

	if mgn.OverloadStage.End then
		mgn.OverloadStage:End(CurTime())
	end

	mgn.OverloadStage.Started = false
	mgn.OverloadStage.StartTime = 0

	mgn.OverloadStage = mgn.Stage.Idle
	mgn.OverloadStart = 0
end
