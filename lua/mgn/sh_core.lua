mgn = mgn or {}

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("cl_core.lua")
	AddCSLuaFile("lua_screens/screens/elev_mgn.lua")

	include("sv_core.lua")
else
	include("cl_core.lua")
end

hook.Add("PopulateLuaScreens", "MGN", function()
	include("lua_screens/screens/elev_mgn.lua")
end)
