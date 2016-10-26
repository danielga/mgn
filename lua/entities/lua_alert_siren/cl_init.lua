include("shared.lua")

function ENT:Initialize()
	self.AlertSound = CreateSound(self, "ambient/alarms/alarm_citizen_loop1.wav")
	self.AlertSound:SetSoundLevel(90)
end

function ENT:OnRemove()
	if self.AlertSound:IsPlaying() then
		self.AlertSound:Stop()
	end
end

function ENT:Think()
	if self:GetEnabled() and not self.AlertSound:IsPlaying() then
		self.AlertSound:Play()
	elseif not self:GetEnabled() and self.AlertSound:IsPlaying() then
		self.AlertSound:Stop()
	end
end

function ENT:Draw()
	self:DrawModel()
end
