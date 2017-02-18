mgn = mgn or {}

if SERVER then
	include("sv_core.lua")
else
	include("cl_core.lua")
end
include("sh_explosion.lua")

mgn.AlertLength = 206
mgn.AlertActive = false
mgn.AlertStart = 0

function mgn.IsAlertActive()
	return mgn.AlertActive
end

function mgn.GetAlertStart()
	return mgn.AlertStart
end

hook.Add("PlayerNoClip", "mgn.PlayerNoClip", function()
	if mgn.IsAlertActive() then
		return false
	end
end)
