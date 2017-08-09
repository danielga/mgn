local mgn = mgn

mgn.Stage.Intro = {
	Started = false,
	StartedAt = 0,
	StartTime = 0,
	Length = 60,
	EndTime = 60,
	Next = mgn.Stage.Overloading,
	Think = function(self, chrono)
		return chrono < self.Length
	end
}
