function Create(self)
    self.parent = ToAHuman(self:GetRootParent())
end

function Update(self)
    if self.parent.Status == Actor.DYING or self.parent.Status == Actor.DEAD then
        self:GibThis()
    end
end