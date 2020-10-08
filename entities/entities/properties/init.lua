AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/u4lab/computer_monitor_a.mdl")
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_BBOX)

	self.receivers = {}

	physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
end


function ENT:Interact(activator)

	

end

function ENT:Use(activator, caller)

	openProperties(activator)

end

