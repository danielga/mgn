mgn = mgn or {}

if SERVER then
	include("sv_core.lua")
else
	include("cl_core.lua")
end

function mgn.IsAlertActive()
	return GetGlobalBool("MGN_AlertActive")
end

hook.Add("Initialize", "mgn.LoadLuaScreens", function()
	LuaScreen.LoadScreen("elev") -- load elev LuaScreen to make sure it is loaded before our elev_mgn
	LuaScreen.LoadScreen("elev_mgn") -- load elev_mgn LuaScreen to override elev code
end)

hook.Add("PlayerNoClip", "mgn.PlayerNoClip", function()
	if mgn.IsAlertActive() then
		return false
	end
end)
