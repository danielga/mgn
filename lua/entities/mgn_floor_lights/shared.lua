ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Emergency floor lights"
ENT.Author = "MetaMan"
ENT.Information = "Configurable emergency floor lights."
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PhysgunDisabled = true
ENT.m_tblToolsAllowed = {}

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Enabled")
	self:NetworkVar("Int", 0, "ID")
end
