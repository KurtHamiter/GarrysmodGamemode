weedInfo = {}

net.Receive( "sendWeed", function()
	
    weedInfo = net.ReadTable();
	
end )   

hook.Add("HUDPaint", "HelloThereawdawdawd", function() 

	if (weedInfo != nil) then 
	
		for k, v in pairs(weedInfo) do
 
				if (tostring(LocalPlayer():GetEyeTrace().Entity) == tostring(k)) then
				
				if (tostring(LocalPlayer():GetEyeTrace().Entity) != "Entity [0][worldspawn]") then 
	
					if (v['beenPlanted'] == true) then

						draw.DrawText(math.floor((v['growTime'] / 100) * 100) .. "%", "TargetID", ScrW() / 2, ScrH() / 2 - 10, Color(255,255,255,255), TEXT_ALIGN_CENTER)
					
				end
		
				end
			end

		end

	end

end)







	
	