function Create(self)
	self.SkillSound = CreateSoundContainer("AKM Skill", "GFLRu.rte")
	self.SkillActivateSound = CreateSoundContainer("Explosive Device Activate", "Base.rte")
	self.SkillCooldownDuration = 5000
	self.SkillDuration = 30000
	self.SkillCooldown = Timer(self.SkillCooldownDuration)
end

function Update(self)
	if self.EquippedItem then
		local weapon = ToHDFirearm(self.EquippedItem)
		self.controller = self:GetController();
		if self:IsPlayerControlled() and UInputMan:KeyPressed(Key.Z) and self.SkillCooldown:IsPastSimMS(self.SkillCooldownDuration) and self.EquippedItem.PresetName == "AKM" then
			self.SkillSound:Play(self.Pos)
			self.SkillCooldown:Reset()
			if not self.SkillCooldown:IsPastSimMS(self.SkillDuration)  then
				self.SkillActivateSound:Play(self.Pos)
				self:FlashWhite(200)
				--print(weapon.Magazine.NextRound)
				weapon:SetNextMagazineName("AKMMag Enhanced")
				weapon:Reload()
			end
		end
	end
end