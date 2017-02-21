file.CreateDir("mgn/sound")

mgn.IntroMusicDownload = "https://files.metaman.xyz/mgn/sound/intro_music.mp3"
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
	StartTime = 0,
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
		if mgn.IntroMusic then
			if localplayer:IsInZone("reactor") and not overloading then
				overloading = true
				intro_volume = math.min(intro_volume + FrameTime() * 0.5, 0.7)
				mgn.IntroMusic:SetVolume(intro_volume)
			elseif not localplayer:IsInZone("reactor") and overloading then
				overloading = false
				intro_volume = math.max(intro_volume - FrameTime() * 0.5, 0)
				mgn.IntroMusic:SetVolume(intro_volume)
			end
		end

		return chrono < 60
	end,
	End = function(self, time)
		if mgn.IntroMusic then
			mgn.IntroMusic:Stop()
			mgn.IntroMusic = nil
		end

		overloading = false
		intro_volume = 0
	end
}
