mgn.Stage.Intro = {
	Started = false,
	StartTime = 0,
	Next = mgn.Stage.Overloading,
	Start = function(self, time)
	end,
	Think = function(self, chrono)
		return chrono < 60
	end,
	End = function(self, time)
	end
}
