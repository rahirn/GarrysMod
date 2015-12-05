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
	local allWeapons = weapons.GetList()
	for key,value in pairs(allWeapons) do
		weaponModel:AddChoice(value["ViewModel"], {value["ViewModel"], value["WorldModel"]})
	end
	weaponModel.DataChanged = function(self, data)
		print("You Selected: \n" .. data[1] .. "\n" .. data[2])
	end
	
	end 
	
concommand.Add("weaponMenu", openMenu) 