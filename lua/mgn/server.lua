mgn.AlarmLocations = {
	-- Lobby
	{Position = Vector(-14461, -2010, 14426), Normal = Vector(0, 1, 0)},
	{Position = Vector(-11994, -2096, 14454), Normal = Vector (0, -1, 0)},
	{Position = Vector(-13541, 33, 14441), Normal = Vector(-1, 0, 0)},
	{Position = Vector(-14644, 703, 14422), Normal = Vector(0, -1, 0)},
	{Position = Vector(-14639, 2000, 14475), Normal = Vector(0, 1, 0)},

	-- RP
	{Position = Vector(-8088, 12800, -13153), Normal = Vector(0, -1, 0)},

	-- Fishing
	{Position = Vector(4097, 8640, 12343), Normal = Vector(0, -1, 0)},
	{Position = Vector(11954, -312, 12478), Normal = Vector(0, 1, 0)},

	-- Soccer
	{Position = Vector(1880, -7696, 4216), Normal = Vector(0, -1, 0)},

	-- Build
	{Position = Vector(-4464, 2131, -13084), Normal = Vector(1, 0, 0)},
	{Position = Vector(6669, 6208, -12948), Normal = Vector(0, 1, 0)},
	{Position = Vector(11254, -5232, -13431), Normal = Vector(0, 1, 0)},
	{Position = Vector(10048, -489, -13085), Normal = Vector(-1, 0, 0)},
	{Position = Vector(-2076, 640, -13228), Normal = Vector(0, 1, 0)},
	{Position = Vector(-15000, 7842, -13051), Normal = Vector(0.7, -0.7, 0)},
	{Position = Vector(-9247, -10621, -8351), Normal = Vector(0, 1, 0)},

	-- Build basement
	{Position = Vector(-6562, 2864, -15783), Normal = Vector(0, 1, 0)},

	-- Build caves
	{Position = Vector(8861, 4016, -15178), Normal = Vector (0, -1, 0)}
}

mgn.AlarmEntities = mgn.AlarmEntities or {}

mgn.LightLocations = {
	-- Lobby
	{Position = Vector(-13244, -811, 14313), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = Vector(-13019, 96, 14308), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 300, SpriteSize = 32, LightCount = 6},
	{Position = Vector(-15437, -1314, 14308), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 800, SpriteSize = 32, LightCount = 10},
	{Position = Vector(-14160, 567, 14308), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = Vector(-15999, -118, 14308), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = Vector(-14417, -1445, 14308), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = Vector(-14527, -3374, 13956), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 2200, SpriteSize = 32, LightCount = 30},
	{Position = Vector(-13579, -2745, 14160), Angles = Angle(25, -180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10},
	{Position = Vector(-13946, -2747, 14041), Angles = Angle(25, 180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10},
	{Position = Vector(-11995, -2232, 14308), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-12859, -1535, 14308), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 50, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-14402, -2628, 14213), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-15921, -1800, 14308), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-14642, 2143, 14308), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 250, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = Vector(-14644, 1172, 14308), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 70, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = Vector(-12666, 576, 14308), Angles = Angle(0, -180, 0), DoubleStriped = true, Width = 200, Depth = 1900, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-13275, 32, 14308), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = Vector(-15668, 138, 14316), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = Vector(-14870, -348, 14316), Angles = Angle(0, 180, 0), DoubleStriped = false, Width = 0, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = Vector(-15236, -801, 14316), Angles = Angle(0, -90, 0), DoubleStriped = false, Width = 0, Depth = 2000, SpriteSize = 32, LightCount = 15},

	-- Build
	{Position = Vector(-3943, 2133, -13294), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 128, LightCount = 15},
	{Position = Vector(-5213, 2938, -13692), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-6102, 2012, -13812), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},

	-- RP
	{Position = Vector(-8078, 12402, -13302), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 64, LightCount = 10},
	{Position = Vector(-11158, 12292, -13304), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = Vector(-5401, 12289, -13304), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},

	-- Build basement
	{Position = Vector(-6020, 3911, -15852), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = Vector(-6476, 3584, -15852), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-5800, 3019, -15852), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(-5005, 3001, -15851), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = Vector(-3971, 3040, -15852), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10},

	-- Build
	{Position = Vector(1316, 7639, -13304), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = Vector(6563, 6630, -13303), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 1000, SpriteSize = 64, LightCount = 10},
	{Position = Vector(-7926, 7635, -13304), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = Vector(-14749, 4481, -13298), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = Vector(-11409, 1502, -13304), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = Vector(1263, 1508, -13304), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},

	-- Fishing
	{Position = Vector(4507, 8900, 12268), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = Vector(11939, -3, 12212), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = Vector(12648, -863, 12276), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = Vector(11954, -695, 12212), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = Vector(9602, -816, 12212), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = Vector(9593, 534, 12212), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 800, SpriteSize = 32, LightCount = 10},
	{Position = Vector(4350, 8571, 12267), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 200, SpriteSize = 64, LightCount = 4},
	{Position = Vector(4194, 9520, 12272), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 400, SpriteSize = 64, LightCount = 5}
}

mgn.LightEntities = mgn.LightEntities or {}

function mgn.PopulateLuaScreens()
	if game.GetMap() == "gm_construct_m_222" and LuaScreen then
		LuaScreen.AddConfig({
			place = "mgn_control_computer",
			pos = Vector(-13692, 2998, 14346),
			ang = Angle(-45, 0, 0)
		})
	end
end
hook.Add("PopulateLuaScreens", "MGN", mgn.PopulateLuaScreens)

function mgn.Initialize()
	for i = 1, math.max(#mgn.AlarmLocations, #mgn.AlarmEntities) do
		if not mgn.AlarmLocations[i] then
			local pair = mgn.AlarmEntities[i]
			if IsValid(pair.Light) then
				pair.Light:Remove()
			end

			if IsValid(pair.Siren) then
				pair.Siren:Remove()
			end

			mgn.AlarmEntities[i] = nil
		else
			local position = mgn.AlarmLocations[i].Position
			local normal = mgn.AlarmLocations[i].Normal

			local pair = mgn.AlarmEntities[i]
			if not pair then
				pair = {}
				mgn.AlarmEntities[i] = pair
			end

			if IsValid(pair.Light) then
				pair.Light:SetPos(position + normal)
				pair.Light:SetAngles(normal:Angle())
			else
				local light = ents.Create("mgn_rotating_light")
				light:SetPos(position + normal)
				light:SetAngles(normal:Angle())
				light:Spawn()

				pair.Light = light
			end

			if IsValid(pair.Siren) then
				pair.Siren:SetPos(position + Vector(0, 0, 30) + normal * 10)
				pair.Siren:SetAngles(normal:Angle())
			else
				local siren = ents.Create("mgn_siren")
				siren:SetPos(position + Vector(0, 0, 30) + normal * 10)
				siren:SetAngles(normal:Angle())
				siren:Spawn()

				pair.Siren = siren
			end
		end
	end

	for i = 1, math.max(#mgn.LightLocations, #mgn.LightEntities) do
		if not mgn.LightLocations[i] then
			local light = mgn.LightEntities[i]
			if IsValid(light) then
				light:Remove()
			end

			mgn.LightEntities[i] = nil
		else
			local position, angles, dstriped, width, depth, ssize, lcount, light =
				mgn.LightLocations[i].Position,
				mgn.LightLocations[i].Angles,
				mgn.LightLocations[i].DoubleStriped,
				mgn.LightLocations[i].Width,
				mgn.LightLocations[i].Depth,
				mgn.LightLocations[i].SpriteSize,
				mgn.LightLocations[i].LightCount,
				mgn.LightEntities[i]

			if IsValid(light) then
				light:SetPos(position)
				light:SetAngles(angles)
				light:SetDoubleStriped(dstriped)
				light:SetWidth(width)
				light:SetDepth(depth)
				light:SetSpriteSize(ssize)
				light:SetLightCount(lcount)
			else
				light = ents.Create("mgn_floor_lights")
				light:SetPos(position)
				light:SetAngles(angles)
				light:SetDoubleStriped(dstriped)
				light:SetWidth(width)
				light:SetDepth(depth)
				light:SetSpriteSize(ssize)
				light:SetLightCount(lcount)
				light:Spawn()

				mgn.LightEntities[i] = light
			end
		end
	end

	SetGlobalBool("MGN_AlertActive", false)
end
hook.Add("Initialize", "MGN", mgn.Initialize)

function mgn.ActivateAlert()
	for i = 1, #mgn.AlarmEntities do
		local pair = mgn.AlarmEntities[i]
		pair.Light:SetEnabled(true)
		pair.Siren:SetEnabled(true)
	end

	for i = 1, #mgn.LightEntities do
		mgn.LightEntities[i]:SetEnabled(true)
	end

	local lua_screens = ents.FindByClass("lua_screen")
	for i = 1, #lua_screens do
		local lua_screen = lua_screens[i]
		if lua_screen:GetPlace() == "elev" then
			lua_screen:SetEmergency(false)
		end
	end

	SetGlobalBool("MGN_AlertActive", true)
end

function mgn.DisableAlert()
	for i = 1, #mgn.AlarmEntities do
		local pair = mgn.AlarmEntities[i]
		pair.Light:SetEnabled(false)
		pair.Siren:SetEnabled(false)
	end

	for i = 1, #mgn.LightEntities do
		mgn.LightEntities[i]:SetEnabled(false)
	end

	local lua_screens = ents.FindByClass("lua_screen")
	for i = 1, #lua_screens do
		local lua_screen = lua_screens[i]
		if lua_screen:GetPlace() == "elev" then
			lua_screen:SetEmergency(false)
		end
	end

	SetGlobalBool("MGN_AlertActive", false)
end
