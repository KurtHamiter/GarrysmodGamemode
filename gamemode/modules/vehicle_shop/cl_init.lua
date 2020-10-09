alreadyOpened = false

net.Receive( "vehicleShop", function()

	local owned_vehicles = net.ReadTable()
	
	PrintTable(owned_vehicles)
	
	print(table.maxn(owned_vehicles))--
	
	local Vehicles = net.ReadTable()
	
	if (alreadyOpened == false) then
	
	VehicleFrame = vgui.Create( "DFrame" ) -- Create a Frame to contain everything.
	VehicleFrame:SetTitle( "Car Shop" )
	VehicleFrame:SetSize( 500, 300 )
	VehicleFrame:Center()
	VehicleFrame:MakePopup()
	VehicleFrame:SetMouseInputEnabled( true )

	local RealtorScroll = vgui.Create( "DScrollPanel", VehicleFrame ) -- Create the Scroll panel
	RealtorScroll:Dock( FILL )

	for k, v in pairs(Vehicles) do
	
			local continueLoop = true
			
			for i=1,table.maxn(owned_vehicles) do 
			
				if (tostring(owned_vehicles[i]['car_name']) == tostring(k)) then
				
					continueLoop = false
				
				end
			
			end
			
			if (continueLoop == true) then 

			VehicleFrameListItem = RealtorScroll:Add( "DPanel" ) -- Add DPanel to the DIconLayout
			VehicleFrameListItem:SetSize( 500, 50 ) -- Set the size of it
			VehicleFrameListItem:SetContentAlignment( 1 )
			VehicleFrameListItem:SetMouseInputEnabled( true )
			VehicleFrameListItem:Dock(TOP)
			VehicleFrameListItem:DockMargin(2, 0, 2, 5)
			VehicleFrameListItem:SetContentAlignment( 5 )
	
	
			local VehicleFrameLabel = vgui.Create( "DLabel", VehicleFrameListItem )
			VehicleFrameLabel:SetPos( 13, 9 ) -- Set the position of the label
			VehicleFrameLabel:SetText( k ) --  Set the text of the label
			VehicleFrameLabel:SizeToContents() -- Size the label to fit the text in it
			VehicleFrameLabel:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
			
			local VehicleFrameLabel2 = vgui.Create( "DLabel", VehicleFrameListItem )
			VehicleFrameLabel2:SetPos( 13, 25 ) -- Set the position of the label
			VehicleFrameLabel2:SetText( "$"..v['Price'] ) --  Set the text of the label
			VehicleFrameLabel2:SizeToContents() -- Size the label to fit the text in it
			VehicleFrameLabel2:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
			
			local VehicleFrameButton = vgui.Create( "DButton", VehicleFrameListItem )
			VehicleFrameButton:SetSize( 94, 35 )
			VehicleFrameButton:SetPos( 385, 8 ) -- Set the position of the label
			VehicleFrameButton:SetText( "Purchase" )
			VehicleFrameButton:SetMouseInputEnabled( true )
			--DLabel:SizeToContents() -- Size the label to fit the text in it
			
			
			
			function VehicleFrameButton:DoClick() -- Defines what should happen when the label is clicked
			
				net.Start( "buyVehicle" )
				net.WriteString( k ) 
				net.WriteString( v['Model'] ) 
				net.WriteString( v['Script'] ) 
				net.SendToServer()
				print("I was clicked! "..k)
				
				VehicleFrame:Close()
				
			end
			
		end
	
	end
	
		alreadyOpened = true
		
		timer.Simple( 1, function() alreadyOpened = false end )
		
		
	
	end

end)