function Create(self)
	self.EvasionTimer = Timer()
	self.Evasion = self:NumberValueExists("Evasion") and self:GetNumberValue("Evasion")
	self.AverageAccuracy = 70
	self.TimeInterval = 500
end

function EvasionMath(acc, eva) 
	return 100 - (acc / (acc + eva) * 100)
end

function Update(self)
	local duration = math.random(self.TimeInterval)
	print(EvasionMath(self.AverageAccuracy, self.Evasion))
	if self.EvasionTimer:IsPastSimMS(duration) and math.random(100) <= EvasionMath(self.AverageAccuracy, self.Evasion)  then
		--self:FlashWhite(duration)
		self.GetsHitByMOs = false;
		for att in self.Attachables do
			att.GetsHitByMOs = false;
		end
		self.EvasionTimer:Reset()
	elseif self.EvasionTimer:IsPastSimMS(duration) and math.random(100) > EvasionMath(self.AverageAccuracy, self.Evasion) then
		self.GetsHitByMOs = true;
		for att in self.Attachables do
			att.GetsHitByMOs = true;
		end
		self.EvasionTimer:Reset()
	end
end