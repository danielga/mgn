ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Alert siren"
ENT.Author = "MetaMan"
ENT.Information = "A loud alert siren."
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PhysgunDisabled = true
ENT.m_tblToolsAllowed = {}

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Enabled")
end
