include("shared.lua")

ENT.AlertActive = false

function ENT:Initialize()
	mgn.ControlComputer = self
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	-- CLIENTSIDE HACK TIME

	local alert_start = self:GetAlertStart()
	if self.AlertActive and alert_start == 0 then
		self.AlertActive = false
		mgn.SetAlertActive(false)
	elseif not self.AlertActive and alert_start ~= 0 then
		self.AlertActive = true
		mgn.SetAlertActive(true, alert_start)
	end

	-- END CLIENTSIDE HACK TIME
end
