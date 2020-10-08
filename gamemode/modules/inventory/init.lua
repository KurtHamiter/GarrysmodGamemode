hook.Add( "PlayerButtonDown", "InventoryPress", function( ply, key )

    if ( key == 92 ) then

		net.Start( "openInv" )
		local openInv = {}
		openInv.Lookup = sql.Query("SELECT * FROM player_inv WHERE steamID = '"..ply:SteamID().."' ")
		openInv.Count = sql.Query("SELECT * FROM player_inv_count WHERE steamID = '"..ply:SteamID().."' ")
		net.WriteTable(openInv.Lookup)
		net.WriteTable(openInv.Count)
		net.WriteBool(false)
		net.Send(ply)
		
    end
	
end )

function toInventory(objName, ply, className, entType)

	local toInventory = {}

	toInventory.Table = sql.Query("SELECT * FROM player_inv WHERE steamID = '"..ply:SteamID().."' ")
	toInventory.Insert = true
	
	for i=1,15 do 
	
		-- detect if item is already in inventory 
		
		if (toInventory.Table[1][tostring(i)] == objName) then
		
			toInventory.Insert = false
			toInventory.CountValue = tonumber(sql.Query("SELECT * FROM player_inv_count WHERE steamID = '"..ply:SteamID().."' ")[1][tostring(i)])
			toInventory.CountValue = toInventory.CountValue + 1
			sql.Query("UPDATE player_inv_count SET '"..tostring(i).."' = '"..toInventory.CountValue.."' WHERE steamID = '"..ply:SteamID().."' ")
			
			break
		
		end
		
		--
	
	end
	
	if (toInventory.Insert == true) then 
	
		for i=1,15 do 

			if (toInventory.Table[1][tostring(i)] == "0") then
		
				sql.Query("UPDATE player_inv SET '"..tostring(i).."' = '"..objName.."' WHERE steamID = '"..ply:SteamID().."' ")
				sql.Query("UPDATE player_inv_ent SET '"..tostring(i).."' = '"..className.."' WHERE steamID = '"..ply:SteamID().."' ")
				toInventory.CountValue = tonumber(sql.Query("SELECT * FROM player_inv_count WHERE steamID = '"..ply:SteamID().."' ")[1][tostring(i)])
				toInventory.CountValue = toInventory.CountValue + 1
				sql.Query("UPDATE player_inv_count SET '"..tostring(i).."' = '"..toInventory.CountValue.."' WHERE steamID = '"..ply:SteamID().."' ")
				sql.Query("UPDATE player_inv_type SET '"..tostring(i).."' = '"..entType.."' WHERE steamID = '"..ply:SteamID().."' ")
			
				break
		
			end
	
		end
	
	end

end

net.Receive( "takeFromInv", function( len, ply )

	local takeFromInv = {}
	
	takeFromInv.LeftRight = net.ReadInt(4)
	takeFromInv.Position = net.ReadInt(5)
	
	takeFromInv.All = tonumber(sql.Query("SELECT * FROM player_inv_count WHERE steamID = '"..ply:SteamID().."' ")[1][tostring(takeFromInv.Position)])
	takeFromInv.Type = sql.Query("SELECT * FROM player_inv_type WHERE steamID = '"..ply:SteamID().."' ")[1][tostring(takeFromInv.Position)]
	takeFromInv.Ent = sql.Query("SELECT * FROM player_inv_ent WHERE steamID = '"..ply:SteamID().."' ")[1][tostring(takeFromInv.Position)]
	
	if (takeFromInv.All > 0) then 
	
		if (takeFromInv.LeftRight == 1) then
			
			if (takeFromInv.Type == "equip") then
			
				sql.Query("UPDATE player_inv_count SET '"..tostring(takeFromInv.Position).."' = '"..(takeFromInv.All - 1).."' WHERE steamID = '"..ply:SteamID().."' ")
							
				if (takeFromInv.All == 1) then
		
					sql.Query("UPDATE player_inv SET '"..tostring(takeFromInv.Position).."' = '0' WHERE steamID = '"..ply:SteamID().."' ")
					sql.Query("UPDATE player_inv_ent SET '"..tostring(takeFromInv.Position).."' = '0' WHERE steamID = '"..ply:SteamID().."' ")
		
				end
				
			end
	
		end
	
		if (takeFromInv.LeftRight == 2) then
			
			sql.Query("UPDATE player_inv_count SET '"..tostring(takeFromInv.Position).."' = '"..(takeFromInv.All - 1).."' WHERE steamID = '"..ply:SteamID().."' ")
			
			takeFromInv.EntSpawn = ents.Create( takeFromInv.Ent )
			takeFromInv.EntSpawn:SetPos( ply:GetPos() + (ply:GetForward() * 50) )
			takeFromInv.EntSpawn:Spawn()
			
			if (takeFromInv.All == 1) then
		
				sql.Query("UPDATE player_inv SET '"..tostring(takeFromInv.Position).."' = '0' WHERE steamID = '"..ply:SteamID().."' ")
				sql.Query("UPDATE player_inv_ent SET '"..tostring(takeFromInv.Position).."' = '0' WHERE steamID = '"..ply:SteamID().."' ")
		
			end
	
	
		end
		
		net.Start( "openInv" )
		local openInv = {}
		openInv.Lookup = sql.Query("SELECT * FROM player_inv WHERE steamID = '"..ply:SteamID().."' ")
		openInv.Count = sql.Query("SELECT * FROM player_inv_count WHERE steamID = '"..ply:SteamID().."' ")
		net.WriteTable(openInv.Lookup)
		net.WriteTable(openInv.Count)
		net.WriteBool(true)
		net.Send(ply)
	
	end

end)

