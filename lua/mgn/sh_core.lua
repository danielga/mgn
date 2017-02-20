mgn = mgn or {}

if SERVER then
	include("sv_core.lua")
else
	include("cl_core.lua")
end

mgn.AlertLength = 206
mgn.AlertActive = false
mgn.AlertStart = 0

function mgn.IsAlertActive()
	return mgn.AlertActive
end

function mgn.GetAlertStart()
	return mgn.AlertStart
end

hook.Add("PlayerNoClip", "mgn.PlayerNoClip", function(ply)
	if mgn.IsAlertActive() and ply:GetMoveType() ~= MOVETYPE_NOCLIP then
		return false
	end
end)
