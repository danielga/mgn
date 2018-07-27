include("shared.lua")

function ENT:ShouldActivate()
	return not mgn.HideCVar:GetBool() and ( self:GetEnabled() or GetGlobalBool( "mgn_alarms_enabled", false ) )
end

function ENT:Think()
	if self:ShouldActivate() then
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

net.Receive("mgn_siren",function()
	for k,v in next,ents.FindByClass"mgn_siren" do 
		v:SetEnabled(false)
	end
end)