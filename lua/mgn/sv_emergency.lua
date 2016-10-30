local doorpos = LMVector(-2106, 5160, -110, "land_caves", true)
local doorradius = 100
local center = LMVector(-2083, 5142, -21, "land_caves", true)

-- land position for emergency teleport target
local a = LMVector(-1886, 4962, -174, "land_caves", true):pos()
local b = LMVector(-2289, 5281, -174, "land_caves", true):pos()

if not center:inworld() then
	return
end

local function door()
	local doors = ents.FindInSphere(doorpos, doorradius)
	for i = 1, #doors do
		local door = doors[i]
		if door:GetClass() == "func_door" then
			return door -- there should be only one door with this setup
		end
	end
end

function ms.TelevatorSetEmergency(e)
	e = e or e == nil

	local screens = ents.FindByClass("lua_screen")
	for i = 1, #screens do
		local screen = screens[i]
		if screen:GetPlace() == "elev" and screen.SetEmergency then
			screen:SetEmergency(e)
		end
	end
end

function ms.SetEmergencyTelevationMode(e)
	e = e or e == nil

	if (emergency_televation_mode and e) or (not emergency_televation_mode and not e) then
		return
	end

	emergency_televation_mode = e

	local door = door()
	if e then
		door:Fire"close"
		door:Fire"lock"
	else
		door:Fire"unlock"
		door:Fire"open"
	end

	TelevatorSetEmergency(e)

	Print("EmergencyMode", e and "ENABLED" or "disabled")
end

local vec = Vector(0, 0, a.z)
local function FindEscapePos(pl)
	vec.z = a.z

	for i = 1, 100 do
		vec.x = math.Rand(a.x, b.x)
		vec.y = math.Rand(a.y, b.y)
		if not pl:IsStuck(false, vec) then
			return vec
		end
	end

	vec.z = a.z + 80
	for i = 1, 100 do
		vec.x = math.Rand(a.x, b.x)
		vec.y = math.Rand(a.y, b.y)
		if not pl:IsStuck(true, vec) then
			return vec
		end
	end

	return a
end

local function co_telev(pl,scr,edat)
	pl:EmitSound("buttons/button1.wav")

	co.sleep(0.1)

	pl:EmitSound("hl1/ambience/port_suckout1.wav")

	util.ScreenShake(pl:GetPos(), 0.6, 4, 4, 128)

	co.sleep(2.5)

	pl:EmitSound("ambient/voices/citizen_beaten3.wav")
	pl:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 255), 1, 1)

	co.sleep(0.5)

	pl:SetPos(FindEscapePos(pl))
	pl:ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 255), 1, 1)
end

function ms.EmergencyTelevate(pl, ...)
	if pl.emergt and coroutine.status(pl.emergt) == "suspended" then
		return
	end

	pl.emergt = co(co_telev, pl, ...)
end
