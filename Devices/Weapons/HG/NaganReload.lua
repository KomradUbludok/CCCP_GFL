function Create(self)
	self.reloadTimer = Timer()
	self.loadedShell = false
	self.reloadCycle = false

	self.reloadDelay = 150

	self.ejectedShell = false

	if self.Magazine then
		self.ammoCounter = self.Magazine.RoundCount
	else
		self.ammoCounter = 0
	end
end

function Update(self)
	if self.Magazine ~= nil then
		if self.loadedShell == false then
			self.ammoCounter = self.Magazine.RoundCount
		else
			self.loadedShell = false
			self.Magazine.RoundCount = self.ammoCounter + 1
		end
	else
		self.reloadTimer:Reset()
		self.reloadCycle = true
		self.loadedShell = true
	end

	if self:IsActivated() then
		self.reloadCycle = false
	end

	if self.Magazine ~= nil then
		self.ejectedShell = false
	else
		if self.ejectedShell == false then
			self.ejectedShell = true
			if self.HFlipped == false then
				self.negativeNum = 1
			else
				self.negativeNum = -1
			end
		end
	end

	if self.reloadCycle == true and self.reloadTimer:IsPastSimMS(self.reloadDelay) and self:IsFull() == false then
		local actor = MovableMan:GetMOFromID(self.RootID)
		if MovableMan:IsActor(actor) then
			ToActor(actor):GetController():SetState(Controller.WEAPON_RELOAD, true)
			for i = 1, 1 do
				local shell = CreateMOSParticle("Casing")
				shell.Pos = self.Pos
				shell.Vel = Vector(math.random() * -3 * self.negativeNum, 0)
					:RadRotate(self.RotAngle)
					:DegRotate((math.random() * 32) - 16)
				MovableMan:AddParticle(shell)
			end
		end
		self.reloadCycle = false
	end
end
