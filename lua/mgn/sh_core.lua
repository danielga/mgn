mgn = mgn or {}

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("cl_core.lua")

	include("sv_core.lua")
else
	include("cl_core.lua")
end
