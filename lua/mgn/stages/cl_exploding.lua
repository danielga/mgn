local start_time = 0
local end_time = 0
local alpha = 0
local sounds = {
	explosion = {Path = "ambient/intro/explosion02.wav", Played = false},
	citadelpan = {Path = "ambient/intro/citadelpan.wav", Played = false},
	debris = {Path = "ambient/intro/debris02.wav", Played = false}
}

local function PlaySoundOnce(snd)
	if sounds[snd] and not sounds[snd].Played then
		surface.PlaySound(sounds[snd].Path)
		sounds[snd].Played = true
	end
end

local function ExplosionEffect()
	local realtime = RealTime()
	if start_time == 0 then
		start_time = realtime + 6
		end_time = realtime + 6 + 8
		PlaySoundOnce("explosion")
	end

	if realtime < start_time then -- don't do anything until the explosion starts
		return
	end

	if realtime < end_time then
		alpha = math.Clamp(alpha + FrameTime() * 3, 0, 1)
		util.ScreenShake(LocalPlayer():GetPos(), 5, 3, 0.25, 512)

		if alpha == 1 then
			PlaySoundOnce("citadelpan")
			timer.Simple(6, function() PlaySoundOnce("debris") end)
		end
	else -- end explosion
		alpha = math.Clamp(alpha - FrameTime() * 0.175, 0, 1)
	end

	DrawColorModify({
		["$pp_colour_brightness"] = 0.5 * alpha,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1 - (0.66 * alpha),
		["$pp_colour_mulr"] = 80 * alpha,
		["$pp_colour_mulg"] = 112 * alpha,
		["$pp_colour_mulb"] = 0,
	})

	DrawBloom(0.65, 4 * alpha, 4, 4, 1, 1, 1, 1, 1)
	DrawMotionBlur(0.1, 0.79 * alpha, 0.033)

	surface.SetDrawColor(Color(255, 192, 0, 164 * alpha))
	surface.DrawRect(0, 0, ScrW(), ScrH())

	for i = 1, ScrW() * 1.5 do -- some kind of noise, wish I could do this better
		local randX = math.random(0, ScrW())
		local randY = math.random(0, ScrH())
		surface.SetDrawColor(Color(0, 0, 0, alpha * math.random(192, 255)))
		surface.DrawRect(randX, randY, math.random(1, 2), math.random(1, 2))
	end

	surface.SetDrawColor(Color(0, 0, 0, 48 * alpha))
	surface.DrawRect(0, 0, ScrW(), ScrH())
end

mgn.Stage.Exploding = {
	Started = false,
	StartedAt = 0,
	StartTime = 266,
	Length = 22,
	EndTime = 288,
	Next = mgn.Stage.Idle,
	Start = function(self, time)
		start_time = 0
		end_time = 0
		alpha = 0

		for _, data in pairs(sounds) do
			data.Played = false
		end
		
		mgn.VOX("alert. containment breached")
		
		hook.Add("RenderScreenspaceEffects", "mgn.ExplosionEffect", ExplosionEffect)
	end,
	Think = function(self, chrono)
		return chrono < self.Length
	end,
	End = function(self, time)
		start_time = 0
		end_time = 0
		alpha = 0

		for _, data in pairs(sounds) do
			data.Played = false
		end

		hook.Remove("RenderScreenspaceEffects", "mgn.ExplosionEffect")

		mgn.OverloadStart = 0
	end
}
