-- this file isn't called elev.lua, which should be initialized by metastruct code
-- however, we can't be sure that, if this file was named elev.lua, it would override the original one
-- the current way, we can be assured we can do so

-- copy this LuaScreen code onto elev, overriding whatever is already there

local _data = LuaScreen.getdata(LuaScreen.toid("elev"))
if not _data then
	ErrorNoHalt("[MGN] No LuaScreen data for \"elev\"\n")
	return
end

_data.merge = ENT -- elev and elev_mgn will share tables

-- end of header, normal LuaScreen code after this line

ENT.Width = 152
ENT.Height = 114
ENT.Scale = 0.09

function ENT:GetPlayers()
	return self:GetDTInt(0)
end

function ENT:SetPlayers(pls)
	self:SetDTInt(0, pls)
end

function ENT:GetElevPlace()
	return self:GetDTString(0)
end

function ENT:GetDestination()
	return self:GetDTString(1)
end

function ENT:SetElevPlace(str)
	return self:SetDTString(0, str)
end

function ENT:SetDestination(str)
	return self:SetDTString(1, str)
end

function ENT:IsHacken()
	return self:GetDTBool(1)
end

function ENT:IsEmergency()
	return self:GetDTBool(2)
end

if SERVER then
	function ENT:SetHacken(b)
		return self:SetDTBool(1, b == nil or b)
	end

	function ENT:SetEmergency(b)
		return self:SetDTBool(2, b == nil or b)
	end

	function ENT:CallCMD(pl, data)
		local edat = ms.GetElevatorData(self:GetElevPlace())

		if data == "emerg" then
			if not self:IsEmergency() then
				print("No Emergency hakr", pl)
				return
			end

			local EmergencyTelevate = ms.EmergencyTelevate or function(...) print("EmergencyTelevatee", ...) end
			EmergencyTelevate(pl, self, edat)
		end

		if data == "h1" and not self:IsHacken() then
			print("[Hacken]", self, pl)
			self:SetHacken(true)
		elseif data == "h0" and self:IsHacken() then
			print("[Hacken] Disable", self, pl)
			self:SetHacken(false)
		end

		if self:IsHacken() and data ~= "MCLICK" then
			print("hacken", pl, data)

			local sn = data:match("^H(%d%d?)$")
			sn = sn and tonumber(sn)
			if sn then
				if sn == 13 then
					print("[Hacken] Disable", self, pl)
					self:SetHacken(false)
				elseif sn == 12 then
					ms.UseElevatorDoors(edat, true)
				elseif sn == 11 then
					ms.UseElevatorDoors(edat, false)
				elseif sn == 10 then
					pl.__megaspeed = not pl.__megaspeed
					pl:ChatPrint(pl.__megaspeed and "MegaSpeed On" or "MegaSpeed Off")
				elseif sn == 9 then
					edat.locked = true
				elseif sn == 8 then
					edat.locked = false
				elseif edat then
					WorldSound("HL1/fvox/boop.wav", edat.Entity:GetPos())
				end
			end
		end
	end

	return
end

language.Add("elevator_menu_hint", "Press use to initate the elevator")
language.Add("elevator_menu_moving", "Hold on tight, moving to the destination above!")

local dmode = {
	[13] = "Exit dev mode",
	[12] = "Doors open",
	[11] = "Doors closed",
	[10] = "Mega speed",
	[9] = "Lock",
	[8] = "Unlock"
}

local ms_elevator_music = GetConVar("ms_elevator_music")
function ENT:OnMouseClick(key)
	if self.muteselect then
		RunConsoleCommand("ms_elevator_music", ms_elevator_music:GetBool() and "0" or "1")
		return
	end

	local sn  = self.selected_num
	local hacken = self:IsHacken()

	if sn == 13 and LocalPlayer():KeyDown(IN_DUCK) and LocalPlayer():KeyDown(IN_SPEED) then
		if hacken then
			self:CallOnServer("h0")
		else
			self:CallOnServer("h1")
		end

		return
	end

	if hacken then
		if dmode[sn] then
			self:CallOnServer("H" .. sn)
			return
		end
	else
		local emerg = self:IsEmergency()
		if emerg and sn == 13 then
			self:CallOnServer("emerg")
		end
	end

	if self.selection and ms.IN_ELEVATOR then
		if self:IsHacken() then
			self:CallOnServer("h0")
		end

		ms.ElevatorRequest(self.selection, self:GetElevPlace())
	end
end

local surface = surface
local tostring = tostring

local ATbl = {[0] = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

local keys = {
	[0] = KEY_PAD_0,
	KEY_PAD_1,
	KEY_PAD_2,
	KEY_PAD_3,
	KEY_PAD_4,
	KEY_PAD_5,
	KEY_PAD_6,
	KEY_PAD_7,
	KEY_PAD_8,
	KEY_PAD_9
}

local pressed = nil
local tmp = {}

function ENT:Draw3D2D(wide, tall)
	local place = ms.GetElevatorData(self:GetElevPlace())
	if not place then
		return
	end

	local destid = self:GetDestination()
	local dest = ms.GetElevatorData(destid)

	place = dest or place
	if not place then
		return
	end

	local is = 1 / self.Scale
	local x, y = wide * 0.145, tall * 0.089
	local w, h = 46.94 * is, 72.94 * is
	local a = 0.3

	surface.SetDrawColor(191 * a, 193 * a, 194 * a, 253)
	surface.DrawRect(x, y, w, h)

	local hacken = self:IsHacken()
	local emerg = self:IsEmergency()
	if hacken or emerg then
		surface.SetDrawColor(190 + math.sin(RealTime() * 10) * 30, 33, 11, 200)
	else
		surface.SetDrawColor(60, 77, 200 + math.sin(RealTime() * 10) * 5, 200)
	end

	local sx, sy = x + w * 0.03, y + h * 0.05
	local sw, sh = w * (1 - 0.03 * 2), h * 0.15
	surface.DrawRect(sx, sy, sw, sh)

	surface.SetDrawColor(1, 5, 20, 253)
	surface.DrawOutlinedRect(sx, sy, sw, sh)

	-- Title
	local name = hacken and "DEV MODE" or place.name and tostring(place.name) or "unknown"
	local realplace = place
	local moving = dest and place == dest
	local text = moving and (realplace.name and tostring(realplace.name)) or name or "unknown"
	surface.SetTextColor(240, 245, 255, moving and 200 or 255)
	surface.SetFont("DermaLarge")
	local tw, th = surface.GetTextSize(text)
	local tx, ty = x + w * 0.5 - tw * 0.5, sy + sh * 0.02
	surface.SetTextPos(tx, ty)
	surface.DrawText(text)

	if moving then
		local text = name
		surface.SetTextColor(240, 245, 255, 255)
		local tw, th = surface.GetTextSize(text)
		local tx, ty = x + w * 0.5 - tw * 0.5, sy + sh * 0.02 + th
		surface.SetTextPos(tx, ty)
		surface.DrawText(text)

		local text = ">"
		surface.SetTextColor(130, 130, 255, 255)
		local tw2, th2 = surface.GetTextSize(text)
		local bounce = math.abs(math.sin(RealTime() * 7)) * tw2
		surface.SetTextPos(x + w * 0.5 - tw * 0.5 - tw2 - bounce, ty)
		surface.DrawText(text)

		surface.SetTextPos(x + w * 0.5 + tw * 0.5 + bounce, ty)
		surface.DrawText("<")
	end

	-- Max 123 people
	surface.SetFont("Trebuchet24")
	surface.SetTextColor(200, 222, 255, 255)

	local pls = self:GetPlayers()
	local txt = ("Capacity: %d / 10 people"):format(pls or 0)
	local tw, th = surface.GetTextSize(txt)
	surface.SetTextPos(sx + th * 0.3, sy + sh - th - th - th * 0.3)
	surface.DrawText(txt)

	surface.SetTextPos(sx + th * 0.3, sy + sh - th - th * 0.3)
	surface.DrawText("Have a safe and productive day!")

	-- Selection Boxes
	self.selection = nil

	local tbl = realplace
	if not tbl then
		return
	end

	tbl = tbl.targets
	if not tbl then
		return
	end

	local _i = 0
	for k, v in next, tbl do
		_i = _i + 1
		tmp[_i * 2 + 1] = k
		tmp[_i * 2] = v
	end

	self.selected_num = -1

	local q = 1 - FrameTime() * 3
	local margin = w * 0.01
	local bw, bh = w - margin * 2, h * 0.05 - margin
	local realbw = bw
	bw = bh * 1.6
	for i = 0, 13 do
		local key, val
		if i < _i then
			key, val = tmp[(1 + i) * 2 + 1], tmp[(1 + i) * 2]
		end

		local bx, by = x + margin, y + h - bh - margin - (1 + margin + bh) * i
		local selected = self:MouseInBox(bx, by, realbw, bh)
		if selected then
			self.selected_num = i
		end

		local alpha = ATbl[i] * q + (selected and 1 or 0) * (1 - q)
		ATbl[i] = alpha

		surface.SetDrawColor(230, 200, 200, 11 + alpha * 111)
		if moving and destid == key then
			surface.SetDrawColor(250, 100, 100, 150 + alpha * 50)
		end

		surface.DrawRect(bx, by, bw, bh)
		local emerg_button = i == 13 and emerg

		-- draw data
		if not key and not hacken and not emerg then
			continue
		end

		if emerg_button then
			key, val = "EMERGENCY LOCATION", "EMERGENCY LOCATION"
		end

		-- selection system
		if selected then
			self.selection = key
		end

		-- use numpad system
		if self.targeted then
			local k = i < 10 and keys[i]
			if k then
				local down = input.IsKeyDown(k)
				if down and not pressed then
					self.selection = key
					self:OnMouseClick(0, 0)
					pressed = k
				elseif pressed and k == pressed and not down then
					pressed = false
				end
			end
		end

		surface.SetDrawColor(0, 0, 0, 55)
		surface.DrawRect(bx + bw + margin, by, realbw - bw - margin * 2, bh)

		surface.SetFont("DermaLarge")
		surface.SetTextColor(200, 222, 255, 255)
		local tw, th = surface.GetTextSize(i)
		surface.SetTextPos(bx + bw * 0.2, by + bh * 0.5 - th * 0.5)
		surface.DrawText(i)

		surface.SetFont("closecaption_normal")
		if emerg_button then
			surface.SetTextColor(240, 20, 70, 255)
		else
			surface.SetTextColor(200, 222, 255, 255)
		end

		local tw, th = surface.GetTextSize(i)
		surface.SetTextPos(bx + bw + margin * 2, by + bh * 0.5 - th * 0.5)
		surface.DrawText(hacken and dmode[i] or val or key or "")
	end

	self:DrawMusic(wide, tall)
end

local nosound = Material("icon16/sound_mute.png")
local onsound = Material("icon16/sound.png")
function ENT:DrawMusic(w, h)
	local iw = w * 0.03
	local x, y, tw, th = w * 0.8, h * 0.625 - iw, iw, iw

	surface.SetDrawColor(0, 0, 0, 100)
	surface.DrawRect(x - iw * 0.5, y - iw * 0.2, tw + iw, th + iw * 0.5)

	surface.SetDrawColor(200, 200, 200, 200)
	if self:MouseInBox(x, y, tw, th) then
		self.muteselect = true
		surface.SetDrawColor(255, 255, 255, 255)
	elseif self.muteselect then
		self.muteselect	= false
	end

	local musicon = ms_elevator_music:GetBool()
	surface.SetMaterial(musicon and onsound or nosound)
	surface.DrawTexturedRect(x, y, tw, th)
end
