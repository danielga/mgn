function ENT:Initialize()
	local monitor = ents.Create("mgn_control_computer")
	monitor:SetPos(Vector(-13701, 2997, 14305))
	monitor:SetAngles(Angle(0, 0, 0))
	monitor:Spawn()

	self:SetParent(monitor) -- in case we move around the monitor prop
end

function ENT:CallCMD(ply, cmd)
	if not ply:IsSuperAdmin() then
		return
	end

	if cmd == self.SELF_DESTRUCT and not self:IsAlertActive() then
		mgn.SetAlertActive(true)
	elseif cmd == self.CANCEL and self:IsAlertActive() then
		mgn.SetAlertActive(false)
	end
end
