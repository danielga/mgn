
if LMVector == nil then
	pcall(require,'landmark')
end

if LMVector == nil then
	mgn.AlarmLocations = {}
	mgn.LightLocations = {}
	return
end

mgn.AlarmLocations = {
	-- Lobby
	{Position = LMVector(-373, -623, 274, "lobby", true):pos(), Normal = Vector(0, 1, 0)},
	{Position = LMVector(0, 64, 118, "club", true):pos(), Normal = Vector (0, -1, 0)},
	{Position = LMVector(-960, 720, 450, "armory", true):pos(), Normal = Vector(-1, 0, 0)},
	{Position = LMVector(-556, 2089, 110, "lobby", true):pos(), Normal = Vector(0, -1, 0)},
	{Position = LMVector(1, -992, -409, "reactor", true):pos(), Normal = Vector(0, 1, 0)},

	-- RP
	{Position = LMVector(1139, 845, -41, "land_rp", true):pos(), Normal = Vector(0, -1, 0)},

	-- Fishing
	{Position = LMVector(-228, -1566, 75, "land_fish1", true):pos(), Normal = Vector(0, -1, 0)},
	{Position = LMVector(-77, -296, 205, "land_fish2", true):pos(), Normal = Vector(0, 1, 0)},

	-- Soccer
	{Position = LMVector(-33, 174, 120, "soccer", true):pos(), Normal = Vector(0, -1, 0)},

	-- Build
	{Position = LMVector(-74, -916, 2764, "land_vphys", true):pos(), Normal = Vector(1, 0, 0)},
	{Position = LMVector(-2195, 352, 2205, "Smooth", true):pos(), Normal = Vector(0, 1, 0)},
	{Position = LMVector(-10, 2704, 736, "Silo", true):pos(), Normal = Vector(0, 1, 0)},
	{Position = LMVector(-908, 105, 2166, "land_caves", true):pos(), Normal = Vector(-1, 0, 0)},
	{Position = LMVector(101, 482, 68, "bunker", true):pos(), Normal = Vector(0, 1, 0)},
	{Position = LMVector(-4498, -5020, 75, "land_rp", true):pos(), Normal = Vector(1, 0, 0)},
	{Position = LMVector(213, -3226, -11171, "AutoInstance0flood", true):pos(), Normal = Vector(0, 1, 0)},

	-- Build basement
	{Position = LMVector(-964, -1068, 13, "classroom", true):pos(), Normal = Vector(0, 1, 0)},

	-- Build caves
	{Position = LMVector(-3, -1840, -25, "Smooth", true):pos(), Normal = Vector (0, -1, 0)}
}

mgn.LightLocations = {
	-- Lobby
	{Position = LMVector(-663, -124, 322, "armory", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = LMVector(-667, -480, -4, "minigame", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 300, SpriteSize = 32, LightCount = 6},
	{Position = LMVector(-1349, 72, -4, "lobby", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 800, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(-1808, -9, -4, "minigame", true):pos(), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = LMVector(-1911, 1268, -4, "lobby", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = LMVector(-329, -59, -4, "lobby", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = LMVector(-625, -302, -308, "land_theater", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 2200, SpriteSize = 32, LightCount = 30},
	{Position = LMVector(323, 327, -104, "land_theater", true):pos(), Angles = Angle(25, -180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(-44, 325, -223, "land_theater", true):pos(), Angles = Angle(25, 180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(-1, -72, -28, "club", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-460, 4, -4, "sauna", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 50, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-500, 444, -51, "land_theater", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-258, 1269, -37, "ccal", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-2, -849, -576, "reactor", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 250, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = LMVector(-4, -1820, -576, "reactor", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 70, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(-314, 0, -4, "minigame", true):pos(), Angles = Angle(0, -180, 0), DoubleStriped = true, Width = 200, Depth = 1900, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-694, 719, 317, "armory", true):pos(), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = LMVector(-1580, 1524, 4, "lobby", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = LMVector(-782, 1038, 4, "lobby", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = false, Width = 0, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(-1148, 585, 4, "lobby", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = false, Width = 0, Depth = 2000, SpriteSize = 32, LightCount = 15},

	-- Build
	{Position = LMVector(-1729, 1991, -206, "land_build", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 128, LightCount = 15},
	{Position = LMVector(-823, -109, 2156, "land_vphys", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-504, -1920, 1985, "classroom", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},

	-- RP
	{Position = LMVector(1140, 521, -183, "land_rp", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 64, LightCount = 10},
	{Position = LMVector(-1410, 331, -185, "land_rp", true):pos(), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = LMVector(3747, 328, -185, "land_rp", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},

	-- Build basement
	{Position = LMVector(-422, -21, -55, "classroom", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(-878, -348, -55, "classroom", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-202, -913, -55, "classroom", true):pos(), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-615, -46, -3, "land_vphys", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = LMVector(419, -7, -4, "land_vphys", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10},

	-- Build
	{Position = LMVector(-7388, -1129, -112, "Beach", true):pos(), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = LMVector(-2141, -2138, -111, "Beach", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 1000, SpriteSize = 64, LightCount = 10},
	{Position = LMVector(-2328, 3703, 2493, "classroom", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = LMVector(-4001, -7940, -179, "land_rp", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = LMVector(-5811, -2430, 2493, "classroom", true):pos(), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = LMVector(3440, 1350, -8, "bunker", true):pos(), Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},

	-- Fishing
	{Position = LMVector(182, -1306, 0, "land_fish1", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(-92, 13, -61, "land_fish2", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(617, -847, 3, "land_fish2", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = LMVector(-77, -679, -61, "land_fish2", true):pos(), Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = LMVector(-2429, -800, -61, "land_fish2", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = LMVector(-2438, 550, -61, "land_fish2", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 800, SpriteSize = 32, LightCount = 10},
	{Position = LMVector(25, -1635, -1, "land_fish1", true):pos(), Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 200, SpriteSize = 64, LightCount = 4},
	{Position = LMVector(-131, -686, 4, "land_fish1", true):pos(), Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 400, SpriteSize = 64, LightCount = 5}
}
