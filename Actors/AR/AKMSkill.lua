function Create(self)
	self.SkillSound = CreateSoundContainer("AKM Skill", "GFLRu.rte")
	self.SkillActivateSound = CreateSoundContainer("Explosive Device Activate", "Base.rte")
	self.SkillCooldown = Timer()
	self.SkillCooldownDuration = 50000
	self.SkillDuration = 30000
	self.FirstTimeUsing = true
	self.PlayerPreferredHD = self.EquippedItem:GetModuleAndPresetName();
end

function Update(self)
	local weapon = self.EquippedItem:GetModuleAndPresetName();
	self.controller = self:GetController();
	if self:IsPlayerControlled() and UInputMan:KeyPressed(Key.Z) and (self.SkillCooldown:IsPastSimMS(self.SkillCooldownDuration) or self.FirstTimeUsing) then
		self.SkillSound:Play(self.Pos)
		self.SkillCooldown:Reset()
		self.FirstTimeUsing = false
		if not self.SkillCooldown:IsPastSimMS(self.SkillDuration) and weapon == self.PlayerPreferredHD then
			self.SkillActivateSound:Play(self.Pos)
			self:FlashWhite(100)
			weapon.ReloadTime = 5
			--self.EquippedItem:Reload()
			--self:RemoveInventoryItem()
			--self:AddInventoryItem()
			self.EquippedItem:SetRateOfFire(900)
		end
	end
end