SWEP.PrintName = "Chair Thrower"
SWEP.Author = "Riley Hirn"
SWEP.Insructions = "Left mouse to fire a chair!"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true
SWEP.ViewModel			= "models/weapons/v_rpg.mdl"
SWEP.WorldModel			= "models/weapons/w_rocket_launcher.mdl"
local primaryShot = "models/props_c17/doll01.mdl"
local secondaryShot = "models/props_c17/doll01.mdl"
local primarySound = Sound( "ambient/explosions/exp1.wav" )
local secondarySound = Sound( "Metal.SawBladeStick" )
local primaryfireRate = 0.1
local secondaryfireRate = 0.1
local primaryProjectileSpeed = 5000
local secondaryProjectileSpeed = 5000
local primaryshotsPerRound = 1
local secondaryshotsPerRound = 1


function setViewModel(model)
	SWEP.ViewModel = model
end

function setWorldModel(model)
	SWEP.WorldModel = model
end

function setPrimaryProjectile(model)
	primaryShot = model
end

function setPrimary(ammo, clipsize, defaultclip, automatic, proj, sound, firerate, speed, shots)
	setPrimaryAmmo(ammo or "none")
	setPrimaryClip(clipsize or -1)
	setPrimaryDefaultClip(defaultclip or -1)
	setPrimaryAutomatic(automatic)
	setPrimaryProjectile(proj or "models/props_c17/doll01.mdl")
	setPrimarySound(sound or "ambient/explosions/exp1.wav")
	setPrimaryFireRate(firerate or 0.1)
	setPrimaryProjectileSpeed(speed or 5000)
	setPrimaryShotsperRound = shots;
end

function setPrimaryAmmo(ammo)
	SWEP.Primary.Ammo = ammo
end

function setPrimaryClip(size)
	SWEP.Primary.ClipSize = size
end

function setPrimaryDefaultClip(size)
	SWEP.Primary.DefaultClip = size
end

function setPrimaryAutomatic(auto)
	SWEP.Primary.Automatic = auto
end

function setPrimarySound(sound)
	primarySound = sound
end

function setPrimaryFireRate(rate)
	primaryfireRate = rate;
end

function setPrimaryProjectileSpeed(speed)
	primaryProjectileSpeed = speed
end

function setPrimaryShotsperRound(shots)
	primaryshotsPerRound = shots
end

function setSecondary(ammo, clipsize, defaultclip, automatic, proj, sound, firerate, speed, shots)
	setSecondaryAmmo(ammo or "none")
	setSecondaryClip(clipsize or -1)
	setSecondaryDefaultClip(defaultclip or -1)
	setSecondaryAutomatic(automatic)
	setSecondaryProjectile(proj or "models/props_c17/doll01.mdl")
	setSecondarySound(sound or "ambient/explosions/exp1.wav")
	setSecondaryFireRate(firerate or 0.1)
	setSecondaryProjectileSpeed(speed or 5000)
	setSecondaryShotsperRound = shots
end

function setSecondaryAmmo(ammo)
	SWEP.Secondary.Ammo = ammo
end

function setSecondaryClip(size)
	SWEP.Secondary.ClipSize = size
end

function setSecondaryDefaultClip(size)
	SWEP.Secondary.DefaultClip = size
end

function setSecondaryAutomatic(auto)
	SWEP.Secondary.Automatic = auto
end

function setSecondaryProjectile(model)
	secondaryShot = model
end

function setSecondarySound(sound)
	secondarySound = sound
end

function setSecondaryFireRate(rate)
	secondaryfireRate = rate
end

function setSecondaryProjectileSpeed(speed)
	secondaryProjectileSpeed = speed
end

function setSecondaryShotsperRound(shots)
	secondaryshotsPerRound = shots
end

function SWEP:SecondaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + secondaryfireRate )
	self:Shoot( secondaryShot,  secondarySound, secondaryProjectileSpeed, secondaryshotsPerRound)
end


function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + primaryfireRate )
	self:Shoot( primaryShot, primarySound, primaryProjectileSpeed, primaryshotsPerRound)
end

function SWEP:Shoot( model_file, sound, speed, shots)

	self:EmitSound( sound )
	
	if ( CLIENT ) then return end
	local ent = ents.Create( "prop_physics" )
	if ( !IsValid( ent ) ) then return end

	ent:SetModel( model_file )

	ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )
	
	ent:SetAngles( self.Owner:EyeAngles())
	for i=0, i<shots, 1 do
	ent:Spawn()
	local phys = ent:GetPhysicsObject()
	if ( !IsValid( phys ) ) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 50
	
	phys:ApplyForceCenter( velocity * speed )
	
	cleanup.Add( self.Owner, "props", ent )
	undo.Create( "Thrown_Chair" )
	undo.AddEntity( ent )
	undo.SetPlayer( self.Owner )
	undo.Finish()
	end
end
local lastReload = os.time()
function SWEP:Reload()
	if os.time() < lastReload + 1 then return end
	lastReload = os.time()
	self:Shoot( "models/props_junk/watermelon01.mdl", 1)
end









