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

sound.Add({
	name = "alarm_citizen_loop1",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 130,
	pitch = 100,
	sound = "ambient/alarms/alarm_citizen_loop1.wav"
})

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Enabled")
end
