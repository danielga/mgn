AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/SpeakerCluster01a.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
end

function ENT:OnRemove()
	self:SetEnabled(false)
end

util.AddNetworkString("mgn_siren")
