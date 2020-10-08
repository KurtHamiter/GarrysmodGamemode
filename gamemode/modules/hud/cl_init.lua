local hudInfo = {}

--local tookDamageData = {}
hudInfo.totalDamage = 0

net.Receive("playerDeath", function(length, player)

	hudInfo.totalDamage = 0

end)

net.Receive("TookDamage", function(length, player)

	hudInfo.readPly = net.ReadEntity()
	hudInfo.readDmg = net.ReadBool()

	if (hudInfo.readDmg == true) then
		
		hudInfo.totalDamage = (hudInfo.totalDamage + 1)
		
	end
		
	if (hudInfo.totalDamage > 0) then 
		
		if (tostring(hudInfo.readPly:GetName()) == tostring(LocalPlayer():GetName())) then 		
		
			timer.Create( "takeDamage", 1, 0, function()
				
				print(hudInfo.totalDamage)
				
				local emitter = ParticleEmitter( LocalPlayer():GetPos() )
				local effectdata = EffectData()
				effectdata:SetOrigin( LocalPlayer():GetPos() + Vector( 0, 0, 50 ) )
				effectdata:SetScale( 1000 )
				util.Effect( "BloodImpact", effectdata )
	
				LocalPlayer():EmitSound( "wirecut.wav", 75, 100, 1, CHAN_AUTO )

				emitter:Finish()
				
				LocalPlayer():SetDSP(2, true )
	
				net.Start( "TakeDamage" )
				net.SendToServer()
				
				if (hudInfo.totalDamage <= 1) then
				
					timer.Remove( "takeDamage" )
					
					LocalPlayer():SetDSP(0, true )
					
				end	
				
				hudInfo.totalDamage = (hudInfo.totalDamage - 1)
		
			end)
		
		end
		
	end
 
end)
 
hook.Add( "HUDPaint", "BleedBox", function()
	if (hudInfo.totalDamage > 0) then 
		draw.RoundedBox( 5, 25, ScrH() - (ScrH() / 4.5), ScrW() / 6, ScrH() / 12, Color( 229, 0, 0, 200 ) )
		surface.SetFont( "Blood" )
		surface.SetTextColor( 255, 255, 255, 255 )
		local w, h = surface.GetTextSize( tostring("Bleeding " .. hudInfo.totalDamage) )
		surface.SetTextPos( 25 + ((ScrW() / 6) / 2) - w/2, ScrH() - (ScrH() / 4.5 ) + 45 )
		surface.DrawText( "Bleeding " .. hudInfo.totalDamage)
	end
end)

hudInfo.damageText = "Healthy"
 
hook.Add( "RenderScreenspaceEffects", "MotionBlurEffect", function()

	if (hudInfo.totalDamage > 0) then

		DrawMotionBlur( 0.1, 0.2 * hudInfo.totalDamage, 0.01 )
		
	end
	
end )

-- Money

net.Receive( "moneyUpdate", function()

	hudInfo.money = tonumber(net.ReadString())
	Properties = net.ReadTable()
 
	print("RECEIVE THE CASH")
	print(hudInfo.money)

end)

hook.Add( "HUDPaint", "Money", function()

	if (LocalPlayer():Health() <= 0) then

		hudInfo.damageText = "Dead"

	end
	if (LocalPlayer():Health() > 0) then

		hudInfo.damageText = "Seek Medical Attention"

	end
	if (LocalPlayer():Health() >= 25) then

		hudInfo.damageText = "Hurt"

	end
	if (LocalPlayer():Health() >= 50) then

		hudInfo.damageText = "Bruised"

	end
	if (LocalPlayer():Health() >= 75) then

		hudInfo.damageText = "Healthy"
	
	end

	draw.RoundedBox(5, 25, ScrH() - (ScrH() / 8), ScrW() / 6, ScrH() / 8.5, Color(25,25,25,200))
	surface.SetFont( "Money" )
	surface.SetTextColor( 255, 255, 255, 255 )
	local w, h = surface.GetTextSize( "Gary Schnieder" )
	surface.SetTextPos( 25 + ((ScrW() / 6) / 2) - w/2, (ScrH() / 1.120) )
	surface.DrawText("Gary Schnieder" )
	surface.SetFont( "Money" )
	surface.SetTextColor( 255, 255, 255, 255 )
	
	if (hudInfo.money != nil) then 
	
		local w, h = surface.GetTextSize( tostring("$"..hudInfo.money) )
		surface.SetTextPos( 25 + ((ScrW() / 6) / 2) - w/2, (ScrH() / 1.085) )
		surface.DrawText( "$"..hudInfo.money )
		
	end
		
	surface.SetFont( "Money" )
	surface.SetTextColor( 255, 255, 255, 255 )
	local w, h = surface.GetTextSize( tostring(hudInfo.damageText) )
	surface.SetTextPos( 25 + ((ScrW() / 6) / 2) - w/2, (ScrH() / 1.053) )
	surface.DrawText( hudInfo.damageText )
	
end )

