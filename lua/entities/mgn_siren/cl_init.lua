include("shared.lua")

function ENT:Think()
	if self:GetEnabled() then
		self.Sound = CreateSound(self, "alarm_citizen_loop1")
		self.Sound:Play()
	elseif self.Sound then
		self.Sound:Stop()
		self.Sound = nil
	end

	self:SetNextClientThink(CurTime() + 0.2)
end

function ENT:OnRemove()
	if self.Sound then
		self.Sound:Stop()
		self.Sound = nil
	end
end

function ENT:Draw()
	self:DrawModel()
end
