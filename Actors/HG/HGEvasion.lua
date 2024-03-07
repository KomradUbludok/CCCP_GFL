function Create(self)
	self.EvasionTimer = Timer()
	self.Duration = 750
	self.Evasion = 100
	self.EvasionFail = 50
end

function Update(self)
	if self.EvasionTimer:IsPastSimMS(self.Duration) and self.Evasion >= self.EvasionFail then
		self.Evasion = math.random(100)
		self.EvasionTimer:Reset()
		self.GetsHitByMOs = false;
	elseif self.EvasionTimer:IsPastSimMS(self.Duration) and self.Evasion < self.EvasionFail then
		self.Evasion = math.random(100)
		self.EvasionTimer:Reset()
		self.HitsMOs = true;
		self.GetsHitByMOs = true;
	end
end