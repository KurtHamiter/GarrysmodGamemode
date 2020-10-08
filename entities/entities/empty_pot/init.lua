AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')

weedGrow = {}--
 
function ENT:Initialize()
 
	self:SetModel( "models/props_c17/pottery06a.mdl" )
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
	
	weedGrow[self] = {}
	weedGrow[self]['beenPlanted'] = false

end
 
function ENT:Use( activator, caller )

	self:SetAngles( Angle(0,0,0) )
	
	if (weedGrow[self]['beenPlanted'] == true) then 
	
		if (weedGrow[self]['growTime'] > 99) then 
	
			self:Remove()
		
		end
	
	end

end

function ENT:PhysicsCollide( data, phys )
	 
end

function ENT:Touch(entity)

	if (weedGrow[self]['beenPlanted'] == false) then 

	if (entity:GetClass() == "unplanted_weed") then 

		entity:Remove()
		
		weedGrow[self]['beenPlanted'] = true
		
		weedGrow[self]['ent'] = ents.Create("planted_weed")
		weedGrow[self]['ent']:SetPos( self:GetPos() + (self:GetUp() * 25 + Vector(0, 0, 0) )) -- Check last vector
		--weedGrow[self]['ent']:SetModelScale( weedGrow[self]['ent']:GetModelScale() * .05, 0 )
		weedGrow[self]['ent']:SetAngles( self:GetAngles() )
		weedGrow[self]['ent']:Spawn()
		weedGrow[self]['ent']:SetParent( self , 69 )
		weedGrow[self]['ent']:SetModelScale( weedGrow[self]['ent']:GetModelScale() * 20, 30 )
		weedGrow[self]['growTime'] = 0
		self:SetAngles( Angle(0,0,0) )
		self:SetAngles( Angle(0,0,0) )
		self:SetAngles( Angle(0,0,0) )
		self:SetAngles( Angle(0,0,0) )
		self:SetAngles( Angle(0,0,0) )
		
	end
	
	end
	
end

function ENT:Think()
	
	if (weedGrow[self]['beenPlanted'] == true) then
	
		if (weedGrow[self]['growTime'] < 100) then 
	
			weedGrow[self]['growTime'] = weedGrow[self]['growTime'] + 1
		
		end
	
	end
	
	net.Start( "sendWeed" )
	net.WriteTable( weedGrow )
	net.Broadcast()
	
	for k, v in pairs(weedGrow) do
	
		if (tostring(k) == "[NULL Entity]") then 

			weedGrow[k] = nil
		
		end
	
	end

end