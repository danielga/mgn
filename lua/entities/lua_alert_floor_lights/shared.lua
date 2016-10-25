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
	self:NetworkVar("Bool", 1, "DoubleStriped")
	self:NetworkVar("Int", 0, "Width")
	self:NetworkVar("Int", 1, "Depth")
	self:NetworkVar("Int", 2, "SpriteSize")
	self:NetworkVar("Int", 3, "LightCount")

	if CLIENT then
		self:NetworkVarNotify("Width", function(ent, name, old, new)
			if old == new then
				return
			end

			local half = new / 2
			local min, max = ent:GetRenderBounds()
			min.y = -half
			max.y = half
			ent:SetRenderBounds(min, max)
		end)

		self:NetworkVarNotify("Depth", function(ent, name, old, new)
			if old == new then
				return
			end

			local half = new / 2
			local min, max = ent:GetRenderBounds()
			min.x = -half
			max.x = half
			ent:SetRenderBounds(min, max)
		end)
	end
end
