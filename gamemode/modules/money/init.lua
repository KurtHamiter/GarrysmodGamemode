util.AddNetworkString( "moneyUpdate" )

hook.Add("PlayerSay", "moneyCommand", function( ply, text )
	
	local moneyDropCommand = string.Split( text, " " )
	
	if (moneyDropCommand[1] == "/dropmoney") then
	
		if (isnumber(tonumber(moneyDropCommand[2]))) then
		
			money=ents.Create("money")
			money:SetModel("models/props/cs_assault/money.mdl")
			money:SetPos( ply:GetPos() + (ply:GetForward() * 50) )

			moneyAmountToInsert = moneyDropCommand[2]
			
			money:Spawn()
			
			local currentCash = sql.Query("SELECT * FROM player_info WHERE steamID = '"..ply:SteamID().."' ")[1]['money']
			local currentCash = currentCash - moneyDropCommand[2]
			
			sql.Query("UPDATE player_info SET money = "..currentCash.." WHERE steamID = '"..ply:SteamID().."' ")
			
			moneyUpdate(ply) 

			
		end
	
	end
	
end)

function moneyUpdate(ply) 

		local totalMoney = sql.Query("SELECT * FROM player_info WHERE steamID = '"..ply:SteamID().."' ")[1]['money']
		net.Start( "moneyUpdate" )
		net.WriteString( totalMoney )
		net.WriteTable( Properties )
		net.Send(ply)

end

net.Receive( "moneyUpdate", function( len, ply )

		local totalMoney = sql.Query("SELECT * FROM player_info WHERE steamID = '"..ply:SteamID().."' ")[1]['money']
		net.Start( "moneyUpdate" )
		net.WriteString( totalMoney )
		net.Send(ply)
		
end )


