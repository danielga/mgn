function ENT:Initialize()
	local monitor = ents.Create("prop_physics")
	monitor:SetModel("models/props_combine/combine_interface001.mdl")
	monitor:SetPos(Vector(-13701, 2997, 14305))
	monitor:SetAngles(Angle(0, 0, 0))
	monitor:Spawn()

	local physobj = monitor:GetPhysicsObject()
	if IsValid(physobj) then
		physobj:EnableMotion(false)
	end

	self:SetParent(monitor) -- in case we move around the monitor prop
end

function ENT:CallCMD(ply, cmd)
	if not ply:IsSuperAdmin() then
		return
	end

	if cmd == "SELF-DESTRUCT" then
		mgn.ActivateAlert()
	elseif cmd == "NORMAL" then
		mgn.DisableAlert()
	end
end
