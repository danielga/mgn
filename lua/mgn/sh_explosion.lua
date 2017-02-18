
local VectorWithinBox = function(self, mins, maxs) -- WithinAABox didn't work for me.
	if self.x < math.max(mins.x, maxs.x) and self.x > math.min(mins.x, maxs.x) and
		self.y < math.max(mins.y, maxs.y) and self.y > math.min(mins.y, maxs.y) and
		self.z < math.max(mins.z, maxs.z) and self.z > math.min(mins.z, maxs.z) then

		return true
	end
	return false
end

if SERVER then

mgn.Exploded = false
mgn.ExplosionActive = false
mgn.ExplosionLastTick = 0
mgn.ExplosionStart = 0

hook.Add("Think", "mgn.Explosion", function()
	if not mgn.IsAlertActive() then return end
	if CurTime() < mgn.AlertStart + mgn.AlertLength then return end
	if not mgn.Exploded then
		mgn.ExplosionStart = CurTime() + 6
		mgn.ExplosionActive = true
		timer.Simple(18, function()
			mgn.ExplosionActive = false
			timer.Simple(4, function()
				mgn.SetAlertActive(false)
			end)
		end)
		mgn.Exploded = true
	end
	if mgn.ExplosionActive and mgn.ExplosionStart < CurTime() then
		if mgn.ExplosionLastTick < CurTime() then
			for _, ply in next, player.GetAll() do
				-- are we in the emergency room?
				if VectorWithinBox(ply:GetPos(), Vector(8630, 4314, -15084), Vector(9087, 4767, -15506)) then continue end

				-- if not, blow shit up!
				ply.__mgnIgnoreGod = true
				local dmg = DamageInfo()
				dmg:SetDamage(ply:Health())
				dmg:SetDamageForce(ply:GetAngles():Up() * -2048)
				dmg:SetDamageType(DMG_DISSOLVE)
				dmg:SetInflictor(game.GetWorld())
				dmg:SetAttacker(game.GetWorld())
				ply:TakeDamageInfo(dmg)
			end
			mgn.ExplosionLastTick = CurTime() + 0.5
		end
	end
end)

hook.Add("PlayerShouldTakeDamage", "mgn.ExplosionIgnoreGod", function(ply)
	if ply.__mgnIgnoreGod then
		ply:EmitSound("physics/flesh/flesh_bloody_break.wav")
		ply.__mgnIgnoreGod = false
		return true
	end
end)

elseif CLIENT then

mgn.ExplosionReset = true
local startTime = 0
local endTime = 0
local alpha = 0

local sounds = {
	explosion = { path = "ambient/intro/explosion02.wav", played = false },
	citadelpan = { path = "ambient/intro/citadelpan.wav", played = false },
	debris = { path = "ambient/intro/debris02.wav", played = false },
}
local function playSoundOnce(snd)
	if not sounds[snd].played then
		surface.PlaySound(sounds[snd].path)
		sounds[snd].played = true
	end
end

hook.Add("RenderScreenspaceEffects", "mgn.ExplosionEffect", function()
	if mgn.ExplosionReset then
		startTime = 0
		endTime = 0
		alpha = 0
		for sndName, data in next, sounds do
			data.played = false
		end
		mgn.ExplosionReset = false
	end
	if not mgn.IsAlertActive() then return end
	if CurTime() < mgn.AlertStart + mgn.AlertLength then return end

	if startTime == 0 then
		startTime = RealTime() + 6
		endTime = RealTime() + 6 + 8
		playSoundOnce("explosion")
	end
	if RealTime() < startTime then return end
	if RealTime() < endTime then
		alpha = math.Clamp(alpha + FrameTime() * 3, 0, 1)
		if alpha == 1 then
			util.ScreenShake(LocalPlayer():GetPos(), 5, 3, 0.25, 512)
			playSoundOnce("citadelpan")
			timer.Simple(4, function() playSoundOnce("debris") end)
		end
	else
		alpha = math.Clamp(alpha - FrameTime() * 0.175, 0, 1)
	end
	if alpha <= 0 then
		hook.Remove("RenderScreenspaceEffects", "mgn")
	end
	DrawColorModify({
		["$pp_colour_brightness"] = 0.566 * alpha,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1 - (0.66 * alpha),
		["$pp_colour_mulr"] = 80 * alpha,
		["$pp_colour_mulg"] = 112 * alpha,
		["$pp_colour_mulb"] = 0,
	})
	DrawBloom(0.65, 4 * alpha, 4, 4, 1, 1, 1, 1, 1)

	surface.SetDrawColor(Color(255, 192, 0, 164 * alpha))
	surface.DrawRect(0, 0, ScrW(), ScrH())

	for i = 1, 512 do
		local randX = math.random(0, ScrW())
		local randY = math.random(0, ScrH())
		surface.SetDrawColor(Color(127, math.random(0, 127), 0, alpha * 192))
		local size = math.random(1, 3)
		surface.DrawRect(randX - size / 2, randY - size / 2, size, size)
	end

	surface.SetDrawColor(Color(0, 0, 0, 48 * alpha))
	surface.DrawRect(0, 0, ScrW(), ScrH())
end)

end