local core_info_screen
local function GetCoreInfoScreen()
	if not IsValid(core_info_screen) then
		core_info_screen = nil

		local screens = ents.FindByClass("lua_screen")
		for i = 1, #screens do
			local screen = screens[i]
			if screen:GetPlace() == "corectrl" then
				core_info_screen = screen
				break
			end
		end
	end

	return core_info_screen
end

-- find out if WithinAABox works and substitute with it if possible - less homemade pasta
local function VectorWithinBox(self, mins, maxs) -- WithinAABox didn't work for me.
	if self.x < math.max(mins.x, maxs.x) and self.x > math.min(mins.x, maxs.x) and
		self.y < math.max(mins.y, maxs.y) and self.y > math.min(mins.y, maxs.y) and
		self.z < math.max(mins.z, maxs.z) and self.z > math.min(mins.z, maxs.z) then
		return true
	end

	return false
end

local function ExplosionIgnoreGod(ply)
	if ply.__mgn_ignore_god then
		ply:EmitSound("physics/flesh/flesh_bloody_break.wav")
		ply.__mgn_ignore_god = nil
		return true
	end
end

local last_tick = 0
mgn.Stage.Exploding = {
	Started = false,
	StartTime = 0,
	Next = mgn.Stage.Idle,
	Start = function(self, time)
		hook.Add("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod", ExplosionIgnoreGod)
	end,
	Think = function(self, chrono)
		local curtime = CurTime()
		-- rape the shit out of players every 0.5 secs
		if chrono >= 6 and chrono <= 18 then
			if ms and IsValid(ms.core_effect) and not ms.core_effect:GetDTBool(3) then
				mgn.ControlComputer:SetDTFloat(1, 0)
				ms.core_effect:SetDTBool(3, true)
			end

			if last_tick < curtime then
				local core = GetCoreEffect()
				local plys = player.GetAll()
				for i = 1, #plys do
					local ply = plys[i]
					-- are we in the emergency room?
					-- fix this with landmarks
					if VectorWithinBox(ply:GetPos(), Vector(6710, 6957, -15535), Vector(10961, 4307, -14529)) then
						continue
					end

					-- if not, blow shit up!
					ply.__mgn_ignore_god = true

					local dmg = DamageInfo()
					dmg:SetDamage(ply:Health())
					dmg:SetDamageForce(ply:GetAngles():Up() * -2048)
					dmg:SetDamageType(DMG_DISSOLVE)
					dmg:SetInflictor(core)
					dmg:SetAttacker(core)

					ply:TakeDamageInfo(dmg)
				end

				last_tick = curtime + 0.5
			end
		end

		return chrono < 22
	end,
	End = function(self, time)
		last_tick = 0

		for i = 1, #mgn.AlarmEntities do
			local pair = mgn.AlarmEntities[i]
			pair.Light:SetEnabled(false)
			pair.Siren:SetEnabled(false)
		end

		for i = 1, #mgn.LightEntities do
			mgn.LightEntities[i]:SetEnabled(false)
		end

		mgn.SetEmergencyTelevationMode(false)

		local screen = GetCoreInfoScreen()
		if IsValid(screen) then
			screen:SetDTInt(3, 0) -- damage status
			screen:SetDTInt(4, 0) -- radiation status
			SetGlobalBool("core_door", true) -- door status
		end

		hook.Remove("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod")
	end
}
