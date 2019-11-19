local mgn = mgn

include("cl_voxlist.lua")

local specials = {
	[" "] = true,
	[","] = "_comma",
	["."] = "_period"
}

local function ExtractPitch(part)
	local pitch = nil
	part = part:gsub(":pitch%((%-?%d+)%)", function(p)
		p = tonumber(p)
		if p == nil then
			return ""
		end

		pitch = math.Clamp(p, 50, 255)
		return ""
	end)

	return part, pitch
end

local function PlayPart(part)
	if part.Pitch ~= nil then
		local s = CreateSound(LocalPlayer(), part.Path:sub(6))
		s:Play()
		s:ChangePitch(part.Pitch)
		co.sleep(part.Duration * (100 / part.Pitch))
	else
		local cb = co.newcb()
		sound.PlayFile(part.Path, "", cb)
		co.waitcb(cb)
		co.sleep(part.Duration)
	end
end

function mgn.VOX(text)
	local parts = {}
	local chars = {}
	for i = 1, #text do
		local char = text:sub(i, i)
		local special = specials[char]
		if special ~= nil then
			if #chars > 0 then
				local part = table.concat(chars)
				local stripped_part, pitch = ExtractPitch(part)
				local data = mgn.VOXList[stripped_part]
				if data ~= nil then
					part = {Path = data.Path, Duration = data.Duration}

					if pitch ~= nil then
						part.Pitch = pitch
					end

					table.insert(parts, part)
				end

				chars = {}
			end

			if special ~= true and i ~= #text and #parts > 0 then
				table.insert(parts, mgn.VOXList[special])
			end
		else
			table.insert(chars, char)

			if i == #text then
				local part = table.concat(chars)
				local stripped_part, pitch = ExtractPitch(part)
				local data = mgn.VOXList[stripped_part]
				if data ~= nil then
					part = {Path = data.Path, Duration = data.Duration}

					if pitch ~= nil then
						part.Pitch = pitch
					end

					table.insert(parts, part)
				end
			end
		end
	end

	co(function(sounds)
		for i = 1, #sounds do
			PlayPart(sounds[i])
		end
	end, parts)
end
