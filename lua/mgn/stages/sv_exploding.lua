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

local core_effect
local function GetCoreEffect()
	if not IsValid(core_effect) then
		core_effect = ents.FindByClass("lua_core_effect")[1]
	end

	return core_effect
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
	StartedAt = 0,
	StartTime = 266,
	Length = 22,
	EndTime = 288,
	Next = mgn.Stage.Idle,
	Start = function(self, time)
		hook.Add("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod", ExplosionIgnoreGod)
	end,
	Think = function(self, chrono)
		local curtime = CurTime()
		-- rape the shit out of players every 0.5 secs
		if chrono >= 6 and chrono <= 18 then
			mgn.ControlComputer:SetDTFloat(1, 0)
			mgn.ControlComputer:SetDTFloat(4, 0)
			if ms and IsValid(ms.core_effect) and not ms.core_effect:GetDTBool(3) then
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

		return chrono < self.Length
	end,
	End = function(self, time)
		last_tick = 0

		hook.Remove("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod")

		mgn.OverloadStart = 0

		if IsValid(mgn.ControlComputer) then
			mgn.ControlComputer:SetOverloadStart(0)
		end
	end
}
