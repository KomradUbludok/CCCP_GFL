function Create(self)
    self.drinkTimer = Timer()
    self.drinkTime = 1000
    self.drinkSound = CreateSoundContainer("Vodka Drink", "GFLRu.rte")
    self.WasSoundPlayed = false
end

function OnFire(self)
    self.drinkSound:Play(self.Pos)
end

function Update(self)
    local parent = self:GetRootParent()
    if parent and IsActor(parent) then
        parent = ToActor(parent);
        local controller = parent:GetController()
        if parent:IsPlayerControlled() then
            if self.Magazine.IsEmpty == true then
                --print("controller.Team")
                self:GibThis()
                controller:SetState(Controller.WEAPON_CHANGE_NEXT, true);
            end
        else
            if self.drinkTimer:IsPastSimMS(self.drinkTime) then
                --print("controller.Team")
                self:GibThis()
                controller:SetState(Controller.WEAPON_CHANGE_PREV, true);
                --parent:SetState(Actor.UpperBodyState.WEAPON_READY, true);
            end
        end
    end
end