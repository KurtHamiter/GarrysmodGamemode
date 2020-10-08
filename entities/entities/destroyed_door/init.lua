AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')


 
function ENT:Initialize()
 
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	phys:SetMass( 1000 )
 
	phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	timer.Simple( 5, function() 
	
		self:Remove()
	
	end)

end
	
function ENT:OnTakeDamage( dmginfo )
	
end
 
function ENT:Use( activator, caller )

end
 
function ENT:Think()
   
  
	
end

function ENT:PhysicsCollide( data, phys )
	 
end

function ENT:Touch(entity)
	
end