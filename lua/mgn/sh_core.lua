mgn = mgn or {}

if SERVER then
	include("sv_core.lua")
else
	include("cl_core.lua")
end

function mgn.IsAlertActive()
	return GetGlobalBool("MGN_AlertActive")
end

hook.Add("PlayerNoClip", "mgn.PlayerNoClip", function()
	if mgn.IsAlertActive() then
		return false
	end
end)
