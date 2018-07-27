include("shared.lua")

ENT.Sprite = Material("sprites/light_glow02_add")
ENT.Green = Color(0, 255, 0, 255)

function ENT:Initialize()
	self:AddEffects(bit.bor(EF_NOSHADOW, EF_NORECEIVESHADOW))

	self.CurrentLight = 0
	self.mgn = mgn
end

function ENT:ShouldActivate()
	return not self.mgn.HideCVar:GetBool() and ( self:GetEnabled() or GetGlobalBool( "mgn_alarms_enabled", false ) )
end

function ENT:Think()
	if self:ShouldActivate() then
		local light = self.mgn.LightLocations[self:GetID()]
		if light then
			self.CurrentLight = (self.CurrentLight + 1) % light.LightCount

			-- TODO: This is not optimal but since it's only called once a second, I'll let it slide for now
			local hwidth, hdepth, hssize = light.Width / 2, light.Depth / 2, light.SpriteSize / 2
			self:SetRenderBounds(Vector(-hdepth - hssize, -hwidth - hssize, -hssize), Vector(hdepth + hssize, hwidth + hssize, hssize))
		end
	end

	self:SetNextClientThink(CurTime() + 1)
end

function ENT:Draw()
	if self:ShouldActivate() then
		local light = self.mgn.LightLocations[self:GetID()]
		if not light then
			return
		end

		render.SetMaterial(self.Sprite)

		local ssize, hwidth, hdepth, lcount = light.SpriteSize, light.Width / 2, light.Depth / 2, light.LightCount
		local forward = self.CurrentLight * hdepth / lcount - hdepth * (0.5 - 1 / (2 * lcount))
		if light.DoubleStriped then
			render.DrawSprite(self:GetPos() - self:GetRight() * hwidth + self:GetForward() * forward, ssize, ssize, self.Green)
			render.DrawSprite(self:GetPos() + self:GetRight() * hwidth + self:GetForward() * forward, ssize, ssize, self.Green)
		else
			render.DrawSprite(self:GetPos() + self:GetForward() * forward, ssize, ssize, self.Green)
		end
	end
end
