include("cl_voxlist.lua")

local specials = {
	[" "] = true,
	[","] = "_comma",
	["."] = "_period"
}

function mgn.VOX(text)
	local parts = {}
	local chars = {}
	for i = 1, #text do
		local char = text:sub(i, i)
		local special = specials[char]
		if special then
			if #chars > 0 then
				local part = table.concat(chars)
				if mgn.VOXList[part] then
					table.insert(parts, mgn.VOXList[part])
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
				if mgn.VOXList[part] then
					table.insert(parts, mgn.VOXList[part])
				end
			end
		end
	end

	co(function(sounds)
		for i = 1, #sounds do
			local part = sounds[i]
			co.PlayFile(part.Path)
			co.sleep(part.Duration)
		end
	end, parts)
end
