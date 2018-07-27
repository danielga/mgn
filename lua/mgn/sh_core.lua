mgn = mgn or {Stage = {}}

local mgn = mgn

mgn.HideCVarName = "mgn_hide"

if SERVER then
	include("sv_core.lua")
else
	include("cl_core.lua")
end

mgn.OverloadStage = mgn.Stage.Idle
mgn.OverloadStart = 0

function mgn.GetOverloadStage()
	return mgn.OverloadStage
end

function mgn.GetOverloadStart()
	return mgn.OverloadStart
end

function mgn.IsOverloading()
	return mgn.GetOverloadStage() ~= mgn.Stage.Idle
end

function mgn.StartStage( stage )

	local start_time = mgn.GetOverloadStart() + stage.StartTime
	stage.StartedAt = start_time

	if stage.Start then
		stage:Start(start_time)
	end

	stage.Started = true

end
function mgn.StopStage( stage )

	if stage.End then
		stage:End(curtime)
	end

	stage.Started = false
	stage.StartedAt = 0

	mgn.OverloadStage = stage.Next

end


hook.Add("PlayerNoClip", "mgn.PlayerNoClip", function(ply)
	local stage = mgn.GetOverloadStage()
	if (stage == mgn.Stage.Overloading or stage == mgn.Stage.Exploding) and ply:GetMoveType() ~= MOVETYPE_NOCLIP and ply:GetInfoNum( mgn.HideCVarName, 0 ) == 0 then
		return false
	end
end)

hook.Add("Think", "mgn.StageLogic", function()

	local stage = mgn.GetOverloadStage()

	if CLIENT then
		local halt = mgn.RunHideCheck( stage )
		if halt then return end
	end

	-- This stage is permanent since it can't tell us when it ends
	if not stage.Think then
		return
	end

	local curtime = CurTime()
	if not stage.Started then
		mgn.StartStage( stage )
	end

	if not stage:Think(curtime - stage.StartedAt) then
		mgn.StopStage( stage )
	end

end)
