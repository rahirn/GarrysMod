function openMenu()
	local menuFrame = vgui.Create("DFrame")
	menuFrame:SetSize(ScrW() * .8, ScrH() * .8)
	menuFrame:Center()
	menuFrame:SetTitle("Select Your Weapons Settings")
	menuFrame:SetDraggable(false)
	menuFrame:SetSizable(false)
	menuFrame:ShowCloseButton(true)
	menuFrame:MakePopup()
	
	local panel = vgui.Create("DProperties", menuFrame)
	panel:Dock(FILL)
	
	local weaponModel = panel:CreateRow("Weapon", "Model")
	weaponModel:Setup("Combo", {text = "Select Weapon Model..."})
	weaponModel:AddChoice("one", {})
	weaponModel:AddChoice("two", {})
	weaponModel:AddChoice("three", {})
	weaponModel.DataChanged = function(self, data)
		print("You Selected: ", data)
	end
	
	
	local weaponModel = panel:CreateRow("Ammo", "Model")
	weaponModel:Setup("Combo", {text = "Select Ammo Model..."})
	weaponModel:AddChoice("first", {})
	weaponModel:AddChoice("second", {})
	weaponModel:AddChoice("third", {})
	weaponModel.DataChanged = function(self, data)
		print("You Selected: ", data)
	end
	
	
	end
	
concommand.Add("weaponMenu", openMenu) 