ENT.Width  = 30
ENT.Height = 25
ENT.Scale  = 0.1

ENT.SELF_DESTRUCT = 1
ENT.CANCEL = 2

function ENT:IsAlertActive()
	return self:GetAlertStart() ~= 0
end

function ENT:GetAlertStart()
	return self:GetDTFloat(0)
end

if SERVER then
	return
end

ENT.Denied = false
ENT.Granted = false
ENT.HideMessageTime = 0
ENT.AlertActive = false

function ENT:Initialize()
	mgn.ControlComputer = self
end

function ENT:DrawCenteredWordBox(text, font, x, y, bc, tc)
	surface.SetFont(font)
	local tw, th = surface.GetTextSize(text)
	draw.WordBox(2, x - tw / 2, y - th / 2, text, font, bc, tc)
end

local white = Color(255, 255, 255, 255)
local red = Color(255, 0, 0, 255)
local green = Color(0, 255, 0, 255)
function ENT:Draw3D2D(width, height)
	self:DrawCenteredWordBox("CORE CONTROL PANEL", "Trebuchet24", width / 2, 30, white, red)

	self:DrawCenteredWordBox("SELF-DESTRUCT", "Trebuchet24", width / 2, 100, red, white)

	self:DrawCenteredWordBox("CANCEL", "Trebuchet24", width / 2, 150, green, white)

	if self.Denied then
		self:DrawCenteredWordBox("ACCESS DENIED", "Trebuchet24", width / 2, 200, red, white)
	elseif self.Granted then
		self:DrawCenteredWordBox("ACCESS GRANTED", "Trebuchet24", width / 2, 200, green, white)
	end
end

function ENT:Think()
	if (self.Denied or self.Granted) and CurTime() >= self.HideMessageTime then
		self.Denied = false
		self.Granted = false
	end

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
		self:CallOnServer(self.SELF_DESTRUCT)
	elseif mx >= w / 2 - tw / 2 and mx <= w / 2 + tw / 2 and my >= 150 - th / 2 and my <= 150 + th / 2 then
		self:CallOnServer(self.CANCEL)
	end
end
