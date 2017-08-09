local mgn = mgn

file.CreateDir("mgn/sound")

mgn.IntroMusicDownload = "https://metastruct.github.io/mgn/sound/intro_music.mp3"
mgn.IntroMusicPath = "mgn/sound/intro_music.dat"
mgn.IntroETagPath = "mgn/sound/intro_music.txt"

do
	local intro_etag = file.Read(mgn.IntroETagPath, "DATA")
	if intro_etag == "" or not file.Exists(mgn.IntroMusicPath, "DATA") then
		intro_etag = nil
	end

	HTTP({
		method = "get",
		url = mgn.IntroMusicDownload,
		headers = {["If-None-Match"] = intro_etag},
		success = function(code, body, headers)
			if code == 200 then
				file.Write(mgn.IntroMusicPath, body)
				file.Write(mgn.IntroETagPath, headers.ETag)
				print("[MGN] Finished downloading intro music!", #body)
			elseif code == 304 then
				print("[MGN] Intro music ETag is good!")
			end
		end,
		failed = function(reason)
			print("[MGN] Failed downloading intro music!", reason)
		end
	})
end

local localplayer
local overloading = false
local intro_volume = 0
mgn.Stage.Intro = {
	Started = false,
	StartedAt = 0,
	StartTime = 0,
	Length = 60,
	EndTime = 60,
	Next = mgn.Stage.Overloading,
	Start = function(self, time)
		localplayer = LocalPlayer()

		sound.PlayFile("data/" .. mgn.IntroMusicPath, "", function(channel, errID, errStr)
			if channel then
				mgn.IntroMusic = channel
				mgn.IntroMusic:SetTime(CurTime() - time)
			end
		end)
	end,
	Think = function(self, chrono)
		if IsValid(mgn.IntroMusic) then
			if localplayer:IsInZone("reactor") and not overloading then
				overloading = true
			elseif not localplayer:IsInZone("reactor") and overloading then
				overloading = false
			end

			if mgn.IntroMusic:GetState() ~= GMOD_CHANNEL_PLAYING then
				mgn.IntroMusic:Play()
			end

			intro_volume = math.Clamp(intro_volume + FrameTime() * (overloading and 0.5 or -0.5), 0, 0.7)
			mgn.IntroMusic:SetVolume(intro_volume)

			if math.abs(chrono - mgn.IntroMusic:GetTime()) >= 1 then
				mgn.IntroMusic:SetTime(chrono)
			end
		end

		return chrono < self.Length
	end,
	End = function(self, time)
		if IsValid(mgn.IntroMusic) then
			mgn.IntroMusic:Stop()
		end

		mgn.IntroMusic = nil

		overloading = false
		intro_volume = 0
	end
}
