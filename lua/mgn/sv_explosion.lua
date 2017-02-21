-- find out if WithinAABox works and substitute with it if possible - less homemade pasta
local function VectorWithinBox(self, mins, maxs) -- WithinAABox didn't work for me.
	if self.x < math.max(mins.x, maxs.x) and self.x > math.min(mins.x, maxs.x) and
		self.y < math.max(mins.y, maxs.y) and self.y > math.min(mins.y, maxs.y) and
		self.z < math.max(mins.z, maxs.z) and self.z > math.min(mins.z, maxs.z) then
		return true
	end

	return false
end

mgn.Exploded = false
mgn.ExplosionActive = false
mgn.ExplosionLastTick = 0
mgn.ExplosionStart = 0

hook.Add("Think", "mgn.Explosion", function()
	if not mgn.IsAlertActive() then
		return
	end

	local curtime = CurTime()
	if curtime < mgn.AlertStart + mgn.AlertLength then
		return
	end

	if not mgn.Exploded then -- initialize the explosion
		mgn.ExplosionStart = curtime + 6
		mgn.ExplosionActive = true

		timer.Simple(18, function()
			mgn.ExplosionActive = false
			timer.Simple(4, function()
				mgn.SetAlertActive(false)
			end)
		end)

		mgn.Exploded = true
	end

	-- rape the shit out of players every 0.5 secs
	if mgn.ExplosionActive and mgn.ExplosionStart < curtime then
		if not mgn.core_effect:GetDTBool(3) then
			mgn.ControlComputer:SetDTFloat(1, 0)
			ms.core_effect:SetDTBool(3, true)
		end
		if mgn.ExplosionLastTick < curtime then
			local plys = player.GetAll()
			for i = 1, #plys do
				local ply = plys[i]
				-- are we in the emergency room?
				-- fix this with landmarks
				if VectorWithinBox(ply:GetPos(), Vector(6710, 6957, -15535), Vector(10961, 4307, -14529)) then
					continue
				end

				-- if not, blow shit up!
				ply.__mgnIgnoreGod = true

				local world = game.GetWorld()
				local dmg = DamageInfo()
				dmg:SetDamage(ply:Health())
				dmg:SetDamageForce(ply:GetAngles():Up() * -2048)
				dmg:SetDamageType(DMG_DISSOLVE)
				dmg:SetInflictor(world)
				dmg:SetAttacker(world)

				ply:TakeDamageInfo(dmg)
			end

			mgn.ExplosionLastTick = curtime + 0.5
		end
	end
end)

hook.Add("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod", function(ply)
	if ply.__mgnIgnoreGod then
		ply:EmitSound("physics/flesh/flesh_bloody_break.wav")
		ply.__mgnIgnoreGod = nil
		return true
	end
end)
