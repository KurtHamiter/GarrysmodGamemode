hook.Add("PlayerSay", "methCommand", function( ply, text )
	
	PlayerCommand = string.Split( text, " " )
	
	if (PlayerCommand[1] == "/dropmeth") then

			meth=ents.Create("meth_tray")
			meth:SetModel("models/props/cs_militia/reload_bullet_tray.mdl")
			meth:SetPos( ply:GetPos() + (ply:GetForward() * 50  + Vector(0, 0, 23) ))
			meth:SetMaterial( "debug/debugwhite" )

			meth:Spawn()

	end
	
end)


