AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/props/cs_assault/money.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )     
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
 
	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	self.moneyValue = moneyAmountToInsert
	
	print("SPAWNED SOME CASH")
	print(self.moneyValue)
	

end
 
function ENT:Use( activator, caller )
    local sendUseValue = self:EntIndex()
	local currentCash = sql.Query("SELECT * FROM player_info WHERE steamID = '"..caller:SteamID().."' ")[1]['money']
	local currentCash = currentCash + self.moneyValue
	sql.Query("UPDATE player_info SET money = "..currentCash.." WHERE steamID = '"..caller:SteamID().."' ")
	moneyUpdate(caller)
	self:Remove()
end
 
function ENT:Think()
    
end

function ENT:PhysicsCollide( data, phys )
	 print(data)
end