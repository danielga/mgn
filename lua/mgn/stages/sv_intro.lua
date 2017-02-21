mgn.Stage.Intro = {
	Started = false,
	StartTime = 0,
	Next = mgn.Stage.Overloading,
	Think = function(self, chrono)
		return chrono < 60
	end
}
