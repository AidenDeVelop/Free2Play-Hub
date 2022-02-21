repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local isTriple = "Single"

function GetNearestEgg()
	local nearr = math.huge
	local near
	local plr = Player.Character.HumanoidRootPart

	for i, v in pairs(game:GetService("Workspace").Scripts.Eggs:GetChildren()) do
		if (plr.CFrame.p - v.Egg.Egg.CFrame.p).Magnitude < nearr then
			near = v.Name
			nearr = (plr.CFrame.p - v.Egg.Egg.CFrame.p).Magnitude
		end
	end
	return near
end

for i, v in pairs(Player.Passes:GetChildren()) do
	v.Value = true
end

-- Create Window & Library
local library = loadstring(game:HttpGet"https://pastebin.com/raw/CNw4eMqu")()
local Window = library:Window("Free2Play Hub", "Rebirth Champion X", Color3.fromRGB(66, 134, 245), Enum.KeyCode.LeftControl)

-- Create Tab
local FarmingTab = Window:Tab("Farming", 6034287535)
local PetTab = Window:Tab("Pet", 6031260792)
local ShopTab = Window:Tab("Shop", 6031265987)
local MiscTab = Window:Tab("Misc", 6031215984)

FarmingTab:Toggle("Auto Click", "", _G.autoClick, function(v)
	_G.autoclick = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoclick then break end
			ReplicatedStorage.Events.Click:FireServer()
		end
	end)
end)

FarmingTab:Button("Unlock All Gamepass", "", _G.unlockGamepass, function(v)
	for i, v in pairs(Player.Passes:GetChildren()) do
		v.Value = true
	end
end)

PetTab:Toggle("Open Nearest Egg", "", _G.autoEgg, function(v)
	_G.autoegg = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoegg then break end    
			local eggy = GetNearestEgg() 
			ReplicatedStorage.Functions.Unbox:InvokeServer(eggy,isTriple)
		end
	end)
end)

PetTab:Toggle("Triple Egg", "", _G.autoOpenTripleEgg, function(v)
	asd = a

	if asd then
		isTriple = "Triple"
	else
		isTriple = "Single"
	end
end)

PetTab:Toggle("Equip Best", "", _G.autoBest, function(v)
	_G.autobest = v

	task.spawn(function()
		while task.wait(10) do
			if not _G.autobest then break end
			firesignal(Player.PlayerGui.MainUI.PetsFrame.Additional.EquipBest.Click.MouseButton1Up)
		end
	end)
end)


PetTab:Toggle("Craft All", "", _G.autoCraft, function(v)
	_G.autocraft = v

	task.spawn(function()
		while task.wait(3) do
			if not _G.autocraft then break end
			firesignal(Player.PlayerGui.MainUI.PetsFrame.Additional.CraftAll.Click.MouseButton1Up)
		end
	end)
end)

ShopTab:Toggle("Auto Upgrade", "", _G.autoUpgrade, function(v)
	_G.autoupgrade = v

	task.spawn(function()
		while task.wait() do
			if not _G.autoupgrade then break end
			for i, v in pairs(require(ReplicatedStorage.Modules.UpgradesShop)) do
				ReplicatedStorage.Functions.Upgrade:InvokeServer(tostring(i))
			end
		end
	end)
end)

ShopTab:Toggle("Auto Buy Potion", "", _G.autoPotion, function(v)
	_G.autopotion = v

	task.spawn(function()
		while task.wait() do
			if not _G.autopotion then break end
			for i, v in pairs(require(ReplicatedStorage.Modules.Potions)) do
				ReplicatedStorage.Events.Potion:FireServer(tostring(i))
			end
		end
	end)
end)
