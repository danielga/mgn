include("cl_vox.lua")

file.CreateDir("mgn/sound")

surface.CreateFont("MGN_Alert", {
	font = "Roboto",
	size = 32,
	outline = true,
	antialias = false
})

surface.CreateFont("MGN_Countdown", {
	font = "Roboto",
	size = 128,
	outline = true,
	antialias = false
})

mgn.MusicDownload = "https://files.metaman.xyz/mgn/sound/countdown_music.mp3"
mgn.MusicPath = "mgn/sound/countdown_music.dat"

local function InitializeMusic()
	sound.PlayFile("data/" .. mgn.MusicPath, "noplay", function(channel, errID, errStr)
		if channel then
			mgn.Music = channel
		end
	end)
end

if not file.Exists(mgn.MusicPath, "DATA") then
	http.Fetch(mgn.MusicDownload, function(body, size, headers, errCode)
		if errCode == 200 then
			file.Write(mgn.MusicPath, body)
			InitializeMusic()
			print("[MGN] Finished downloading music!", size)
		end
	end, function(errCode)
		print("[MGN] Failed downloading music!", errCode)
	end)
else
	InitializeMusic()
end

local function FormatTime(time)
	local seconds = time
	local minutes = math.floor((seconds / 60) % 60)
	local millisecs = math.floor((seconds - math.floor(seconds)) * 100)
	millisecs = millisecs > 99 and 99 or millisecs
	seconds = math.floor(seconds % 60)
	return string.format("%02d:%02d:%02d", minutes, seconds, millisecs)
end

local white = Color(255, 255, 255, 255)
local red = Color(255, 0, 0, 255)
hook.Add("HUDPaint", "mgn.HUDPaint", function()
	if not mgn.IsAlertActive() then
		return
	end

	draw.SimpleText("████ ████████ IMMINENT! PLEASE EVACUATE THROUGH THE NEAREST EXIT!", "MGN_Alert", ScrW() / 2, 10, red, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

	local time_left = mgn.AlertLength - (CurTime() - mgn.GetAlertStart())
	if time_left <= 0 then
		return
	end

	local color = white
	if time_left <= 30 then
		color = red
	end

	draw.DrawText(FormatTime(time_left), "MGN_Countdown", ScrW() / 2, 30, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)

function mgn.SetAlertActive(b, t)
	assert(type(b) == "boolean", "Attempting to set activation status with a non-boolean.")

	if (b and mgn.IsAlertActive()) or (not b and not mgn.IsAlertActive()) then
		return
	end

	local alert_start = t or CurTime()
	if b and not mgn.IsAlertActive() then
		sound.PlayFile("data/" .. mgn.MusicPath, "", function(channel, errID, errStr)
			if channel then
				mgn.Music = channel
				mgn.Music:SetTime(CurTime() - alert_start)
			end
		end)
	elseif not b and mgn.IsAlertActive() then
		if mgn.Music then
			mgn.Music:Stop()
			mgn.Music = nil
		end
	end

	mgn.AlertActive = b
	mgn.AlertStart = b and alert_start or 0
end
