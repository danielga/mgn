
if LMVector == nil then
	pcall(require,'landmark')
end

if LMVector == nil then
	mgn.AlarmLocations = {}
	mgn.LightLocations = {}
	return
end

local missing={}
local function FILT(t)
	for i=#t,1,-1 do
		local data = t[i]
		
		local lmpos = data.Position
		table.insert(lmpos,true)
		lmpos = LMVector(unpack(lmpos)) 
		if lmpos then
			data.Position = lmpos:pos()
		else
			table.remove(t,i)
			missing[#missing+1] = tostring(data.Position[4] or "???")
		end
	end
	return t
end

mgn.AlarmLocations = FILT{
	-- Lobby
	{Position = {-373, -623, 274, "lobby"}, Normal = Vector(0, 1, 0)},
	{Position = {0, 64, 118, "club"}, Normal = Vector (0, -1, 0)},
	{Position = {-960, 720, 450, "armory"}, Normal = Vector(-1, 0, 0)},
	{Position = {-556, 2089, 110, "lobby"}, Normal = Vector(0, -1, 0)},
	{Position = {1, -992, -409, "reactor"}, Normal = Vector(0, 1, 0)},

	-- RP
	{Position = {1139, 845, -41, "land_rp"}, Normal = Vector(0, -1, 0)},

	-- Fishing
	{Position = {-228, -1566, 75, "land_fish1"}, Normal = Vector(0, -1, 0)},
	{Position = {-77, -296, 205, "land_fish2"}, Normal = Vector(0, 1, 0)},

	-- Soccer
	{Position = {-33, 174, 120, "soccer"}, Normal = Vector(0, -1, 0)},

	-- Build
	{Position = {-74, -916, 2764, "land_vphys"}, Normal = Vector(1, 0, 0)},
	{Position = {-2195, 352, 2205, "Smooth"}, Normal = Vector(0, 1, 0)},
	{Position = {-10, 2704, 736, "Silo"}, Normal = Vector(0, 1, 0)},
	{Position = {-908, 105, 2166, "land_caves"}, Normal = Vector(-1, 0, 0)},
	{Position = {101, 482, 68, "bunker"}, Normal = Vector(0, 1, 0)},
	{Position = {-4498, -5020, 75, "land_rp"}, Normal = Vector(1, 0, 0)},
	{Position = {213, -3226, -11171, "AutoInstance0flood"}, Normal = Vector(0, 1, 0)},

	-- Build basement
	{Position = {-964, -1068, 13, "classroom"}, Normal = Vector(0, 1, 0)},

	-- Build caves
	{Position = {-3, -1840, -25, "Smooth"}, Normal = Vector (0, -1, 0)}
}

mgn.LightLocations = FILT{
	-- Lobby
	{Position = {-663, -124, 322, "armory"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = {-667, -480, -4, "minigame"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 300, SpriteSize = 32, LightCount = 6},
	{Position = {-1349, 72, -4, "lobby"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 800, SpriteSize = 32, LightCount = 10},
	{Position = {-1808, -9, -4, "minigame"}, Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = {-1911, 1268, -4, "lobby"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = {-329, -59, -4, "lobby"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 150, Depth = 3000, SpriteSize = 32, LightCount = 30},
	{Position = {-625, -302, -308, "land_theater"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 2200, SpriteSize = 32, LightCount = 30},
	{Position = {323, 327, -104, "land_theater"}, Angles = Angle(25, -180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10},
	{Position = {-44, 325, -223, "land_theater"}, Angles = Angle(25, 180, 0), DoubleStriped = true, Width = 80, Depth = 500, SpriteSize = 32, LightCount = 10},
	{Position = {-1, -72, -28, "club"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = {-460, 4, -4, "sauna"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 50, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = {-500, 444, -51, "land_theater"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = {-258, 1269, -37, "ccal"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 15},
	{Position = {-2, -849, -576, "reactor"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 250, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = {-4, -1820, -576, "reactor"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 70, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = {-314, 0, -4, "minigame"}, Angles = Angle(0, -180, 0), DoubleStriped = true, Width = 200, Depth = 1900, SpriteSize = 32, LightCount = 15},
	{Position = {-694, 719, 317, "armory"}, Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = {-1580, 1524, 4, "lobby"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = {-782, 1038, 4, "lobby"}, Angles = Angle(0, 180, 0), DoubleStriped = false, Width = 0, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = {-1148, 585, 4, "lobby"}, Angles = Angle(0, -90, 0), DoubleStriped = false, Width = 0, Depth = 2000, SpriteSize = 32, LightCount = 15},

	-- Build
	{Position = {-1729, 1991, -206, "land_build"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 128, LightCount = 15},
	{Position = {-823, -109, 2156, "land_vphys"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 100, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = {-504, -1920, 1985, "classroom"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},

	-- RP
	{Position = {1140, 521, -183, "land_rp"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 64, LightCount = 10},
	{Position = {-1410, 331, -185, "land_rp"}, Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = {3747, 328, -185, "land_rp"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},

	-- Build basement
	{Position = {-422, -21, -55, "classroom"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = {-878, -348, -55, "classroom"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = {-202, -913, -55, "classroom"}, Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = {-615, -46, -3, "land_vphys"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = {419, -7, -4, "land_vphys"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 200, Depth = 1000, SpriteSize = 32, LightCount = 10},

	-- Build
	{Position = {-7388, -1129, -112, "Beach"}, Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = {-2141, -2138, -111, "Beach"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 1000, SpriteSize = 64, LightCount = 10},
	{Position = {-2328, 3703, 2493, "classroom"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = {-4001, -7940, -179, "land_rp"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = {-5811, -2430, 2493, "classroom"}, Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},
	{Position = {3440, 1350, -8, "bunker"}, Angles = Angle(0, 180, 0), DoubleStriped = true, Width = 300, Depth = 10000, SpriteSize = 64, LightCount = 30},

	-- Fishing
	{Position = {182, -1306, 0, "land_fish1"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = {-92, 13, -61, "land_fish2"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 1000, SpriteSize = 32, LightCount = 10},
	{Position = {617, -847, 3, "land_fish2"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = {-77, -679, -61, "land_fish2"}, Angles = Angle(0, 0, 0), DoubleStriped = true, Width = 100, Depth = 500, SpriteSize = 32, LightCount = 6},
	{Position = {-2429, -800, -61, "land_fish2"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 200, Depth = 2000, SpriteSize = 32, LightCount = 15},
	{Position = {-2438, 550, -61, "land_fish2"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 200, Depth = 800, SpriteSize = 32, LightCount = 10},
	{Position = {25, -1635, -1, "land_fish1"}, Angles = Angle(0, 90, 0), DoubleStriped = true, Width = 100, Depth = 200, SpriteSize = 64, LightCount = 4},
	{Position = {-131, -686, 4, "land_fish1"}, Angles = Angle(0, -90, 0), DoubleStriped = true, Width = 100, Depth = 400, SpriteSize = 64, LightCount = 5}
}

if missing[1] then
	local t={}
	for k,v in next,missing do
		t[v]=(t[v] or 0) + 1
	end
	local tt={}
	for k,v in next,t do
		tt[#tt+1] = ("%s x%d"):format(k,v)	
	end
	Msg"[MGN] Missing landmarks: " print(table.concat(tt,', '))
end
