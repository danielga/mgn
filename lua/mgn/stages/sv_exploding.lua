local core_effect
local function GetCoreEffect()
	if not IsValid(core_effect) then
		core_effect = ents.FindByClass("lua_core_effect")[1]
	end

	return core_effect
end

-- find out if WithinAABox works and substitute with it if possible - less homemade pasta
local function VectorWithinBox(self, mins, maxs)
	if self.x < math.max(mins.x, maxs.x) and self.x > math.min(mins.x, maxs.x) and
		self.y < math.max(mins.y, maxs.y) and self.y > math.min(mins.y, maxs.y) and
		self.z < math.max(mins.z, maxs.z) and self.z > math.min(mins.z, maxs.z) then
		return true
	end

	return false
end -- WithinAABox didn't work for me.

local function ExplosionIgnoreGod(ply)
	if ply.__mgn_ignore_god then
		ply.__mgn_ignore_god = nil
		return true
	end
end

local function PlayerDeathSound(ply)
	if not ply.__mgn_deadsound then
		return
	end

	ply.__mgn_deadsound = nil
	ply:EmitSound("physics/flesh/flesh_bloody_break.wav")

	return true
end

mgn.Stage.Exploding = {
	Started = false,
	StartedAt = 0,
	StartTime = 266,
	Length = 22,
	EndTime = 288,
	Next = mgn.Stage.Idle,
	LastTick = 0,
	Start = function(self, time)
		hook.Add("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod", ExplosionIgnoreGod)
		hook.Add("PlayerDeathSound", "mgn", PlayerDeathSound)
	end,
	Think = function(self, chrono)
		local curtime = CurTime()

		-- rape the shit out of players every 0.5 secs
		if chrono >= 6 and chrono <= 18 then
			if ms and IsValid(ms.core_effect) and not ms.core_effect:GetDTBool(3) then
				mgn.ControlComputer:SetDTFloat(1, 0)
				ms.core_effect:SetDTBool(3, true)
			end

			if self.LastTick < curtime then
				self.LastTick = curtime + 0.2

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
					ply.__mgn_deadsound = true

					local dmg = DamageInfo()
					dmg:SetDamage(math.Clamp(math.ceil(ply:Health() * 0.3), 33, 9999))
					dmg:SetDamageForce(ply:GetAngles():Up() * -2048)
					dmg:SetDamageType(DMG_DISSOLVE)
					dmg:SetInflictor(core)
					dmg:SetAttacker(core)
					ply:TakeDamageInfo(dmg)
				end

				local di = DamageInfo()
				di:SetAttacker(core)
				di:SetInflictor(core)
				di:SetDamage(math.random() > 0.5 and 14 or 7)
				di:SetDamagePosition(core:GetPos())
				di:SetDamageForce(Vector(0, 0, -1))
				di:SetDamageType(DMG_DISSOLVE)

				local npcs = ents.FindByClass("lua_npc_wander")
				for i = 1, #npcs do
					v:TakeDamageInfo(npcs[i])
				end
			end
		end

		return chrono < self.Length
	end,
	End = function(self, time)
		self.LastTick = 0
		hook.Remove("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod")
		hook.Remove("PlayerDeathSound", "mgn")
		mgn.OverloadStart = 0

		if IsValid(mgn.ControlComputer) then
			mgn.ControlComputer:SetOverloadStart(0)
		end
	end
}
