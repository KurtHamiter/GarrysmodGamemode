spawnedVehicle = {}

function openOwnedVehicles(ply) 

	local sendQuery = sql.Query("SELECT * FROM owned_vehicles WHERE owner_ID = '"..ply:SteamID().."'")
	if (sendQuery != nil) then
		net.Start( "ownedVehicles" )
		net.WriteTable(sendQuery)
		net.Send(ply)
	end

end

net.Receive( "spawnVehicle", function( len, ply )

	local vehicleModel = net.ReadString()
	local vehicleScript = net.ReadString()
	local vehiclePlate = net.ReadString()
	local vehicleName = net.ReadString()
	local vehiclePlatePos = net.ReadString()
	
	local button = ents.Create( "prop_vehicle_jeep" )
	button:SetModel( vehicleModel )
	button:SetPos( Vector( -2991.043701, -1315.416504, 76.031250 ) )
	button:SetKeyValue("vehiclescript",vehicleScript)
	button:Spawn()
	
	print("BUTTON PRESS SPAWN CAR")
	
	if (spawnedVehicle[tostring(ply:SteamID())] != nil) then--
		
		if (Entity(tonumber(spawnedVehicle[tostring(ply:SteamID())]['id'])):IsValid()) then
		
			Entity(tonumber(spawnedVehicle[tostring(ply:SteamID())]['id'])):Remove()
		
		end
		
		spawnedVehicle[tostring(ply:SteamID())]['id'] = tostring(button:EntIndex())
	
	end
	
	if (spawnedVehicle[tostring(ply:SteamID())] == nil) then
	
		spawnedVehicle[tostring(ply:SteamID())] = {}
	
		spawnedVehicle[tostring(ply:SteamID())]['id'] = tostring(button:EntIndex())

	end

	PrintTable(spawnedVehicle)
	
	net.Start( "platePos" )
	net.WriteString(button:EntIndex())
	net.WriteTable(spawnedVehicle)
	net.WriteString(tostring(Vehicles[vehicleName]['backForward']))
	net.WriteString(tostring(Vehicles[vehicleName]['backRight']))
	net.WriteString(tostring(Vehicles[vehicleName]['backUp']))
	net.WriteString(tostring(Vehicles[vehicleName]['plateSizeX']))
	net.WriteString(tostring(Vehicles[vehicleName]['plateSizeY']))--
	net.WriteString(vehiclePlate)--
	net.Send(ply)
	
	print("WRITE BACK STUFF")
	PrintTable(Vehicles[vehicleName])


end)