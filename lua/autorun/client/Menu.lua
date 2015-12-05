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
	weaponModel:AddChoise("one", {})
	weaponModel:AddChoise("two", {})
	weaponModel:AddChoise("three", {})
	--weaponModel.DataChanged = function(self, data)
		--print("You Selected: ", data)
	end
	
concommand.Add("weaponMenu", openMenu) 