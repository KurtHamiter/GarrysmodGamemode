AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')


 
function ENT:Initialize()
 
	self:SetModel( "models/props_c17/furniturestove001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	phys:SetMass( 100 )
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	StovePosition[self:EntIndex()] = {}
	
	for i=1,4 do 
	
		StovePosition[self:EntIndex()][i] = 0
	
	end

end
 
function ENT:Use( activator, caller )

end
 
function ENT:Think()
   
 
	
end

function ENT:PhysicsCollide( data, phys )
	 
end

function ENT:Touch(entity)
	
end