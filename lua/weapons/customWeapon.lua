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

SWEP.ViewModel				= Model( "models/weapons/c_arms.mdl" )
SWEP.WorldModel				= ""
SWEP.ViewModelFOV			= 54
SWEP.UseHands				= true

local vars = {}
vars["pShot"] = "models/props_c17/doll01.mdl"
vars["sShot"] = "models/props_c17/doll01.mdl"
vars["pSound"] = Sound( "ambient/explosions/exp1.wav" )
vars["sSound"] = Sound( "Metal.SawBladeStick" )
vars["pFireRate"] = 0.1
vars["sFireRate"] = 0.1
vars["pSpeed"] = 5000
vars["sSpeed"] = 5000
vars["pShotsPerRound"] = 1
vars["sShotsPerRound"] = 1
vars["scope"] = -1
vars["zoomed"] = false
vars["pSpread"] = 0
vars["sSpread"] = 0
vars["pDamage"] = 10
vars["sDamage"] = 10




function SWEP:Initialize()
	self:SetHoldType( "fist" )
end

function setVars1(ply, cmd, args) 
	print(args[1] .. ":  " .. args[2])
	if args[1] == "pAuto" then
		SWEP.Primary.Automatic = args[2]
	elseif args[1] == "sAuto" then
		SWEP.Secondary.Automatic = args[2]
	end
	print(vars["zoomed"])
			
	vars[args[1]] = args[2]
end
concommand.Add("setVars", setVars1)


function SWEP:SecondaryAttack()
	print(vars["scope"])
	if tonumber(vars["scope"]) == -1 then
		local anim = "fists_right"
		self.Owner:SetFOV( 0, 0.1 )

		local vm = self.Owner:GetViewModel()
		vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

		self.Weapon:SetNextPrimaryFire( CurTime() + vars["sFireRate"] )
		self:Shoot("s")
	else
		if (!vars["zoomed"]) then -- The player is not zoomed in
			vars["zoomed"] = true -- Now he is
			if SERVER then
				self.Owner:SetFOV( 75 - vars["scope"], 0.3 ) -- SetFOV is serverside only
			end
		else -- If he is
			vars["zoomed"] = false -- We tell the SWEP that he is not
			if SERVER then
				self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
			end
		end
	end
end


function SWEP:PrimaryAttack()
	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local anim = "fists_left"
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( anim ) )

	self.Weapon:SetNextPrimaryFire( CurTime() + vars["pFireRate"] )
	self:Shoot("p")
end

function hit(ent, data)
	if data.HitEntity:IsPlayer() then
		data.HitEntity:TakeDamage(10, ent, data.HitEntity)
	end
end

function delete(ent)
	ent:Remove()
end


function SWEP:Shoot(t)
	self:EmitSound(vars[t .. "Sound"])

	for i=1, vars[t .. "ShotsPerRound"] do
		if ( CLIENT ) then return end
		local ent = ents.Create( "prop_physics" )
		if ( !IsValid( ent ) ) then return end

		ent:SetModel( vars[t .. "Shot"] )

		ent:SetPos( self.Owner:EyePos() + ( self.Owner:GetAimVector() * 16 ) )

		ent:SetAngles( self.Owner:EyeAngles())

		ent:Spawn()
		local phys = ent:GetPhysicsObject()
		if ( !IsValid( phys ) ) then ent:Remove() return end
		ent:AddCallback("PhysicsCollide", hit)
		local velocity = self.Owner:GetAimVector()

		spread = vars[t .. "Spread"] * .01
		velocity:Add(Vector(math.random(-spread, spread), math.random(-spread, spread), math.random(-spread, spread)))

		velocity = velocity * 50
		phys:ApplyForceCenter( velocity * vars[t .. "Speed"] )

		timer.Create("delete" .. math.random(1, 100000), 10, 1, function() delete(ent) end)

		cleanup.Add( self.Owner, "props", ent )
		undo.Create( "Projectile" )
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


function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "fists_draw" ) )
	return true
end
