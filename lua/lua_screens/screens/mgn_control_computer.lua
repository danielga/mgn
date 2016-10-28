ENT.Width  = 30
ENT.Height = 25
ENT.Scale  = 0.1

if SERVER then
	return
end

ENT.Denied = false
ENT.Granted = false
ENT.HideMessageTime = 0

function ENT:DrawCenteredWordBox(text, font, x, y, bc, tc)
	surface.SetFont(font)
	local tw, th = surface.GetTextSize(text)
	draw.WordBox(2, x - tw / 2, y - th / 2, text, font, bc, tc)
end

local white = Color(255, 255, 255, 255)
local red = Color(255, 0, 0, 255)
local green = Color(0, 255, 0, 255)
function ENT:Draw3D2D(width, height)
	self:DrawCenteredWordBox("CORE CONTROL PANEL", "Trebuchet24", w / 2, 30, white, red)
	
	self:DrawCenteredWordBox("SELF-DESTRUCT", "Trebuchet24", w / 2, 100, red, white)
	
	self:DrawCenteredWordBox("NORMAL", "Trebuchet24", w / 2, 150, green, white)

	if self.Denied then
		self:DrawCenteredWordBox("ACCESS DENIED", "Trebuchet24", w / 2, 200, red, white)
	elseif self.Granted then
		self:DrawCenteredWordBox("ACCESS GRANTED", "Trebuchet24", w / 2, 200, green, white)
	end
end

function ENT.BackwardsClass:Think()
	if (self.Denied or self.Granted) and CurTime() >= self.HideMessageTime then
		self.Denied = false
		self.Granted = false
	end
end

function ENT:OnMouseClick(keycode)
	self.HideMessageTime = CurTime() + 3

	if not LocalPlayer():IsSuperAdmin() then
		self.Denied = true
		return
	end

	self.Granted = true

	local w, h = self:GetWide(), self:GetTall()
	local mx, my = self:MousePos()
	
	surface.SetFont("Trebuchet24")
	local tw, th = surface.GetTextSize("SELF-DESTRUCT")
	
	if mx >= w / 2 - tw / 2 and mx <= w / 2 + tw / 2 and my >= 100 - th / 2 and my <= 100 + th / 2 then
		self:CallOnServer("SELF-DESTRUCT")
	elseif mx >= w / 2 - tw / 2 and mx <= w / 2 + tw / 2 and my >= 150 - th / 2 and my <= 150 + th / 2 then
		self:CallOnServer("NORMAL")
	end
end
