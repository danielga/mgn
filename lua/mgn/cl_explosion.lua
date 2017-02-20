mgn.ExplosionReset = true

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

hook.Add("RenderScreenspaceEffects", "mgn.ExplosionEffect", function()
	if mgn.ExplosionReset then -- reset vars if some sicko wants to nuke more people
		mgn.ExplosionReset = false

		start_time = 0
		end_time = 0
		alpha = 0

		for _, data in pairs(sounds) do
			data.Played = false
		end
	end

	if not mgn.IsAlertActive() then
		return
	end

	if CurTime() < mgn.AlertStart + mgn.AlertLength then
		return
	end

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
end)
