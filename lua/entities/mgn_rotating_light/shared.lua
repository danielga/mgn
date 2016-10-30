ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Rotating alert light"
ENT.Author = "MetaMan"
ENT.Information = "A rotating, red alert light."
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.PhysgunDisabled = true
ENT.m_tblToolsAllowed = {}

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Enabled")

	if SERVER then
		self:NetworkVarNotify("Enabled", function(ent, name, old, new)
			if old == new then
				return
			end

			if new then
				ent.Spotlight1:Fire("LightOn", "", 0)
				ent.Spotlight2:Fire("LightOn", "", 0)
				ent:SetModel("models/props_c17/light_cagelight01_on.mdl")
			else
				ent.Spotlight1:Fire("LightOff", "", 0)
				ent.Spotlight2:Fire("LightOff", "", 0)
				ent:SetModel("models/props_c17/light_cagelight01_off.mdl")
			end
		end)
	end
end
