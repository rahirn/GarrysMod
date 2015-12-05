function optionSelected(option, selection)
	if     option == "worldModel" then
		print("setWorldModel", selection)
		RunConsoleCommand("custom-setWorldModel", selection)
	elseif option == "viewModel" then
		print("setViewModel", selection)
		RunConsoleCommand("custom-setViewModel", selection)
	elseif option == "scope" then
		print("", selection)
		RunConsoleCommand("custom-", selection)--$$
	elseif option == "clip" then
		print("setPrimaryDefaultClip", selection)
		RunConsoleCommand("custom-setPrimaryDefaultClip", selection)
	elseif option == "pAuto" then
		print("setPrimaryAutomatic", selection)
		RunConsoleCommand("custom-setPrimaryAutomatic", selection)
	elseif option == "pFire" then
		print("setPrimaryFireRate", selection)
		RunConsoleCommand("custom-setPrimaryFireRate", selection)--$$
	elseif option == "pSpeed" then
		print("setPrimaryProjectileSpeed", selection)
		RunConsoleCommand("custom-setPrimaryProjectileSpeed", selection)
	elseif option == "pSound" then
		print("setPrimarySound", selection)
		RunConsoleCommand("custom-setPrimarySound", selection)
	elseif option == "pDamage" then
		print("", selection)
		RunConsoleCommand("custom-", selection)--$$
	elseif option == "pSpread" then
		print("", selection)
	RunConsoleCommand("custom-", selection)--$$
	elseif option == "pRounds" then
		print("setPrimaryShotsperRound", selection)
		RunConsoleCommand("custom-setPrimaryShotsperRound", selection)
	elseif option == "sAuto" then
		print("setSecondaryAutomatic", selection)
		RunConsoleCommand("custom-setSecondaryAutomatic", selection)
	elseif option == "sFire" then
		print("setSecondaryFireRate", selection)
		RunConsoleCommand("custom-setSecondaryFireRate", selection)
	elseif option == "sSpeed" then
		print("setSecondaryProjectileSpeed", selection)
		RunConsoleCommand("custom-setSecondaryProjectileSpeed", selection)
	elseif option == "sSound" then
		print("setSecondarySound", selection)
		RunConsoleCommand("custom-setSecondarySound", selection)
	elseif option == "sDamage" then
		print("", selection)
		RunConsoleCommand("custom-", selection)--$$
	elseif option == "sSpread" then
		print("", selection)
		RunConsoleCommand("custom-", selection)--$$
	elseif option == "sRounds" then
		print("setSecondaryShotsperRound", selection)
		RunConsoleCommand("custom-setSecondaryShotsperRound", selection)
	end
end

function openMenu()
	local WIDTH = .6
	local HEIGHT = .8
	
	local menuFrame = vgui.Create("DFrame")
	menuFrame:SetSize(ScrW() * WIDTH, ScrH() * HEIGHT)
	menuFrame:Center()
	menuFrame:SetTitle("Select Your Weapons Settings")
	menuFrame:SetDraggable(false)
	menuFrame:SetSizable(false)
	menuFrame:ShowCloseButton(true)
	menuFrame:MakePopup()
	
	local topPanel = vgui.Create("DPanel", menuFrame)
	topPanel:SetPos(0, 25)
	topPanel:SetSize(ScrW() * WIDTH, ScrH() * HEIGHT * .25)
	
	local botLeftPanel = vgui.Create("DPanel", menuFrame)
	botLeftPanel:SetPos(0, 30 + (ScrH() * HEIGHT * .25))
	botLeftPanel:SetSize((ScrW() * WIDTH * .5) - 2, ((ScrH() * HEIGHT) * .75) - 30)
	
	local botRightPanel = vgui.Create("DPanel", menuFrame)
	botRightPanel:SetPos((ScrW() * WIDTH * .5) + 3, 30 + (ScrH() * HEIGHT * .25))
	botRightPanel:SetSize((ScrW() * WIDTH * .5) - 3, ((ScrH() * HEIGHT) * .75) - 30)
	
	local topProperties = vgui.Create("DProperties", topPanel)
	topProperties:Dock(FILL)
	local botLeftProperties = vgui.Create("DProperties", botLeftPanel)
	botLeftProperties:Dock(FILL)
	local botRightProperties = vgui.Create("DProperties", botRightPanel)
	botRightProperties:Dock(FILL)
	
	--World Model------------------------------------------------
	local weaponModel = topProperties:CreateRow("Weapon", "World Model")
	weaponModel:Setup("Combo", {text = "Select Weapon Model..."})
	local options = weapons.GetList()
	for key,value in pairs(options) do
		if value["WorldModel"] != "" then
			weaponModel:AddChoice(value["WorldModel"], {value["WorldModel"]})
		end
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("worldModel", data[1])
	end
	-------------------------------------------------------------
	
	--View Model-------------------------------------------------
	local weaponModel = topProperties:CreateRow("Weapon", "View Model")
	weaponModel:Setup("Combo", {text = "Select Weapon Model..."})
	local options = weapons.GetList()
	for key,value in pairs(options) do
		weaponModel:AddChoice(value["ViewModel"], {value["ViewModel"]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("viewModel", data[1])
	end
	-------------------------------------------------------------
	
	--Scopes-----------------------------------------------------
	local weaponModel = topProperties:CreateRow("Weapon", "Scope")
	weaponModel:Setup("Combo", {text = "Select Scope..."})
	local options = weapons.GetList() --TODO: ad table of all scopes
	for key,value in pairs(options) do
		weaponModel:AddChoice(value["ViewModel"], {value["ViewModel"]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("scope", data[1])
	end
	-------------------------------------------------------------
	
	--END OF TOP PANEL===========================================
	
	--Primary Auto-----------------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Automatic")
	weaponModel:Setup("Combo", {text = "Select Automatic..."})
	weaponModel:AddChoice("Yes", {"YES"})
	weaponModel:AddChoice("No", {"NO"})
	weaponModel.DataChanged = function(self, data)
		optionSelected("pAuto", data[1])
	end
	-------------------------------------------------------------
	
	--Primary Fire Rate------------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Fire Rate")
	weaponModel:Setup("Combo", {text = "Select Fire Rate..."})
	local options = {.1, .2, .5, 1}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("pFire", data[1])
	end
	-------------------------------------------------------------
	
	--Primary Speed----------------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Projectile Speed")
	weaponModel:Setup("Combo", {text = "Select Projectile Speed..."})
	local options = {1, 20, 50, 100, 250, 500, 2000}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("pSpeed", data[1])
	end
	-------------------------------------------------------------
	
	--Primary Sound----------------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Sound")
	weaponModel:Setup("Combo", {text = "Select Sound..."})
	local options = weapons.GetList() --TODO: ad table of all sounds
	for key,value in pairs(options) do
		weaponModel:AddChoice(value["ViewModel"], {value["ViewModel"]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("pSound", data[1])
	end
	-------------------------------------------------------------
	
	--Primary Damage---------------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Projectile Damage")
	weaponModel:Setup("Combo", {text = "Select Projectile Damage..."})
	local options = {1, 5, 10, 20, 50, 100}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("pDamage", data[1])
	end
	-------------------------------------------------------------
	
	--Primary Spread---------------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Projectile Spread")
	weaponModel:Setup("Combo", {text = "Select Projectile Spread..."})
	local options = {1, 2, 3}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("pSpread", data[1])
	end
	-------------------------------------------------------------
	
	--Projectiles per Round--------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Projectiles per Round")
	weaponModel:Setup("Combo", {text = "Select Projectiles per Round..."})
	local options = {1, 2, 3, 5, 10}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("pRounds", data[1])
	end
	-------------------------------------------------------------
	
	--Clip Size--------------------------------------------------
	local weaponModel = botLeftProperties:CreateRow("Primary Weapon", "Clip Size")
	weaponModel:Setup("Combo", {text = "Select Clip Size..."})
	local options = {1, 2, 3}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("clip", data[1])
	end
	-------------------------------------------------------------
	
	--END OF BOTTOM LEFT PANEL===================================
	
	--Secondary Auto-----------------------------------------------
	local weaponModel = botRightProperties:CreateRow("Secondary Weapon", "Automatic")
	weaponModel:Setup("Combo", {text = "Select Automatic..."})
	weaponModel:AddChoice("Yes", {"YES"})
	weaponModel:AddChoice("No", {"NO"})
	weaponModel.DataChanged = function(self, data)
		optionSelected("sAuto", data[1])
	end
	-------------------------------------------------------------
	
	--Secondary Fire Rate----------------------------------------
	local weaponModel = botRightProperties:CreateRow("Secondary Weapon", "Fire Rate")
	weaponModel:Setup("Combo", {text = "Select Fire Rate..."})
	local options = {.1, .2, .5, 1}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("sFire", data[1])
	end
	-------------------------------------------------------------
	
	--Secondary Speed--------------------------------------------
	local weaponModel = botRightProperties:CreateRow("Secondary Weapon", "Projectile Speed")
	weaponModel:Setup("Combo", {text = "Select Projectile Speed..."})
	local options = {1, 20, 50, 100, 250, 500, 2000}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("sSpeed", data[1])
	end
	-------------------------------------------------------------
	
	--Secondary Sound--------------------------------------------
	local weaponModel = botRightProperties:CreateRow("Secondary Weapon", "Sound")
	weaponModel:Setup("Combo", {text = "Select Sound..."})
	local options = weapons.GetList() --TODO: ad table of all sounds
	for key,value in pairs(options) do
		weaponModel:AddChoice(value["ViewModel"], {value["ViewModel"]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("sSound", data[1])
	end
	-------------------------------------------------------------
	
	--Secondary Damage-------------------------------------------
	local weaponModel = botRightProperties:CreateRow("Secondary Weapon", "Projectile Damage")
	weaponModel:Setup("Combo", {text = "Select Projectile Damage..."})
	local options = {1, 5, 10, 20, 50, 100}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("sDamage", data[1])
	end
	-------------------------------------------------------------
	
	--Secondary Spread-------------------------------------------
	local weaponModel = botRightProperties:CreateRow("Secondary Weapon", "Projectile Spread")
	weaponModel:Setup("Combo", {text = "Select Projectile Spread..."})
	local options = {1, 2, 3}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("sSpread", data[1])
	end
	-------------------------------------------------------------
	
	--Secondary Projectiles per Round----------------------------
	local weaponModel = botRightProperties:CreateRow("Secondary Weapon", "Projectiles per Round")
	weaponModel:Setup("Combo", {text = "Select Projectiles per Round..."})
	local options = {1, 2, 3, 5, 10}
	for i, v in pairs(options) do
		weaponModel:AddChoice(options[i], {options[i]})
	end
	weaponModel.DataChanged = function(self, data)
		optionSelected("sRounds", data[1])
	end
	-------------------------------------------------------------
	
	
	end
concommand.Add("weaponMenu", openMenu) 




















