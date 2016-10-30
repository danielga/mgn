mgn = mgn or {}

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("cl_core.lua")

	include("sv_core.lua")
else
	include("cl_core.lua")
end

hook.Add("Initialize", "MGN", function()
	LuaScreen.LoadScreen("elev") -- load elev LuaScreen to make sure it is loaded before our elev_mgn
	LuaScreen.LoadScreen("elev_mgn") -- load elev_mgn LuaScreen to override elev code
end)
