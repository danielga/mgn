ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Core control computer"
ENT.Author = "MetaMan"
ENT.Information = "A computer that sits in the core room and controls stuff."
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PhysgunDisabled = true
ENT.m_tblToolsAllowed = {}

function ENT:IsAlertActive()
	return self:GetAlertStart() ~= 0
end

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "AlertStart")

	if CLIENT then
		self:NetworkVarNotify("AlertStart", function(ent, name, old, new)
			if old == new then
				return
			end

			mgn.SetAlertActive(new ~= 0, new)
		end)
	end
end
