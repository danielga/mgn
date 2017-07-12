AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/SpeakerCluster01a.mdl")
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)

	self.Enabled = false
end

function ENT:OnRemove()
	self:SetEnabled(false)
end

function ENT:SetEnabled(state)
	if state == self.Enabled then
		return
	end

	self.Enabled = state

	if state then
		self:EmitSound("alarm_citizen_loop1")
	else
		self:StopSound("alarm_citizen_loop1")
	end
end

function ENT:GetEnabled()
	return self.Enabled
end
