mgn.AlarmLocations = {}
mgn.LightLocations = {}

if LMVector == nil then
	return
end

local alarms = 0
local function AddAlarmLocation(data)
	alarms = alarms + 1

	if not data.Position then
		print("[MGN] Failed to add an entry to the list of alarm locations (#" .. alarms .. ").")
		return
	end

	data.Position = data.Position:pos()

	table.insert(mgn.AlarmLocations, data)
end

-- Lobby
AddAlarmLocation({Position = LMVector(-373, -623, 274, "lobby", true), Normal = Vector(0, 1, 0)})
AddAlarmLocation({Position = LMVector(0, 64, 118, "club", true), Normal = Vector (0, -1, 0)})
AddAlarmLocation({Position = LMVector(-960, 720, 450, "armory", true), Normal = Vector(-1, 0, 0)})
AddAlarmLocation({Position = LMVector(-556, 2089, 110, "lobby", true), Normal = Vector(0, -1, 0)})
AddAlarmLocation({Position = LMVector(1, -992, -409, "reactor", true), Normal = Vector(0, 1, 0)})

-- RP
AddAlarmLocation({Position = LMVector(1139, 845, -41, "land_rp", true), Normal = Vector(0, -1, 0)})

-- Fishing
AddAlarmLocation({Position = LMVector(-228, -1566, 75, "land_fish1", true), Normal = Vector(0, -1, 0)})
AddAlarmLocation({Position = LMVector(-77, -296, 205, "land_fish2", true), Normal = Vector(0, 1, 0)})

-- Soccer
AddAlarmLocation({Position = LMVector(-33, 174, 120, "soccer", true), Normal = Vector(0, -1, 0)})

-- Build
AddAlarmLocation({Position = LMVector(-74, -916, 2764, "land_vphys", true), Normal = Vector(1, 0, 0)})
AddAlarmLocation({Position = LMVector(-2195, 352, 2205, "Smooth", true), Normal = Vector(0, 1, 0)})
AddAlarmLocation({Position = LMVector(-10, 2704, 736, "Silo", true), Normal = Vector(0, 1, 0)})
AddAlarmLocation({Position = LMVector(-908, 105, 2166, "land_caves", true), Normal = Vector(-1, 0, 0)})
AddAlarmLocation({Position = LMVector(101, 482, 68, "bunker", true), Normal = Vector(0, 1, 0)})
AddAlarmLocation({Position = LMVector(-4498, -5020, 75, "land_rp", true), Normal = Vector(1, 0, 0)})
AddAlarmLocation({Position = LMVector(213, -3226, -11171, "AutoInstance0flood", true), Normal = Vector(0, 1, 0)})

-- Build basement
AddAlarmLocation({Position = LMVector(-964, -1068, 13, "classroom", true), Normal = Vector(0, 1, 0)})

-- Build caves
AddAlarmLocation({Position = LMVector(-3, -1840, -25, "Smooth", true), Normal = Vector (0, -1, 0)})

local lights = 0
local function AddLightLocation(data)
	lights = lights + 1

	if not data.Position then
		print("[MGN] Failed to add an entry to the list of light locations (#" .. lights .. ").")
		return
	end

	data.Position = data.Position:pos()

	table.insert(mgn.LightLocations, data)
end

-- Lobby
AddLightLocation({Position = LMVector(-663, -124, 322, "armory", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30})
AddLightLocation({Position = LMVector(-667, -480, -4, "minigame", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 300, SpriteSize = 32, LightCount = 6})
AddLightLocation({Position = LMVector(-1349, 72, -4, "lobby", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 800, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(-1808, -9, -4, "minigame", true), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30})
AddLightLocation({Position = LMVector(-1911, 1268, -4, "lobby", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30})
AddLightLocation({Position = LMVector(-329, -59, -4, "lobby", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30})
AddLightLocation({Position = LMVector(-625, -302, -308, "land_theater", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 2200, SpriteSize = 32, LightCount = 30})
AddLightLocation({Position = LMVector(323, 327, -104, "land_theater", true), Angles = Angle(25, -180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(-44, 325, -223, "land_theater", true), Angles = Angle(25, 180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(-1, -72, -28, "club", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-460, 4, -4, "sauna", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 50, Depth = 1000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-500, 444, -51, "land_theater", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-258, 1269, -37, "ccal", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-2, -849, -576, "reactor", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 250, Depth = 500, SpriteSize = 32, LightCount = 6})
AddLightLocation({Position = LMVector(-4, -1820, -576, "reactor", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 70, Depth = 1000, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(-314, 0, -4, "minigame", true), Angles = Angle(0, -180, 0), DoubleStriped = true, Width = 200, Depth = 1900, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-694, 719, 317, "armory", true), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 500, SpriteSize = 32, LightCount = 6})
AddLightLocation({Position = LMVector(-1580, 1524, 4, "lobby", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6})
AddLightLocation({Position = LMVector(-782, 1038, 4, "lobby", true), Angles = Angle(0, 180, 0), DoubleStriped = false, Width = 0, Depth = 1000, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(-1148, 585, 4, "lobby", true), Angles = Angle(0, -90, 0), DoubleStriped = false, Width = 0, Depth = 2000, SpriteSize = 32, LightCount = 15})

-- Build
AddLightLocation({Position = LMVector(-1729, 1991, -206, "land_build", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 128, LightCount = 15})
AddLightLocation({Position = LMVector(-823, -109, 2156, "land_vphys", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-504, -1920, 1985, "classroom", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6})

-- RP
AddLightLocation({Position = LMVector(1140, 521, -183, "land_rp", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 64, LightCount = 10})
AddLightLocation({Position = LMVector(-1410, 331, -185, "land_rp", true), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30})
AddLightLocation({Position = LMVector(3747, 328, -185, "land_rp", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30})

-- Build basement
AddLightLocation({Position = LMVector(-422, -21, -55, "classroom", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(-878, -348, -55, "classroom", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-202, -913, -55, "classroom", true), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-615, -46, -3, "land_vphys", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6})
AddLightLocation({Position = LMVector(419, -7, -4, "land_vphys", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10})

-- Build
AddLightLocation({Position = LMVector(-7388, -1129, -112, "Beach", true), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30})
AddLightLocation({Position = LMVector(-2141, -2138, -111, "Beach", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 1000, SpriteSize = 64, LightCount = 10})
AddLightLocation({Position = LMVector(-2328, 3703, 2493, "classroom", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30})
AddLightLocation({Position = LMVector(-4001, -7940, -179, "land_rp", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30})
AddLightLocation({Position = LMVector(-5811, -2430, 2493, "classroom", true), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30})
AddLightLocation({Position = LMVector(3440, 1350, -8, "bunker", true), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30})

-- Fishing
AddLightLocation({Position = LMVector(182, -1306, 0, "land_fish1", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(-92, 13, -61, "land_fish2", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(617, -847, 3, "land_fish2", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6})
AddLightLocation({Position = LMVector(-77, -679, -61, "land_fish2", true), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6})
AddLightLocation({Position = LMVector(-2429, -800, -61, "land_fish2", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15})
AddLightLocation({Position = LMVector(-2438, 550, -61, "land_fish2", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 800, SpriteSize = 32, LightCount = 10})
AddLightLocation({Position = LMVector(25, -1635, -1, "land_fish1", true), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 200, SpriteSize = 64, LightCount = 4})
AddLightLocation({Position = LMVector(-131, -686, 4, "land_fish1", true), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 400, SpriteSize = 64, LightCount = 5})
