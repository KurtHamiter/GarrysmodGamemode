local doorInfo = {}

hook.Add( "HUDPaint", "DoorInfo", function()

	for k, v in pairs(Properties) do
	
		for i=1,table.maxn(v) do 
		
			doorInfo.Entity = string.Split( tostring(v[i]), "," )

			if (tonumber(LocalPlayer():GetEyeTrace().Entity:EntIndex()) == tonumber(doorInfo.Entity[3])) then 
			
				if (LocalPlayer():GetEyeTrace().Entity:GetPos():Distance( LocalPlayer():GetPos() ) < 250 ) then 
				
					if (math.ceil(doorInfo.Entity[2]) < 1) then 
					
						doorInfo.Health = 1
						
					else 
						
						doorInfo.Health = math.ceil(doorInfo.Entity[2])
					
					end
	
					surface.SetFont( "DoorInfo" )
					local w, h = surface.GetTextSize( k )
					local w1, h1 = surface.GetTextSize(tostring("Door Health: "..math.ceil(doorInfo.Entity[2]).."%"))
					--draw.RoundedBox( 5, ScrW() / 2 - w/2 - 25, ScrH() / 2 + h/2, w + 25, 35, Color( 225, 225, 225, 0 ) )
					surface.SetTextColor( 255, 255, 255, 255 )
					surface.SetTextPos( (ScrW() / 2 - w/2 - 10), (ScrH() / 2 - 0) )
					surface.DrawText( k )
					
					local w, h = surface.GetTextSize( "Health: "..math.ceil(doorInfo.Entity[2]).."%" )
					--draw.RoundedBox( 5, ScrW() / 2 - w/2 - 25, ScrH() / 2 + h/2 + 40, w + 25, 35, Color( 225, 225, 225, 0 ) )
					surface.SetTextColor( 255, 255, 255, 255 )
					surface.SetTextPos( (ScrW() / 2 - w1/2 - 10), (ScrH() / 2 + 30) )
					surface.DrawText( "Door Health: "..doorInfo.Health.."%" )

				end
			
			end
		
		end
	
	end
	
end )

net.Receive( "updateProperties", function()

	Properties = net.ReadTable()

end)

net.Receive( "Realtor", function()

	Properties = net.ReadTable()
	
	if (net.ReadBool() == true) then 
	
		RealtorFrame:Close()
	
	end

	PrintTable(Properties)
	
	RealtorFrame = vgui.Create( "DFrame" ) -- Create a Frame to contain everything.
	RealtorFrame:SetTitle( "Realtor" )
	RealtorFrame:SetSize( 500, 300 )
	RealtorFrame:Center()
	RealtorFrame:MakePopup()
	RealtorFrame:SetMouseInputEnabled( true )

	local RealtorScroll = vgui.Create( "DScrollPanel", RealtorFrame ) -- Create the Scroll panel
	RealtorScroll:Dock( FILL )

	for k, v in pairs(Properties) do
	
		if (v['owner'] == "0") then 

			RealtorListItem = RealtorScroll:Add( "DPanel" ) -- Add DPanel to the DIconLayout
			RealtorListItem:SetSize( 94, 50 ) -- Set the size of it
			RealtorListItem:SetContentAlignment( 5 )
			RealtorListItem:SetMouseInputEnabled( true )
			RealtorListItem:Dock(TOP)
			RealtorListItem:DockMargin(2, 0, 2, 5)
			RealtorListItem:SetContentAlignment( 5 )

			local RealtorDLabel = vgui.Create( "DLabel", RealtorListItem )
			RealtorDLabel:SetPos( 13, 9 ) -- Set the position of the label
			RealtorDLabel:SetText( k ) --  Set the text of the label
			RealtorDLabel:SetDark( 1 ) 
		
			local RealtorDLabel2 = vgui.Create( "DLabel", RealtorListItem )
			RealtorDLabel2:SetPos( 13, 25 ) 
			RealtorDLabel2:SetText( "$"..v['price'] ) 
			RealtorDLabel2:SetDark( 1 ) 
			
			local RealtorButton = vgui.Create( "DButton", RealtorListItem )
			RealtorButton:SetSize( 94, 35 )
			RealtorButton:SetPos( 385, 8 ) 
			RealtorButton:SetText( "Purchase" )
			RealtorButton:SetMouseInputEnabled( true )
			
			function RealtorButton:DoClick()
			
				net.Start( "buyHouse" )
				net.WriteString( k )
				net.SendToServer()
				
			end
	
		end
	
	end

end)