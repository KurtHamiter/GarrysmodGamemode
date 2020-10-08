hook.Add("PlayerSay", "stoveCommand", function( ply, text )
	
	local stoveDropCommand = string.Split( text, " " )
	
	if (stoveDropCommand[1] == "/dropstove") then

			stove=ents.Create("stove")
			stove:SetModel("models/props_c17/furniturestove001a.mdl")
			stove:SetPos( ply:GetPos() + (ply:GetForward() * 50 + Vector(0, 0, 23) ))
			
			stove:Spawn()

	end
	
end)

hook.Add("PlayerSay", "potCommand", function( ply, text )
	
	stoveDropCommand = string.Split( text, " " )
	
	if (stoveDropCommand[1] == "/droppot") then

			pot=ents.Create("empty_pot")
			pot:SetPos( ply:GetPos() + (ply:GetForward() * 50 + Vector(0, 0, 23) ))
			pot:Spawn()

	end
	
end)

hook.Add("PlayerSay", "weedCommand", function( ply, text )
	
	local weedDropCommand = string.Split( text, " " )
	
	if (weedDropCommand[1] == "/dropweed") then

			weed=ents.Create("unplanted_weed")
			weed:SetPos( ply:GetPos() + (ply:GetForward() * 50 + Vector(0, 0, 23) ))
			weed:SetModelScale( weed:GetModelScale() * .5, 0 )
			weed:Spawn()

	end
	
end)

hook.Add("PlayerSay", "npcCommand", function( ply, text )
	
	local npcDropCommand = string.Split( text, " " )
	
	if (npcDropCommand[1] == "/dropnpc") then
	

			npc=ents.Create("properties")
			npc:SetPos( Vector(-316.507416, -1953.280273, 120.894493) )
			npc:SetAngles( Angle(0,180,0) )
			npc:Spawn()

	end
	
end)




