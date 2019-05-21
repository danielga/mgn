local mgn = mgn

file.CreateDir("mgn/sound")

surface.CreateFont("MGN_Alert", {
	font = "Arial Black",
	size = ScreenScale(12),
	outline = false,
	weight = 0,
	antialias = true
})

surface.CreateFont("MGN_Countdown", {
	font = "Roboto Bk",
	size = ScreenScale(42),
	outline = false,
	antialias = true
})

mgn.CountdownMusicDownload = "https://metastruct.github.io/mgn/sound/countdown_music.mp3"
mgn.CountdownMusicPath = "mgn/sound/countdown_music.dat"
mgn.CountdownETagPath = "mgn/sound/countdown_music.txt"

do
	local countdown_etag = file.Read(mgn.CountdownETagPath, "DATA")
	if countdown_etag == "" or not file.Exists(mgn.CountdownMusicPath, "DATA") then
		countdown_etag = nil
	end

	HTTP({
		method = "get",
		url = mgn.CountdownMusicDownload,
		headers = {["If-None-Match"] = countdown_etag},
		success = function(code, body, headers)
			if code == 200 then
				file.Write(mgn.CountdownMusicPath, body)
				file.Write(mgn.CountdownETagPath, headers.ETag)
				print("[MGN] Finished downloading music!", #body)
			elseif code == 304 then
				print("[MGN] Countdown music ETag is good!")
			end
		end,
		failed = function(reason)
			print("[MGN] Failed downloading countdown music!", reason)
		end
	})
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
local hudendtime
local function OverloadingHUD()
	local time_left = mgn.Stage.Overloading.Length - (CurTime() - mgn.Stage.Overloading.StartedAt)
	if time_left <= 0 then
		time_left = 0
	end

	if hudendtime and RealTime() > hudendtime then
		hook.Remove("HUDPaint", "mgn.OverloadingHUD")
		return
	end

	if RealTime() - (mgn.last_draw_disasterscreen or 0) < 1 then
		return
	end

	draw.SimpleTextOutlined(
		time_left == -0.5 and "ALERT! ALERT! ALERT! ALERT! ALERT!" or "MAJOR DISASTER IMMINENT! EVACUATE TO THE NEAREST EXIT!",
		"MGN_Alert",
		ScrW() * 0.5,
		ScrH() * 0.009,
		red,
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_TOP,
		3,
		Color(0, 0, 0, 127)
	)

	local color = white
	if time_left <= 30 then
		color = red
	end

	draw.SimpleTextOutlined(FormatTime(time_left), "MGN_Countdown", ScrW() * 0.5, ScrH() * 0.028, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 4, Color(0, 0, 0, 127))
end

local snd_mute_losefocus = GetConVar("snd_mute_losefocus")

mgn.Stage.Overloading = {
	Started = false,
	StartedAt = 0,
	StartTime = 60,
	Length = 206,
	EndTime = 266,
	Next = mgn.Stage.Exploding,
	Start = function(self, time)
		mgn.VOX("emergency announcement, please evacuate through the nearest exit")

		sound.PlayFile("data/" .. mgn.CountdownMusicPath, "", function(channel, errID, errStr)
			if channel then
				mgn.CountdownMusic = channel
				mgn.CountdownMusic:SetTime(CurTime() - time)
			end
		end)

		hudendtime = nil
		hook.Add("HUDPaint", "mgn.OverloadingHUD", OverloadingHUD)
	end,
	-- Countdown music resyncing
	Think = function(self, chrono)
		if IsValid(mgn.CountdownMusic) then
			if mgn.CountdownMusic:GetState() ~= GMOD_CHANNEL_PLAYING then
				mgn.CountdownMusic:Play()
			end

			if math.abs(chrono - mgn.CountdownMusic:GetTime()) >= 1 then
				mgn.CountdownMusic:SetTime(chrono)
			end

			if system.IsWindows() then
				if snd_mute_losefocus:GetBool() then
					mgn.CountdownMusic:SetVolume( system.HasFocus() and 1 or 0 )
				else
					mgn.CountdownMusic:SetVolume( 1 )
				end
			end
		end

		return chrono < self.Length
	end,
	End = function(self, time)
		if IsValid(mgn.CountdownMusic) then
			mgn.CountdownMusic:Stop()
		end

		mgn.CountdownMusic = nil
		hudendtime = RealTime() + 2.1
	end
}
