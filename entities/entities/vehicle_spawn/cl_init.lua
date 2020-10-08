include('shared.lua')
 
--[[---------------------------------------------------------
   Name: Draw
   Purpose: Draw the model in-game.
   Remember, the things you render first will be underneath!
---------------------------------------------------------]]
surface.CreateFont( "VehicleSpawn", {
	font = "Arial", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})


function ENT:Draw()

	self:DrawModel()  
	
	pos = self:GetPos() + self:GetForward() * -4 + self:GetRight() * 14 + self:GetUp() * 25

	angle = self:GetAngles()
	angle:RotateAroundAxis( angle:Up(), 90 )
	angle:RotateAroundAxis( angle:Forward(), 90 )

	cam.Start3D2D( pos, angle, 0.1 )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawRect( 0, 0, 280, 123 )

		-- Draw some text
		draw.SimpleText( "Spawn Vehicle", "VehicleSpawn", 280 / 2 , 120 / 2 , color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	cam.End3D2D()

end





 