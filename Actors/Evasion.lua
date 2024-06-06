function Create(self)
	self.EvasionTimer = Timer()
	self.Evasion = self:NumberValueExists("Evasion") and self:GetNumberValue("Evasion")
	self.AverageAccuracy = 50
	self.TimeInterval = 250
end

function EvasionMath(acc, eva) 
	return 100 - (acc / (acc + eva) * 100)
end

function Update(self)
	local duration = math.random(self.TimeInterval)
	if self.EvasionTimer:IsPastSimMS(duration) and math.random(100) <= EvasionMath(self.AverageAccuracy, self.Evasion)  then
		--self:FlashWhite(1000)
		self.EvasionTimer:Reset()
		self.GetsHitByMOs = false;
		for att in self.Attachables do
			att.GetsHitByMOs = false;
		end
	elseif self.EvasionTimer:IsPastSimMS(duration) and math.random(100) > EvasionMath(self.AverageAccuracy, self.Evasion) then
		self.EvasionTimer:Reset()
		self.GetsHitByMOs = true;
		for att in self.Attachables do
			att.GetsHitByMOs = true;
		end
	end
end