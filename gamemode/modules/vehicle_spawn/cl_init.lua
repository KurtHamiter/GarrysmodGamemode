net.Receive( "ownedVehicles", function( len, ply )
	
	-----------------
	
	alreadyOpened = false

	local owned_vehicles = net.ReadTable()
	
	print("VEHICLE SHOP111")
	
	PrintTable(owned_vehicles)
	
	print(table.maxn(owned_vehicles))--
	
	local Vehicles = net.ReadTable()
	
	if (alreadyOpened == false) then
	
	VehicleFrame = vgui.Create( "DFrame" ) -- Create a Frame to contain everything.
	VehicleFrame:SetTitle( "Owned Vehicles" )
	VehicleFrame:SetSize( 500, 300 )
	VehicleFrame:Center()
	VehicleFrame:MakePopup()
	VehicleFrame:SetMouseInputEnabled( true )

	local RealtorScroll = vgui.Create( "DScrollPanel", VehicleFrame ) -- Create the Scroll panel
	RealtorScroll:Dock( FILL )

	for k, v in pairs(owned_vehicles) do
	
			local continueLoop = true
			
			for i=1,table.maxn(owned_vehicles) do 
			
				print(owned_vehicles[i]['car_name'])
			
			end

			VehicleFrameListItem = RealtorScroll:Add( "DPanel" ) -- Add DPanel to the DIconLayout
			VehicleFrameListItem:SetSize( 500, 50 ) -- Set the size of it
			VehicleFrameListItem:SetContentAlignment( 1 )
			VehicleFrameListItem:SetMouseInputEnabled( true )
			VehicleFrameListItem:Dock(TOP)
			VehicleFrameListItem:DockMargin(2, 0, 2, 5)
			VehicleFrameListItem:SetContentAlignment( 5 )
	
	
			local VehicleFrameLabel = vgui.Create( "DLabel", VehicleFrameListItem )
			VehicleFrameLabel:SetPos( 13, 19 ) -- Set the position of the label
			VehicleFrameLabel:SetText( v['car_name'] ) --  Set the text of the label
			VehicleFrameLabel:SizeToContents() -- Size the label to fit the text in it
			VehicleFrameLabel:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
			
			local VehicleFrameButton = vgui.Create( "DButton", VehicleFrameListItem )
			VehicleFrameButton:SetSize( 94, 35 )
			VehicleFrameButton:SetPos( 385, 8 ) -- Set the position of the label
			VehicleFrameButton:SetText( "Spawn" )
			VehicleFrameButton:SetMouseInputEnabled( true )
			--DLabel:SizeToContents() -- Size the label to fit the text in it
			
			
			
			function VehicleFrameButton:DoClick() -- Defines what should happen when the label is clicked
			
				net.Start( "spawnVehicle" )
				net.WriteString( v['car_model'] ) 
				net.WriteString( v['car_script'] ) 
				net.WriteString( v['plate_num'] ) 
				net.WriteString( v['car_name'] ) 
				
				net.SendToServer()
				print("I was clicked! "..k)
				VehicleFrame:Close()
			end		
	
	end
	
		alreadyOpened = true
		
		timer.Simple( 1, function() alreadyOpened = false end )
		
		
	
	end--

	
	

end)

net.Receive( "platePos", function( len, ply )

carEntity = net.ReadString()

print("SPAWNED VEHICLES")
spawnedVehicles = net.ReadTable()

PrintTable(spawnedVehicles)


backForward = tonumber(net.ReadString())

backRight = tonumber(net.ReadString())

backUp = tonumber(net.ReadString())

plateX = tonumber(net.ReadString())
plateY = tonumber(net.ReadString())

plateNumber = net.ReadString()

end)




hook.Add("PostDrawOpaqueRenderables", "exampawdawdawdle", function()

--timer.Simple( 0.25, function()
	if (spawnedVehicles != nil) then 
	
		for k, v in pairs(spawnedVehicles) do

		carEntity = Entity(tonumber(v['id']))--
	
			if (carEntity:IsValid()) then 
	
				local pos = carEntity:GetPos() + carEntity:GetRight() * backRight + carEntity:GetUp() * backUp + carEntity:GetForward() * backForward

				local angle = carEntity:GetAngles() + Angle(0,0,90)

				cam.Start3D2D( pos, angle, 0.1 )

					surface.SetDrawColor( 255, 255, 255, 255 )
					surface.DrawRect( 0, 0, plateX, plateY )

					draw.SimpleText( plateNumber, "VehicleSpawn", plateX / 2 , plateY / 2 , color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		
				cam.End3D2D()
	
	
	
			end
		end
	end
end)
