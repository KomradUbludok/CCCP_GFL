function Create(self)
	self.EvasionTimer = Timer()
	self.Duration = 275
	self.Evasion = 100
	self.EvasionFail = 60
end

function Update(self)
	if self.EvasionTimer:IsPastSimMS(self.Duration) and self.Evasion >= self.EvasionFail then
		--self:FlashWhite(1000)
		self.Evasion = math.random(100)
		self.EvasionTimer:Reset()
		self.GetsHitByMOs = false;
		for att in self.Attachables do
			att.GetsHitByMOs = false;
		end
	elseif self.EvasionTimer:IsPastSimMS(self.Duration) and self.Evasion < self.EvasionFail then
		self.Evasion = math.random(100)
		self.EvasionTimer:Reset()
		self.GetsHitByMOs = true;
		for att in self.Attachables do
			att.GetsHitByMOs = true;
		end
	end
end