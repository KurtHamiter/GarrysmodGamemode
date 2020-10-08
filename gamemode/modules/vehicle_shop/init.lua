Vehicles = {}

Vehicles['Porsche 918'] = {}
Vehicles['Porsche 918']['Model'] = 'models/tdmcars/por_918.mdl'
Vehicles['Porsche 918']['Script'] = 'Scripts/vehicles/tdmcars/918spyd.txt'
Vehicles['Porsche 918']['backForward'] = -15.5 -- Left
Vehicles['Porsche 918']['backRight'] = 112 -- Forwards
Vehicles['Porsche 918']['backUp'] = 34 -- Up
Vehicles['Porsche 918']['plateSizeX'] = 311
Vehicles['Porsche 918']['plateSizeY'] = 60
Vehicles['Porsche 918']['Price'] = 100

--
Vehicles['Porsche Cayenne'] = {}
Vehicles['Porsche Cayenne']['Model'] = 'models/tdmcars/por_cayenne12.mdl'
Vehicles['Porsche Cayenne']['Script'] = 'scripts/vehicles/tdmcars/cayenne12.txt'
Vehicles['Porsche Cayenne']['backForward'] = -12
Vehicles['Porsche Cayenne']['backRight'] = 115.25
Vehicles['Porsche Cayenne']['backUp'] = 50
Vehicles['Porsche Cayenne']['plateSizeX'] = 250
Vehicles['Porsche Cayenne']['plateSizeY'] = 100
Vehicles['Porsche Cayenne']['Price'] = 200

Vehicles['Porsche Cayenne Old'] = {}
Vehicles['Porsche Cayenne Old']['Model'] = 'models/tdmcars/cayenne.mdl'
Vehicles['Porsche Cayenne Old']['Script'] = 'scripts/vehicles/tdmcars/cayenne.txt'
Vehicles['Porsche Cayenne Old']['backForward'] = -12
Vehicles['Porsche Cayenne Old']['backRight'] = 111.3
Vehicles['Porsche Cayenne Old']['backUp'] = 44.25
Vehicles['Porsche Cayenne Old']['plateSizeX'] = 250
Vehicles['Porsche Cayenne Old']['plateSizeY'] = 76
Vehicles['Porsche Cayenne Old']['Price'] = 300--

hook.Add( "Initialize", "some_unique_name", function()


local carSpawn = ents.Create( "vehicle_shop_car" )
carSpawn:SetModel( "models/tdmcars/por_918.mdl" )--
carSpawn:SetPos( Vector( 2362.382813, -1305.585083, 71.997208 ) )
carSpawn:SetAngles(Angle(0,150,0))
carSpawn:Spawn()--


local carSpawn = ents.Create( "vehicle_shop_car" )
carSpawn:SetModel( "models/tdmcars/por_cayenne12.mdl" )----
carSpawn:SetPos( Vector( 2162.382813, -1305.585083, 70.997208 ) )
carSpawn:SetAngles(Angle(0,150,0))
carSpawn:Spawn()
--

local carSpawn = ents.Create( "vehicle_shop_car" )
carSpawn:SetModel( "models/tdmcars/cayenne.mdl" )--
carSpawn:SetPos( Vector( 1962.382813, -1305.585083, 69.997208 ) )--
carSpawn:SetAngles(Angle(0,150,0))
carSpawn:Spawn()

local carSpawn = ents.Create( "vehicle_spawn" )
carSpawn:SetPos( Vector( -2675.676514, -1000.681091, 114.187393 ) )--
carSpawn:SetAngles(Angle(0,135,0))--
carSpawn:Spawn()

end)
--
math.randomseed(os.time()) 
math.random(); math.random(); math.random() 

net.Receive( "buyVehicle", function( len, ply )

	local vehicleName = net.ReadString()
	local vehicleModel = net.ReadString()--
	local vehicleScript = net.ReadString()--
	
	local randLetters = {}
	
	randLetters[1] = "A"
	randLetters[2] = "B"
	randLetters[3] = "C"
	randLetters[4] = "D"
	randLetters[5] = "E"
	randLetters[6] = "F"
	randLetters[7] = "G"
	randLetters[8] = "H"
	randLetters[9] = "I"
	randLetters[10] = "J"
	randLetters[11] = "K"
	randLetters[12] = "L"
	randLetters[13] = "M"
	randLetters[14] = "N"
	randLetters[15] = "O"
	randLetters[16] = "P"
	randLetters[17] = "Q"
	randLetters[18] = "R"
	randLetters[19] = "S"
	randLetters[20] = "T"
	randLetters[21] = "U"
	randLetters[22] = "V"
	randLetters[23] = "W"
	randLetters[24] = "X"
	randLetters[25] = "Y"
	randLetters[26] = "X"
	
	local createLicensePlate = ""
	
	for i = 1,7 do 
		if (math.random(1, 2) == 1) then
		
			createLicensePlate = createLicensePlate..randLetters[math.random(1, 26)]
			
		else
		
			createLicensePlate = createLicensePlate..tostring(math.random(0,9))
		
		end
	end
	
	print("CREATED LICENSE PLATE")
	print(createLicensePlate)
	
	--sql.Query("CREATE TABLE owned_vehicles ( owner_ID TEXT , car_name TEXT, car_entity TEXT, plate_num TEXT)" )
	sql.Query("INSERT INTO owned_vehicles( owner_ID , car_name, car_model, car_script, plate_num ) VALUES( '"..ply:SteamID().."' , '"..vehicleName.."' , '"..vehicleModel.."', '"..vehicleScript.."', '"..createLicensePlate.."' ) ")--
	
	PrintTable( sql.Query("SELECT * FROM owned_vehicles ") )

end)