
function spawnWeapon(weaponData)
    --print( file.Read("WeaponBase.txt") )

	local base = [[
		SWEP.PrintName = "Custom Weapon"
		SWEP.Author = "BF, RH, JJ, TT"
		SWEP.Insructions = "Do stuff."


		function SWEP:SecondaryAttack()
			print("speed in sAttach: " .. secondaryProjectileSpeed)
			self.Weapon:SetNextPrimaryFire( CurTime() + secondaryfireRate )
			self:Shoot( secondaryShot,  secondarySound, secondaryProjectileSpeed, secondaryshotsPerRound)
		end


		function SWEP:PrimaryAttack()
			print("speed in pAttack: " .. primaryProjectileSpeed)
			self.Weapon:SetNextPrimaryFire( CurTime() + primaryfireRate )
			self:Shoot( primaryShot, primarySound, primaryProjectileSpeed, primaryshotsPerRound)
		end

		function SWEP:Shoot( model_file, sound, speed, shots)
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
	]]

    local custom = [[

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

	]]

	--file.write("test.txt", "test again")
    file.Write("../test_weapon.txt", custom .. "\n" .. base)
	--file.Write("test.txt", "TESTING")
    print(file.Read("../test_weapon.txt"))
    --print ("WROTE TO FILE:\n" .. custom .. "\n" .. base)

end

function WeaponSelectorDerma()
	local WeaponFrame = vgui.Create("DFrame")
	WeaponFrame:SetSize(650, 80)
	WeaponFrame:Center()
	WeaponFrame:SetTitle("Take the weapon that you want")
	WeaponFrame:SetDraggable(true)
	WeaponFrame:SetSizable(false)
	WeaponFrame:ShowCloseButton(true)
	WeaponFrame:MakePopup()

	local PistolButton = vgui.Create("DButton", WeaponFrame)
	PistolButton:SetSize(100, 30)
	PistolButton:SetPos(50, 35)
	PistolButton:SetText("Spawn")
	local weaponData = {}

	PistolButton.DoClick = function() spawnWeapon(weaponData) WeaponFrame:Close() end --make it run our "weapon_take" console command with "pistol" as the 1st argument and then close the menu

	local SMGButton = vgui.Create("DButton", WeaponFrame)
	SMGButton:SetSize(100, 30)
	SMGButton:SetPos(200, 35)
	SMGButton:SetText("crossbow")
	SMGButton.DoClick = function() RunConsoleCommand("doStuff", "weapon_crossbow") WeaponFrame:Close() end

	local SMGButton = vgui.Create("DButton", WeaponFrame)
	SMGButton:SetSize(100, 30)
	SMGButton:SetPos(350, 35)
	SMGButton:SetText("Change Model")
	SMGButton.DoClick = function() RunConsoleCommand("custom-setViewModel", "weapons/models/v_pistol.mdl") WeaponFrame:Close() end

	local SMGButton = vgui.Create("DButton", WeaponFrame)
	SMGButton:SetSize(100, 30)
	SMGButton:SetPos(500, 35)
	SMGButton:SetText("Shots")
	SMGButton.DoClick = function() RunConsoleCommand("custom-setPrimaryShotsperRound", 5) WeaponFrame:Close() end
end

concommand.Add("selectweapon", WeaponSelectorDerma)
