mgn = mgn or {}

if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("client.lua")
	
	include("server.lua")
else
	include("client.lua")
end
