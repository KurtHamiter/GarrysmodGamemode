AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')


 
function ENT:Initialize()
 
	self:SetModel( "models/props_c17/furniturestove001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
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
   
  --self:SetAngles(Angle(0 ,0 ,0 ))
	
end

function ENT:PhysicsCollide( data, phys )
	 
end

function ENT:Touch(entity)
	
end