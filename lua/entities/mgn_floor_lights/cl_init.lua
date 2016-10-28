include("shared.lua")

ENT.Sprite = Material("sprites/light_glow02_add")
ENT.Green = Color(0, 255, 0, 255)

function ENT:Initialize()
	self:AddEffects(bit.bor(EF_NOSHADOW, EF_NORECEIVESHADOW))

	self.CurrentLight = 0
end

function ENT:Think()
	if self:GetEnabled() then
		self.CurrentLight = (self.CurrentLight + 1) % self:GetLightCount()
	end

	--local hwidth, hdepth, hssize = self:GetWidth() / 2, self:GetDepth() / 2, self:GetSpriteSize() / 2
	--self:SetRenderBounds(Vector(-hdepth - hssize, -hwidth - hssize, -hssize), Vector(hdepth + hssize, hwidth + hssize, hssize))

	self:SetNextClientThink(CurTime() + 0.2)
end

function ENT:Draw()
	if self:GetEnabled() then
		render.SetMaterial(self.Sprite)

		local ssize, hwidth, hdepth, lcount = self:GetSpriteSize(), self:GetWidth() / 2, self:GetDepth() / 2, self:GetLightCount()
		local forward = self.CurrentLight * hdepth / lcount - hdepth * (0.5 - 1 / (2 * lcount))
		if self:GetDoubleStriped() then
			render.DrawSprite(self:GetPos() - self:GetRight() * hwidth + self:GetForward() * forward, ssize, ssize, self.Green)
			render.DrawSprite(self:GetPos() + self:GetRight() * hwidth + self:GetForward() * forward, ssize, ssize, self.Green)
		else
			render.DrawSprite(self:GetPos() + self:GetForward() * forward, ssize, ssize, self.Green)
		end
	end
end
