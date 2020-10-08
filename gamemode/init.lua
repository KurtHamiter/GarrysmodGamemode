util.AddNetworkString( "Realtor" )
util.AddNetworkString( "clientInitialize" )
util.AddNetworkString( "updateProperties" )
util.AddNetworkString( "buyHouse" )
util.AddNetworkString( "TookDamage" )
util.AddNetworkString( "TakeDamage" )
util.AddNetworkString( "vehicleShop" )
util.AddNetworkString( "buyVehicle" )
util.AddNetworkString( "ownedVehicles" )
util.AddNetworkString( "spawnVehicle" )
util.AddNetworkString( "platePos" )
util.AddNetworkString( "openInv" )
util.AddNetworkString( "takeFromInv" )
util.AddNetworkString( "sendWeed" )

--
--[[---------------------------------------------------------

  Sandbox Gamemode

  This is GMod's default gamemode

-----------------------------------------------------------]]

-- These files get sent to the client

AddCSLuaFile( "cl_hints.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_notice.lua" )
AddCSLuaFile( "cl_search_models.lua" )
AddCSLuaFile( "cl_spawnmenu.lua" )
AddCSLuaFile( "cl_worldtips.lua" )
AddCSLuaFile( "persistence.lua" )
AddCSLuaFile( "player_extension.lua" )
AddCSLuaFile( "save_load.lua" )--
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "gui/IconEditor.lua" )
AddCSLuaFile( "modules/vehicle_shop/cl_init.lua" )
AddCSLuaFile( "modules/vehicle_spawn/cl_init.lua" )

include( 'shared.lua' )
include( 'commands.lua' )
include( 'player.lua' )
include( 'spawnmenu/init.lua' )
include( 'modules/money/init.lua' )
include( 'modules/inventory/init.lua' )
include( 'modules/stove/init.lua' )
include( 'modules/meth_tray/init.lua' )
include( 'modules/properties/init.lua' )
include( 'modules/vehicle_shop/init.lua' )
include( 'modules/vehicle_spawn/init.lua' )

--
-- Make BaseClass available
--
DEFINE_BASECLASS( "gamemode_base" )

--[[---------------------------------------------------------
	Name: gamemode:PlayerSpawn()
	Desc: Called when a player spawns
-----------------------------------------------------------]]
function GM:PlayerSpawn( pl, transiton )

	player_manager.SetPlayerClass( pl, "player_sandbox" )

	BaseClass.PlayerSpawn( self, pl, transiton )

end

--[[---------------------------------------------------------
	Name: gamemode:OnPhysgunFreeze( weapon, phys, ent, player )
	Desc: The physgun wants to freeze a prop
-----------------------------------------------------------]]
function GM:OnPhysgunFreeze( weapon, phys, ent, ply )

	-- Don't freeze persistent props (should already be froze)
	if ( ent:GetPersistent() ) then return false end

	BaseClass.OnPhysgunFreeze( self, weapon, phys, ent, ply )

	ply:SendHint( "PhysgunUnfreeze", 0.3 )
	ply:SuppressHint( "PhysgunFreeze" )

end

--[[---------------------------------------------------------
	Name: gamemode:OnPhysgunReload( weapon, player )
	Desc: The physgun wants to unfreeze
-----------------------------------------------------------]]
function GM:OnPhysgunReload( weapon, ply )

	local num = ply:PhysgunUnfreeze()

	if ( num > 0 ) then
		ply:SendLua( "GAMEMODE:UnfrozeObjects(" .. num .. ")" )
	end

	ply:SuppressHint( "PhysgunUnfreeze" )

end

--[[---------------------------------------------------------
	Name: gamemode:PlayerShouldTakeDamage
	Return true if this player should take damage from this attacker
	Note: This is a shared function - the client will think they can
		damage the players even though they can't. This just means the
		prediction will show blood.
-----------------------------------------------------------]]
function GM:PlayerShouldTakeDamage( ply, attacker )

	-- Global godmode, players can't be damaged in any way
	if ( cvars.Bool( "sbox_godmode", false ) ) then return false end

	-- No player vs player damage
	if ( attacker:IsValid() && attacker:IsPlayer() && ply != attacker ) then
		return cvars.Bool( "sbox_playershurtplayers", true )
	end

	-- Default, let the player be hurt
	return true

end

--[[---------------------------------------------------------
	Show the search when f1 is pressed
-----------------------------------------------------------]]
function GM:ShowHelp( ply )

	ply:SendLua( "hook.Run( 'StartSearch' )" )

end

--[[---------------------------------------------------------
	Called once on the player's first spawn
-----------------------------------------------------------]]
function GM:PlayerInitialSpawn( ply, transiton )

	BaseClass.PlayerInitialSpawn( self, ply, transiton )

end

--[[---------------------------------------------------------
	A ragdoll of an entity has been created
-----------------------------------------------------------]]
function GM:CreateEntityRagdoll( entity, ragdoll )

	-- Replace the entity with the ragdoll in cleanups etc
	undo.ReplaceEntity( entity, ragdoll )
	cleanup.ReplaceEntity( entity, ragdoll )

end

--[[---------------------------------------------------------
	Player unfroze an object
-----------------------------------------------------------]]
function GM:PlayerUnfrozeObject( ply, entity, physobject )

	local effectdata = EffectData()
	effectdata:SetOrigin( physobject:GetPos() )
	effectdata:SetEntity( entity )
	util.Effect( "phys_unfreeze", effectdata, true, true )

end

--[[---------------------------------------------------------
	Player froze an object
-----------------------------------------------------------]]
function GM:PlayerFrozeObject( ply, entity, physobject )

	if ( DisablePropCreateEffect ) then return end

	local effectdata = EffectData()
	effectdata:SetOrigin( physobject:GetPos() )
	effectdata:SetEntity( entity )
	util.Effect( "phys_freeze", effectdata, true, true )

end

--
-- Who can edit variables?
-- If you're writing prop protection or something, you'll
-- probably want to hook or override this function.
--
function GM:CanEditVariable( ent, ply, key, val, editor )

	-- Only allow admins to edit admin only variables!
	if ( editor.AdminOnly ) then
		return ply:IsAdmin()
	end

	-- This entity decides who can edit its variables
	if ( isfunction( ent.CanEditVariables ) ) then
		return ent:CanEditVariables( ply )
	end

	-- default in sandbox is.. anyone can edit anything.
	return true

end

StovePosition = {}

util.AddNetworkString( "playerDeath" )

hook.Add( "PlayerDeath", "AlertPlayerDeath", function( victim, inflictor, attacker )

	net.Start( "playerDeath" )
	net.Send(victim)
				
				
end)

hook.Add( "KeyPress", "keypress_jump_super", function( ply, key )
    if ( key == IN_JUMP ) then
        local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		
		--if IsValid( ent ) then
		
		print(ent)
		print(ent:MapCreationID())
		print(ent:GetAngles())
		print(ent:GetAngles())
		print(ent:GetAngles())
		print(ent:GetClass())
		print(tr.HitPos)
		print(ent:GetModel())
			
			
		--end
			
			
			
		
    end--
end )

--sql.Query("DROP TABLE player_info")
--sql.Query("DROP TABLE player_inv")
--sql.Query("DROP TABLE player_inv_count")
--sql.Query("DROP TABLE player_inv_ent")
--sql.Query("DROP TABLE player_inv_type")
--sql.Query("DROP TABLE owned_vehicles")
--
-- Creating a table
if (!sql.TableExists("player_info")) then

	sql.Query("CREATE TABLE player_info ( steamID TEXT , name TEXT, money NUMBER )" )
	sql.Query("CREATE TABLE player_inv ( steamID TEXT , '1' TEXT, '2' TEXT, '3' TEXT, '4' TEXT, '5' TEXT, '6' TEXT, '7' TEXT, '8' TEXT, '9' TEXT, '10' TEXT, '11' TEXT, '12' TEXT, '13' TEXT, '14' TEXT, '15' TEXT )" )
	sql.Query("CREATE TABLE player_inv_count ( steamID TEXT , '1' NUMBER, '2' NUMBER, '3' NUMBER, '4' NUMBER, '5' NUMBER, '6' NUMBER, '7' NUMBER, '8' NUMBER, '9' NUMBER, '10' NUMBER, '11' NUMBER, '12' NUMBER, '13' NUMBER, '14' NUMBER, '15' NUMBER )" )
	sql.Query("CREATE TABLE player_inv_ent ( steamID TEXT , '1' TEXT, '2' TEXT, '3' TEXT, '4' TEXT, '5' TEXT, '6' TEXT, '7' TEXT, '8' TEXT, '9' TEXT, '10' TEXT, '11' TEXT, '12' TEXT, '13' TEXT, '14' TEXT, '15' TEXT )" )
	sql.Query("CREATE TABLE player_inv_type ( steamID TEXT , '1' TEXT, '2' TEXT, '3' TEXT, '4' TEXT, '5' TEXT, '6' TEXT, '7' TEXT, '8' TEXT, '9' TEXT, '10' TEXT, '11' TEXT, '12' TEXT, '13' TEXT, '14' TEXT, '15' TEXT )" )
	sql.Query("CREATE TABLE owned_vehicles ( owner_ID TEXT , car_name TEXT, car_model TEXT, car_script TEXT, plate_num TEXT)" )
	print("Creating Table")

end

-- Printing the tables data
--

hook.Add( "PlayerInitialSpawn", "FullLoadSetup", function( ply )
 
	print("SQL INSERT")
	print(ply:SteamID())
	
	
	
	--PrintTable( sql.Query("SELECT * FROM player_info ") )
	
	if (sql.Query("SELECT * FROM player_info WHERE steamID = '"..ply:SteamID().."' ") == NIL) then
	
		print("NOT FOUND")
		sql.Query("INSERT INTO player_info( steamID , name, money ) VALUES( '"..ply:SteamID().."' , 'Gary Schnieder' , 50000 ) ")
		sql.Query("INSERT INTO player_inv( steamID , '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15' ) VALUES( '"..ply:SteamID().."' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' ) ")
		sql.Query("INSERT INTO player_inv_count( steamID , '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15' ) VALUES( '"..ply:SteamID().."' , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 ) ")
		sql.Query("INSERT INTO player_inv_ent( steamID , '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15' ) VALUES( '"..ply:SteamID().."' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' ) ")
		sql.Query("INSERT INTO player_inv_type ( steamID , '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15' ) VALUES( '"..ply:SteamID().."' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' , '0' ) ")
		PrintTable( sql.Query("SELECT * FROM player_info ") )
		PrintTable( sql.Query("SELECT * FROM player_inv ") )
		PrintTable( sql.Query("SELECT * FROM player_inv_count ") )
		PrintTable( sql.Query("SELECT * FROM player_inv_ent ") )
		
	
	else 
	
		print("FOUND HIM")
	
	end

end)

PrintTable( sql.Query("SELECT * FROM player_inv_count ") )

hook.Add( "EntityTakeDamage", "bulletDamage", function( target, dmginfo )
   
    print(target:GetName())

    if (target:IsPlayer()) then     
        if (dmginfo:IsBulletDamage()) then    
		
			dmginfo:ScaleDamage( 3.5 )
            
            net.Start( "TookDamage" )
            net.WriteEntity( target )
            net.WriteBool(dmginfo:IsBulletDamage())
            net.Send(target)
			
        end
		
		if (dmginfo:IsExplosionDamage()) then
		

			for i=1,10 do 
            
				net.Start( "TookDamage" )
				net.WriteEntity( target )
				net.WriteBool(dmginfo:IsExplosionDamage())
				net.Send(target)
				
				print(dmginfo)
			
			end
			
        end
    end
end )

hook.Add( "PlayerDeath", "GlobalDeathMessage", function( victim, inflictor, attacker )
    timer.Remove( "my_timer" )
    --timeriterate[victim:GetName()] = 0
end )

net.Receive("TakeDamage", function(len, ply)
	print("TAKE DAMAGE")
    ply:TakeDamage( 1, ply:GetName(), ply:GetActiveWeapon() )
end)


--LookupEntityInterior = {}

hook.Add( "GetFallDamage", "RealisticDamage", function( ply, speed )
    return ( speed / 8 )
end )

hook.Add("GravGunOnPickedUp", "GravPickup", GravPickup);


--end)


net.Receive( "clientInitialize", function( len, ply )
	
	moneyUpdate(ply) 

end)

