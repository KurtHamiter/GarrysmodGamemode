util.AddNetworkString( "updateProperties" )
--util.AddNetworkString( "clientInitialize2" )

-- Properties

hook.Add( "InitPostEntity", "Ready", function()

Properties = {}

Properties['Suburbs 1'] = {}

table.insert( Properties['Suburbs 1'], "2280,100" )
Properties['Suburbs 1']['price'] = 1970
Properties['Suburbs 1']['owner'] = "0"

--
Properties['Suburbs 2'] = {}

table.insert( Properties['Suburbs 2'], "2192,100" )
Properties['Suburbs 2']['price'] = 1970
Properties['Suburbs 2']['owner'] = "0"

local PropertiesData = {}

for k, v in pairs(Properties) do
		
	for i=1,table.maxn(v) do 
		
		PropertiesData.idSplit = string.Split( tostring(v[i]), "," )
		
		PropertiesData.idInsert = ents.GetMapCreatedEntity( tonumber(PropertiesData.idSplit[1]) )
		
		Properties[k][i] = v[i]..","..tostring(PropertiesData.idInsert:EntIndex())
	
		net.Start( "updateProperties" )
		net.WriteTable( Properties )
		net.Broadcast()

	end
	
end


end)

net.Receive( "clientInitialize", function( len, ply )

	net.Start( "updateProperties" )
	net.WriteTable( Properties )
	net.Broadcast()
	
	moneyUpdate(ply) 

end)

net.Receive( "buyHouse", function( len, ply )

	local buyHouse = {}
	
	buyHouse.Name = net.ReadString()
	
	buyHouse.Cash = sql.Query("SELECT * FROM player_info WHERE steamID = '"..ply:SteamID().."' ")[1]['money']
	
	if (tonumber(buyHouse.Cash) >= Properties[buyHouse.Name]['price']) then 
	
		Properties[buyHouse.Name]['owner'] = ply:SteamID()
		buyHouse.Cash = buyHouse.Cash - Properties[buyHouse.Name]['price']
		sql.Query("UPDATE player_info SET money = "..buyHouse.Cash.." WHERE steamID = '"..ply:SteamID().."' ")
		moneyUpdate(ply)
	
		net.Start( "Realtor" )
		net.WriteTable( Properties )
		net.WriteBool( true ) 
		net.Send(ply)
		
	end

end)

function openProperties(ply)

	net.Start( "Realtor" )
	net.WriteTable( Properties )
	net.WriteBool( false )
	net.Send(ply)

end

-- Put inside client initialization

concommand.Add("lockUnlock", function( ply, cmd, args )
	
	if (ply:GetPos():Distance( ply:GetEyeTrace().Entity:GetPos() ) < 125) then

		if (ply:GetEyeTrace().Entity:GetClass() == "func_door_rotating" || ply:GetEyeTrace().Entity:GetClass() == "prop_door_rotating" || ply:GetEyeTrace().Entity:GetClass() == "func_door") then
	
			for k, v in pairs(Properties) do
		
				for i=1,table.maxn(v) do 
				
				local split = string.Split( tostring(v[i]), "," )

					if (ply:GetEyeTrace().Entity:MapCreationID() == tonumber(split[1])) then
					
						print("GOT SPLIT")
				
						if (v['owner'] == ply:SteamID()) then
					
							if (args[1] == "lock") then 
							
								print("LOCKED")
					
								ply:GetEyeTrace().Entity:Fire("Lock")
							
							end
						
							if (args[1] == "unlock") then 
							
							
								print("UNLOCKED")
								ply:GetEyeTrace().Entity:Fire("Unlock")
						
							end
					
						end
				
					end
	
				end
	
			end
	
		end
	
	end
	
end)

function GM:EntityFireBullets( shooter, data )

	if (shooter:IsPlayer()) then

	local target = shooter:GetEyeTrace().Entity

	for k, v in pairs(Properties) do
	
		for i=1,table.maxn(v) do
		
			local doorDamage = {}
			doorDamage.Split = string.Split( tostring(v[i]), "," )
			
			if (target:MapCreationID() == tonumber(doorDamage.Split[1])) then
			
				if ( target:GetClass() == "prop_door_rotating") then
				
					if (tonumber(doorDamage.Split[2]) > 1) then 
				
						doorDamage.Damage = tonumber(doorDamage.Split[2]) - 10
						doorDamage.Damage2 = tostring(doorDamage.Split[1]..","..doorDamage.Damage..","..doorDamage.Split[3])
				
						Properties[k][i] = doorDamage.Damage2
				
						net.Start( "updateProperties" )
						net.WriteTable( Properties )
						net.Broadcast()
				
					end
				
					if (tonumber(doorDamage.Split[2]) <= 1) then

						target:SetRenderMode( RENDERMODE_TRANSCOLOR )
						target:SetColor( Color( target:GetColor()['r'], target:GetColor()['g'], target:GetColor()['b'], 0 ) ) 
						target:SetCollisionGroup( 10 )
		
						local destroyed_door = ents.Create( "destroyed_door" )
						destroyed_door:SetModel( target:GetModel() )
						destroyed_door:SetAngles( target:GetAngles() )
						destroyed_door:SetSkin( target:GetSkin() )
						destroyed_door:SetPos( target:GetPos() )
						destroyed_door:Spawn()
						phys = destroyed_door:GetPhysicsObject()
							if (phys:IsValid()) then
								phys:Wake()
							end
						phys:SetVelocity( ( shooter:GetForward() * 500) )
					
						destroyDoor(doorDamage.Split[1], doorDamage.Split[3], k, i)
					
					end
				end
				
				if ( target:GetClass() == "func_door_rotating") then
				
					if (tonumber(doorDamage.Split[2]) > 1) then 
				
						doorDamage.Damage = tonumber(doorDamage.Split[2]) - 10
						doorDamage.Damage2 = tostring(doorDamage.Split[1]..","..doorDamage.Damage..","..doorDamage.Split[3])
				
						Properties[k][i] = doorDamage.Damage2
				
						net.Start( "updateProperties" )
						net.WriteTable( Properties )
						net.Broadcast()
				
					end
				
					if (tonumber(doorDamage.Split[2]) <= 1) then

						target:SetRenderMode( RENDERMODE_TRANSCOLOR )
						target:SetColor( Color( target:GetColor()['r'], target:GetColor()['g'], target:GetColor()['b'], 0 ) ) 
						target:SetCollisionGroup( 10 )
					
						destroyDoor(doorDamage.Split[1], doorDamage.Split[3], k, i)
					
					end
				end
				
				if ( target:GetClass() == "func_door") then
				
					if (tonumber(doorDamage.Split[2]) > 1) then 
				
						doorDamage.Damage = tonumber(doorDamage.Split[2]) - 10
						doorDamage.Damage2 = tostring(doorDamage.Split[1]..","..doorDamage.Damage..","..doorDamage.Split[3])
				
						Properties[k][i] = doorDamage.Damage2
				
						net.Start( "updateProperties" )
						net.WriteTable( Properties )
						net.Broadcast()
				
					end
				
					if (tonumber(doorDamage.Split[2]) <= 1) then

						target:SetRenderMode( RENDERMODE_TRANSCOLOR )
						target:SetColor( Color( target:GetColor()['r'], target:GetColor()['g'], target:GetColor()['b'], 0 ) ) 
						target:SetCollisionGroup( 10 )
					
						destroyDoor(doorDamage.Split[1], doorDamage.Split[3], k, i)
					
					end
				end

			end
		end
	end
	
end 

function destroyDoor(doorID1, doorID2, kID, iID) 
	
	timer.Simple( 5, function() 
	
		ents.GetMapCreatedEntity( doorID1 ):SetColor( Color( ents.GetMapCreatedEntity( doorID1 ):GetColor()['r'], ents.GetMapCreatedEntity( doorID1 ):GetColor()['g'], ents.GetMapCreatedEntity( doorID1 ):GetColor()['b'], 255 ) ) 
		ents.GetMapCreatedEntity( doorID1 ):SetCollisionGroup( 0 ) 
			
		Properties[kID][iID] = tostring(doorID1..",100"..","..doorID2)
			
		net.Start( "updateProperties" )
		net.WriteTable( Properties )
		net.Broadcast()
		
	end )
	
	end
	
end
