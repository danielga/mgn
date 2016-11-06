function ENT:Initialize()
	local monitor = ents.Create("prop_physics")
	monitor:SetModel("models/props_combine/combine_interface001.mdl")
	monitor:SetPos(Vector(-13701, 2997, 14305))
	monitor:SetAngles(Angle(0, 0, 0))
	monitor:Spawn()

	local physobj = monitor:GetPhysicsObject()
	if IsValid(physobj) then
		physobj:EnableMotion(false)
	end

	self:SetParent(monitor) -- in case we move around the monitor prop
end

function ENT:IsAlertActive()
	return CurTime() - self:GetAlertStart() <= mgn.AlertLength
end

function ENT:SetAlertActive(b)
	self:SetAlertStart(b and CurTime() or 0)
end

function ENT:GetAlertStart()
	return self:GetNWFloat("AlertStart")
end

function ENT:SetAlertStart(t)
	self:SetNWFloat("AlertStart", t)
end

function ENT:CallCMD(ply, cmd)
	if not ply:IsSuperAdmin() then
		return
	end

	if cmd == self.SELF_DESTRUCT and not self:IsAlertActive() then
		self:SetAlertActive(true)
	elseif cmd == self.CANCEL and self:IsAlertActive() then
		self:SetAlertActive(false)
	end
end
