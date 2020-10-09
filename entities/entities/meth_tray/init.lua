AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
function ENT:Initialize()
	
	self:SetModelScale( self:GetModelScale() * 2.5, 0 )
	self:SetModel( "models/props/cs_militia/reload_bullet_tray.mdl" )
	self:SetMaterial( "models/debug/debugwhite" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )  
	self:SetSolid( SOLID_VPHYSICS )        
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	phys:SetMass( 1 )
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	print("SPAWNED SOME METH")
	
	self.alreadySet = false
	self.onStove = false

end
 
function ENT:Use( activator, caller )
    local sendUseValue = self:EntIndex()
	
	if (self.onStove == true) then 
	
	for k, v in pairs(StovePosition) do
		
		for i=1,4 do 
		
			if (self:EntIndex() == v[i]) then 
				
				StovePosition[k][i] = 0
				PrintTable(StovePosition)
				self:Remove()
				
				self.onStove = false
				
				print("REMOVE ME")
				
			end
		end 
		
	end
	
	end
	
	if (self.onStove == false) then 
	
		toInventory("Meth Tray", caller, self:GetClass(), "prop")
		self:Remove()
	
	end

	
end

cookMe = false;

function ENT:PhysicsCollide( data, phys )

	if (data.HitEntity:GetClass() == "stove") then
	
		cookMe = true
		
	end
	
	if (data.HitEntity:GetClass() != "stove") then
	
	cookMe = false 
	
	end
		
		print("TOUCHED")
	

end
 
function ENT:Think()

end



function ENT:StartTouch(entity)


	if (entity:GetClass() == "stove") then 

	if (self.alreadySet == false) then 

		self:SetAngles(entity:GetAngles())
		
		
		
		if (StovePosition[entity:EntIndex()][1] == 0 && self.alreadySet == false) then
			self:SetPos( entity:GetPos() + (entity:GetForward() * 5 + entity:GetRight() * 12 + Vector(0, 0, 21))  )
			-- add to array function dumbass
			StovePosition[entity:EntIndex()][1] = self:EntIndex()
			constraint.Weld( self, entity, 0, 0, 0, collision == 0, false )
			self.alreadySet = true
			print("PLACED IN FIRST ONE")
			PrintTable(StovePosition)
			self.onStove = true
		end
		
		
		
		 
		
		if (StovePosition[entity:EntIndex()][2] == 0 && self.alreadySet == false) then
			self:SetPos( entity:GetPos() + (entity:GetForward() * 5 + entity:GetRight() * -12 + Vector(0, 0, 21))  )
			StovePosition[entity:EntIndex()][2] = self:EntIndex()
			constraint.Weld( self, entity, 0, 0, 0, collision == 0, false )
			self.alreadySet = true
			print("PLACED IN SECOND ONE")
			PrintTable(StovePosition)
			self.onStove = true
		end
		
		
		
		
		
		if (StovePosition[entity:EntIndex()][3] == 0 && self.alreadySet == false) then
			self:SetPos( entity:GetPos() + (entity:GetForward() * -10 + entity:GetRight() * 12 + Vector(0, 0, 21))  )
			StovePosition[entity:EntIndex()][3] = self:EntIndex()
			constraint.Weld( self, entity, 0, 0, 0, collision == 0, false )
			self.alreadySet = true
			print("PLACED IN SECOND ONE")
			PrintTable(StovePosition)
			self.onStove = true
		end
		
		
		
		
		
		if (StovePosition[entity:EntIndex()][4] == 0 && self.alreadySet == false) then
			self:SetPos( entity:GetPos() + (entity:GetForward() * -10 + entity:GetRight() * -12 + Vector(0, 0, 21))  )
			StovePosition[entity:EntIndex()][4] = self:EntIndex()
			constraint.Weld( self, entity, 0, 0, 0, collision == 0, false )
			self.alreadySet = true
			print("PLACED IN SECOND ONE")
			PrintTable(StovePosition)
			self.onStove = true
		end
		
		

	end

end

end







