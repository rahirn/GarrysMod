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
	PistolButton:SetText("shotgun")
	PistolButton.DoClick = function() RunConsoleCommand("doStuff", "weapon_shotgun") WeaponFrame:Close() end --make it run our "weapon_take" console command with "pistol" as the 1st argument and then close the menu
	 
	local SMGButton = vgui.Create("DButton", WeaponFrame)
	SMGButton:SetSize(100, 30)
	SMGButton:SetPos(200, 35)
	SMGButton:SetText("crossbow")
	SMGButton.DoClick = function() RunConsoleCommand("doStuff", "weapon_crossbow") WeaponFrame:Close() end
	
	local SMGButton = vgui.Create("DButton", WeaponFrame)
	SMGButton:SetSize(100, 30)
	SMGButton:SetPos(350, 35)
	SMGButton:SetText("jump")
	SMGButton.DoClick = function() RunConsoleCommand("doStuff", "jump") WeaponFrame:Close() end
	
	local SMGButton = vgui.Create("DButton", WeaponFrame)
	SMGButton:SetSize(100, 30)
	SMGButton:SetPos(500, 35)
	SMGButton:SetText("reset jump")
	SMGButton.DoClick = function() RunConsoleCommand("doStuff", "reset") WeaponFrame:Close() end
end
 
concommand.Add("selectweapon", WeaponSelectorDerma)
