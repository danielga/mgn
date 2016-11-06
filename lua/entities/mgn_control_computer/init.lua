AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_combine/combine_interface001.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)

	mgn.ControlComputer = self
end

function ENT:UpdateTransmitState()
	return TRANSMIT_ALWAYS
end
