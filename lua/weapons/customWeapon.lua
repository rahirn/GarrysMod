SWEP.PrintName = "Custom Weapon"
SWEP.Author = "BF, RH, JJ, TT"
SWEP.Insructions = "Do stuff."

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

local viewModel = "models/weapons/v_rpg.mdl"
local worldModel = "models/weapons/w_rocket_launcher.mdl"
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
local scope = -1
local Zoomed = false
local primarySpread = 0
local secondarySpread = 0
local primaryDamage = 10
local secondaryDamage = 10


function setViewModel(ply, cmd, args)
	viewModel = args[1]
	ply:StripWeapon("customWeapon")
	ply:Give("customWeapon")
	---SWEP:ViewModel = "weapons/models/v_pistol.mdl"
	ply:SelectWeapon("customWeapon")
end

concommand.Add("custom-setViewModel", setViewModel)


function setScope(ply, cmd, args)
	if math.floor(args[1]) == -1 + 0.00 then
		scope = -1
	else
		scope = 76 - args[1]
	end
end

concommand.Add("custom-setScope", setScope)


function setWorldModel(ply, cmd, args)
	SWEP.WorldModel = args[1]
end

concommand.Add("custom-setWorldModel", setWorldModel)
concommand.Add("custom-setWorldModel", setWorldModel)

function setPrimaryProjectile(ply, cmd, args)
	primaryShot = args[1]
end

concommand.Add("custom-setPrimaryProjectile", setPrimaryProjectile)

function setPrimary(ammo, clipsize, defaultclip, automatic, proj, sound, firerate, speed, shots)
	setPrimaryAmmo(ammo or "none")
	setPrimaryClip(clipsize or -1)
	setPrimaryDefaultClip(defaultclip or -1)
	setPrimaryAutomatic(automatic)
	setPrimaryProjectile(proj or "models/props_c17/doll01.mdl")
	setPrimarySound(sound or "ambient/explosions/exp1.wav")
	setPrimaryFireRate(firerate or 0.1)
	setPrimaryProjectileSpeed(speed or 5000)
	setPrimaryShotsperRound(shots);
end

function setPrimaryAmmo(ply, cmd, args)
	SWEP.Primary.Ammo = args[1]
end

concommand.Add("custom-setPrimaryAmmo", setPrimaryAmmo)

function setPrimaryClip(ply, cmd, args)
	SWEP.Primary.ClipSize = args[1]
end

concommand.Add("custom-setPrimaryClip", setPrimaryClip)

function setPrimaryDefaultClip(ply, cmd, args)
	SWEP.Primary.DefaultClip = args[1]
end

concommand.Add("custom-setPrimaryDefaultClip", setPrimaryDefaultClip)

function setPrimaryDamage(ply, cmd, args)
	primaryDamage = args[1]
end
concommand.Add("custom-setPrimaryDamage", setPrimaryDamage)

function setSecondaryDamage(ply, cmd, args)
	secondaryDamage = args[1]
end
concommand.Add("custom-setSecondaryDamage", setSecondaryDamage)

function setPrimaryAutomatic(ply, cmd, args)
	SWEP.Primary.Automatic = args[1]
end

concommand.Add("custom-setPrimaryAutomatic", setPrimaryAutomatic)

function setPrimarySound(ply, cmd, args)
	primarySound = args[1]
end

concommand.Add("custom-setPrimarySound", setPrimarySound)

function setPrimaryFireRate(ply, cmd, args)
	primaryfireRate = args[1]
end

concommand.Add("custom-setPrimaryFireRate", setPrimaryFireRate)

function setPrimaryProjectileSpeed(ply, cmd, args)
	primaryProjectileSpeed = args[1]
end

concommand.Add("custom-setPrimaryProjectileSpeed", setPrimaryProjectileSpeed)

function setPrimaryShotsperRound(ply, cmd, args)
	primaryshotsPerRound = args[1]
end

concommand.Add("custom-setPrimaryShotsperRound", setPrimaryShotsperRound)

function setPrimarySpread(ply, cmd, args)
	primarySpread = args[1]
end

concommand.Add("custom-setPrimarySpread", setPrimarySpread)

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

function setSecondaryAmmo(ply, cmd, args)
	SWEP.Secondary.Ammo = args[1]
end

concommand.Add("custom-setSecondaryAmmo", setSecondaryAmmo)

function setSecondaryClip(ply, cmd, args)
	SWEP.Secondary.ClipSize = args[1]
end

concommand.Add("custom-setSecondaryClip", setSecondaryClip)

function setSecondaryDefaultClip(ply, cmd, args)
	SWEP.Secondary.DefaultClip = args[1]
end

concommand.Add("custom-setSecondaryDefaultClip", setSecondaryDefaultClip)

function setSecondaryAutomatic(ply, cmd, args)
	SWEP.Secondary.Automatic = args[1]
end

concommand.Add("custom-setSecondaryAutomatic", setSecondaryAutomatic)

function setSecondarySound(ply, cmd, args)
	SecondarySound = args[1]
end

concommand.Add("custom-setSecondarySound", setSecondarySound)

function setSecondaryFireRate(ply, cmd, args)
	SecondaryfireRate = args[1]
end

concommand.Add("custom-setSecondaryFireRate", setSecondaryFireRate)

function setSecondaryProjectileSpeed(ply, cmd, args)
	secondaryProjectileSpeed = args[1]
end

concommand.Add("custom-setSecondaryProjectileSpeed", setSecondaryProjectileSpeed)

function setSecondaryShotsperRound(ply, cmd, args)
	SecondaryshotsPerRound = args[1]
end

concommand.Add("custom-setSecondaryShotsperRound", setSecondaryShotsperRound)

function setSecondarySpread(ply, cmd, args)
	secondarySpread = args[1]
end

concommand.Add("custom-setSecondarySpread", setSecondarySpread)

function SWEP:SecondaryAttack()
	if scope == -1 then
		print("speed in sAttach: " .. secondaryProjectileSpeed)
		self.Weapon:SetNextPrimaryFire( CurTime() + secondaryfireRate )
		self:Shoot( secondaryShot,  secondarySound, secondaryProjectileSpeed, secondaryshotsPerRound, secondarySpread, secondaryDamage)
	else
		if (!Zoomed) then -- The player is not zoomed in
	 
			Zoomed = true -- Now he is
			if SERVER then
				self.Owner:SetFOV( scope, 0.3 ) -- SetFOV is serverside only
			end
		else -- If he is
	 
			Zoomed = false -- We tell the SWEP that he is not
			if SERVER then
				self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
			end
		end
	end
end


function SWEP:PrimaryAttack()
	print("speed in pAttack: " .. primaryProjectileSpeed)
	self.Weapon:SetNextPrimaryFire( CurTime() + primaryfireRate )
	self:Shoot( primaryShot, primarySound, primaryProjectileSpeed, primaryshotsPerRound, primarySpread, secondaryDamage)
end

function hit(ent, data)
	if data.HitEntity:IsPlayer() then
		data.HitEntity:TakeDamage(10, ent, data.HitEntity)
	end
end

function SWEP:Shoot( model_file, sound, speed, shots, spread)
	print("speed in Shoot: " .. speed)

	self:EmitSound( sound )

	for i=1, shots do
		if ( CLIENT ) then return end
		local ent = ents.Create( "prop_physics" )
		if ( !IsValid( ent ) ) then return end

		ent:SetModel( model_file )

		ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )

		ent:SetAngles( self.Owner:EyeAngles())

		ent:Spawn()
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		ent:AddCallback("PhysicsCollide", hit)
		local velocity = self.Owner:GetAimVector()
		local temp = Vector(math.random(-spread, spread), math.random(-spread, spread), math.random(-spread, spread))
		local temp2 = Vector(math.random(spread*2)-spread, math.random(spread*2)-spread, math.random(spread*2)-spread)
		print(temp)
		print(temp2)
		--velocity:Add(Vector(math.random(-spread, spread), math.random(-spread, spread), math.random(-spread, spread)))
		
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
