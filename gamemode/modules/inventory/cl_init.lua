local openInv = {}

net.Receive( "openInv", function()

openInv.receive = net.ReadTable()
openInv.receiveCount = net.ReadTable()
openInv.receiveUpdate = net.ReadBool()

if (openInv.receiveUpdate == true) then 

	Frame:Close()

end

Frame = vgui.Create( "DFrame" ) -- Create a Frame to contain everything.
Frame:SetTitle( "Inventory" )
Frame:SetSize( 500, 300 )
Frame:Center()
Frame:MakePopup()
Frame:SetMouseInputEnabled( true )

local Scroll = vgui.Create( "DScrollPanel", Frame ) -- Create the Scroll panel
Scroll:Dock( FILL )

local List = vgui.Create( "DIconLayout", Scroll )
List:Dock( FILL )
List:SetSpaceY( 5 ) -- Sets the space in between the panels on the Y Axis by 5
List:SetSpaceX( 5 ) -- Sets the space in between the panels on the X Axis by 5
List:SetContentAlignment( 5 )

openInv.listItem = {}
--ListItem = {}

openInv.panelCreate = false
--panelcreated1 = false

for i = 1, 15 do -- Make a loop to create a bunch of panels inside of the DIconLayout

	openInv.panelCreate = true

	openInv.listItem[i] = List:Add( "DPanel" ) -- Add DPanel to the DIconLayout
	openInv.listItem[i]:SetSize( 94, 50 ) -- Set the size of it
	openInv.listItem[i]:SetContentAlignment( 5 )
	openInv.listItem[i]:SetMouseInputEnabled( true )
	
	
	local DLabel = vgui.Create( "DLabel", openInv.listItem[i] )
	DLabel:SetPos( 13, 10 ) -- Set the position of the label
	DLabel:SetText( openInv.receive[1][tostring(i)] ) --  Set the text of the label
	DLabel:SetContentAlignment( 5 )
	--DLabel:SizeToContents() -- Size the label to fit the text in it
	DLabel:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
	
	local DLabel2 = vgui.Create( "DLabel", openInv.listItem[i] )
	DLabel2:SetPos( 13, 25 ) -- Set the position of the label
	DLabel2:SetText( "x"..openInv.receiveCount[1][tostring(i)] ) --  Set the text of the label
	DLabel2:SetContentAlignment( 5 )
	--DLabel:SizeToContents() -- Size the label to fit the text in it
	DLabel2:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
	
	
end

end)

openInv.allowClick = true

function GM:Tick()

	if (openInv.panelCreate == true) then 

		if (input.IsMouseDown( 107 ) == true) then 

			for i = 1, 15 do
		
				if (openInv.listItem[i]:IsHovered() == true) then 
			
					if (openInv.allowClick == true) then 
						openInv.allowClick = false
						
						-- Send left click to server
						net.Start( "takeFromInv" )
						net.WriteInt( 1, 4 ) -- specify left click
						net.WriteInt( i, 5 )
						net.SendToServer()
						
						timer.Create( "my_timer", 0.5, 1, function()
							openInv.allowClick = true
						end)
						
					end
			
				end
			
			end

		end
		
		if (input.IsMouseDown( 108 ) == true) then 

			for i = 1, 15 do
		
				if (openInv.listItem[i]:IsHovered() == true) then 
			
					if (openInv.allowClick == true) then 
						openInv.allowClick = false
						-- Send right click to server
						net.Start( "takeFromInv" )
						net.WriteInt(2, 4) -- specify right click
						net.WriteInt( i, 5 )
						net.SendToServer()
						
						timer.Create( "my_timer", 0.5, 1, function()
							openInv.allowClick = true
						end)
					end
			
				end
			
			end

		end

	end		

end