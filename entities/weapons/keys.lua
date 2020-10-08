
-- Variables that are used on both client and server

SWEP.Instructions	= "Use to lock and unlock stuff"

SWEP.Spawnable			= true
SWEP.AdminOnly			= true
SWEP.UseHands			= true

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= "models/weapons/c_arms.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.PrintName			= "Keys"
SWEP.Slot				= 1
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true
SWEP.UseHands			= true

function SWEP:Initialize()

	self:SetHoldType( "normal" )

end

--[[---------------------------------------------------------
	Reload does nothing
-----------------------------------------------------------]]
function SWEP:Reload()
end

--[[---------------------------------------------------------
	Think does nothing
-----------------------------------------------------------]]
function SWEP:Think()

	
	
	
end

--[[---------------------------------------------------------
	PrimaryAttack
-----------------------------------------------------------]]
function SWEP:PrimaryAttack()

	RunConsoleCommand( "lockUnlock", "lock" )

end

--[[---------------------------------------------------------
	SecondaryAttack
-----------------------------------------------------------]]
function SWEP:SecondaryAttack()

	RunConsoleCommand( "lockUnlock", "unlock" )

end


--[[---------------------------------------------------------
	Name: ShouldDropOnDie
	Desc: Should this weapon be dropped when its owner dies?
-----------------------------------------------------------]]
function SWEP:ShouldDropOnDie()
	return false
end
