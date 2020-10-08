AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')


 
function ENT:Initialize()
 
	print("SPAWN SOME CARS")
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )        
	phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:EnableMotion(false) -- Freezes the object in place.
	end
	
	self:DrawShadow( false )

end
	
function ENT:OnTakeDamage( dmginfo )
	
end
 
function ENT:Use( activator, caller )

	local owned_vehicles_query = sql.Query("SELECT * FROM owned_vehicles WHERE owner_id = '"..activator:SteamID().."'")
	
	if (owned_vehicles_query == NIL) then 
	
		owned_vehicles_query = {}
	
	end
	
	net.Start( "vehicleShop" )
	net.WriteTable(owned_vehicles_query)
	net.WriteTable(Vehicles)
	net.Broadcast()
	print("USED")
	print(activator)

end
 
function ENT:Think()
   
  
	
end

function ENT:PhysicsCollide( data, phys )
	 
end

function ENT:Touch(entity)
	
end