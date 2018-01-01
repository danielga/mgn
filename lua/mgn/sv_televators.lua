local mgn = mgn

local doorloc = LMVector ~= nil and LMVector(-2091, 4912, -70, "land_caves", true) or nil
local doorradius = 100
local roomcenter = LMVector ~= nil and LMVector(-2083, 5142, -21, "land_caves", true) or nil

-- land position for emergency teleport target
local telearea1 = LMVector ~= nil and LMVector(-1886, 4962, -174, "land_caves", true) or nil
local telearea2 = LMVector ~= nil and LMVector(-2289, 5281, -174, "land_caves", true) or nil

local PLAYER = FindMetaTable("Player")

if doorloc == nil or roomcenter == nil or telearea1 == nil or telearea2 == nil or not roomcenter:inworld() then
	function mgn.SetEmergencyTelevationMode()
	end

	function PLAYER:EmergencyTelevate()
	end

	print("[MGN] Unable to find emergency televation destination!")
	return
else
	doorloc, telearea1, telearea2 = doorloc:pos(), telearea1:pos(), telearea2:pos()
end

local function GetDoor()
	local door = ents.FindByName("cbd1")[1]
	if IsValid(door) then
		return door
	end

	local doors = ents.FindInSphere(doorloc, doorradius)
	for i = 1, #doors do
		local door = doors[i]
		if door:GetClass() == "func_door" then
			return door -- there should be only one door with this setup
		end
	end
end

local function SetSafetyLockDoor(door, state)
	local ent, dist = ents.closest(ents.FindByClass("lua_screen"), door:GetPos())
	if dist < 200 and string.find(ent:GetPlace(), "door") and ent.SetSafetyLock then
		ent:SetSafetyLock(state)
	end
end

function mgn.SetEmergencyTelevationMode(state)
	local screens = ents.FindByClass("lua_screen")
	for i = 1, #screens do
		local screen = screens[i]
		if screen:GetPlace() == "elev" and screen.SetEmergency then
			screen:SetEmergency(state)
		end
	end

	local door = GetDoor()
	if door then
		local tid = "unlock_door_" .. door:EntIndex()
		if state then
			if timer.Exists(tid) then
				timer.Destroy(tid)
			end

			door:Fire("close")
			door:Fire("lock")
			SetSafetyLockDoor(door, true)
		else
			timer.Create(tid, 5, 1,function()
				if IsValid(door) then
					door:Fire("unlock")
				end

				SetSafetyLockDoor(door, false)
			end)
		end
	end

end

local vec = Vector(0, 0, telearea1.z)
local function FindEscapePos(ply,inplayers)
	vec.z = telearea1.z

	for i = 1, 100 do
		vec.x = math.Rand(telearea1.x, telearea2.x)
		vec.y = math.Rand(telearea1.y, telearea2.y)
		local stuck,inwhat = ply:IsStuck(false, vec)
		if not stuck then
			return vec
		elseif inplayers and IsValid(inwhat) and inwhat:IsPlayer() then
			print("GOTPLY",inwhat)
			return vec,inwhat
		end
	end

	vec.z = telearea1.z + 80
	for i = 1, 100 do
		vec.x = math.Rand(telearea1.x, telearea2.x)
		vec.y = math.Rand(telearea1.y, telearea2.y)
		local stuck,inwhat = ply:IsStuck(true, vec)
		if not stuck then
			return vec
		elseif inplayers and IsValid(inwhat) and inwhat:IsPlayer() then
			print("GOTPLY2",inwhat)
			return vec,inwhat
		end
	end

	return telearea1
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


local function DISS(pl,pl2)
	local dmgme
	hook.Add("PlayerShouldTakeDamage",'dmghackdissolve123',function(pl,a)
		if dmgme and dmgme == pl then dmgme = nil return true end
	end)
	
	
	local dmg = DamageInfo()
	dmg:SetDamage(pl:Health())
	dmg:SetDamageForce(VectorRand()*300)
	dmg:SetDamageType(bit.bor(DMG_DISSOLVE,DMG_ALWAYSGIB))
	dmg:SetInflictor(game.GetWorld())
	dmg:SetAttacker(pl2)
	dmgme=pl
	pl:EmitSound'ambient/energy/weld2.wav'
	pl:TakeDamageInfo(dmg)
	
	hook.Remove("PlayerShouldTakeDamage",'dmghackdissolve123')
end

--DISS(me,earu)
local function ensurevalid(ply)
	if not ply:IsValid() or not ply:Alive()or (ply:GetParent():IsValid() and not ply:InVehicle()) then coroutine.yield() end
	
end

local function TelevateCoroutine(ply, scr, edat)
	ply:EmitSound("buttons/button1.wav")

	co.sleep(0.1) ensurevalid(ply)

	ply:EmitSound("hl1/ambience/port_suckout1.wav")

	util.ScreenShake(ply:GetPos(), 0.6, 4, 4, 128)

	co.sleep(2.5) ensurevalid(ply)

	local white = Color(255, 255, 255, 255)
	ply:EmitSound("ambient/voices/citizen_beaten3.wav")
	ply:ScreenFade(SCREENFADE.IN, white, 1, 1)

	co.sleep(0.5) ensurevalid(ply)
	
	if ply:InVehicle() then ply:ExitVehicle() end
	
	local center = ply:OBBCenter()
	Tesla(ply:GetPos() + center)
	local escpos,ply2 = FindEscapePos(ply,true)
	ply:SetPos(escpos)
	Tesla(escpos + center)
	ply:ScreenFade(SCREENFADE.IN, white, 1, 1)
	if ply2 then
		DISS(ply,ply2)
		DISS(ply2,ply)
	end
end

function PLAYER:EmergencyTelevate(screen, edat)
	if self.EmergencyTelevator and coroutine.status(self.EmergencyTelevator) == "suspended" then
		return
	end

	self.EmergencyTelevator = co(TelevateCoroutine, self, screen, edat)
end
