local doorloc = LMVector ~= nil and LMVector(-2091, 4912, -70, "land_caves", true) or nil
local doorradius = 100
local roomcenter = LMVector ~= nil and LMVector(-2083, 5142, -21, "land_caves", true) or nil

-- land position for emergency teleport target
local a = LMVector ~= nil and LMVector(-1886, 4962, -174, "land_caves", true):pos() or nil
local b = LMVector ~= nil and LMVector(-2289, 5281, -174, "land_caves", true):pos() or nil

local PLAYER = FindMetaTable("Player")

if roomcenter == nil or not roomcenter:inworld() then
	function mgn.SetEmergencyTelevationMode()
	end

	function PLAYER:EmergencyTelevate()
	end

	print("[MGN] Unable to find emergency televation destination!")
	return
end

local function GetDoor()
	local door = ents.FindByName"cbd1"[1]
	
	if IsValid(door) then return door end
	
	local doors = ents.FindInSphere(doorloc:pos(), doorradius)
	for i = 1, #doors do
		local door = doors[i]
		if door:GetClass() == "func_door" then
			return door -- there should be only one door with this setup
		end
	end
end

local function setsafetylockdoor(door,yes)
	local ent,dist = ents.closest(ents.FindByClass"lua_screen",door:GetPos())
	if dist<200 and ent:GetPlace():find"door" then
		local _ = ent.SetSafetyLock and ent:SetSafetyLock(yes)
	end
end

function mgn.SetEmergencyTelevationMode(e)

	local screens = ents.FindByClass("lua_screen")
	for i = 1, #screens do
		local screen = screens[i]
		if screen:GetPlace() == "elev" and screen.SetEmergency then
			screen:SetEmergency(e)
		end
	end

	local door = GetDoor()
	if door then
		local tid = "unlock_door_"..door:EntIndex()
		if e then
			if timer.Exists(tid) then
				timer.Destroy(tid)
			end
			door:Fire("close")
			door:Fire("lock")
			setsafetylockdoor(door,true)
		else
			timer.Create(tid,5,1,function()
				return IsValid(door) and door:Fire"unlock"
				setsafetylockdoor(door,false)
			end)
		end
	end

end

local vec = Vector(0, 0, a.z)
local function FindEscapePos(ply)
	vec.z = a.z

	for i = 1, 100 do
		vec.x = math.Rand(a.x, b.x)
		vec.y = math.Rand(a.y, b.y)
		if not ply:IsStuck(false, vec) then
			return vec
		end
	end

	vec.z = a.z + 80
	for i = 1, 100 do
		vec.x = math.Rand(a.x, b.x)
		vec.y = math.Rand(a.y, b.y)
		if not ply:IsStuck(true, vec) then
			return vec
		end
	end

	return a
end

local function Tesla(pos)
	local tesla = ents.Create("point_tesla")
	tesla:SetKeyValue("texture", "models/effects/comball_sphere.vmt")
	tesla:SetKeyValue("m_flRadius", "300")
	tesla:SetKeyValue("m_Color", "255 255 255")
	tesla:SetKeyValue("beamcount_min", "20")
	tesla:SetKeyValue("beamcount_max", "50")
	tesla:SetKeyValue("thick_min", "5")
	tesla:SetKeyValue("thick_max", "10")
	tesla:SetKeyValue("lifetime_min", "0.5")
	tesla:SetKeyValue("lifetime_max", "1")
	tesla:SetKeyValue("interval_min", "0.1")
	tesla:SetKeyValue("interval_max", "0.1")
	tesla:SetPos(pos)
	tesla:Spawn()
	tesla:Activate()
	tesla:Fire("DoSpark")
	tesla:Fire("Kill", "", 1)
end

local function TelevateCoroutine(ply, scr, edat)
	ply:EmitSound("buttons/button1.wav")

	co.sleep(0.1)

	ply:EmitSound("hl1/ambience/port_suckout1.wav")

	util.ScreenShake(ply:GetPos(), 0.6, 4, 4, 128)

	co.sleep(2.5)

	local white = Color(255, 255, 255, 255)
	ply:EmitSound("ambient/voices/citizen_beaten3.wav")
	ply:ScreenFade(SCREENFADE.IN, white, 1, 1)

	co.sleep(0.5)

	local center = ply:OBBCenter()
	Tesla(ply:GetPos() + center)
	local escpos = FindEscapePos(ply)
	ply:SetPos(escpos)
	Tesla(escpos + center)
	ply:ScreenFade(SCREENFADE.IN, white, 1, 1)
end

function PLAYER:EmergencyTelevate(screen, edat)
	if self.EmergencyTelevator and coroutine.status(self.EmergencyTelevator) == "suspended" then
		return
	end

	self.EmergencyTelevator = co(TelevateCoroutine, self, screen, edat)
end
