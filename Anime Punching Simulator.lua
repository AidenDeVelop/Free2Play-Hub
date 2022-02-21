repeat wait() until game:IsLoaded()

game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

_G.Settings = {
	autoTap = false;
	autoRebirth = false;
	autoPractice = false;
	autoEgg = false;
	autoUpgrade = false;
	autoRank = false;
	autoAura = false;
	autoWorld = false;
	tripleEgg = "1";
	autoMaxElite = false;
	autoMaxDivine = false;
}

local codes = {
	"HUNTER";
	"70KFAVS";
	"45KLIKES";
	"16MVISITS";
	"HERO";
	"35KLIKES";
	"50KFAVS";
	"10MVISITS";
	"30KLIKES";
	"8MVISITS";
	"BOLINHOBLOX";
	"25KLIKES";
	"VAGNERGAMES";
	"15klikes";
	"4MVisits";
	"2MVISITS";
	"10KLIKES";
	"5KLIKES";
	"1MVISITS";
	"MASTER";
	"500KVISITS";
	"250kvisits";
	"80KVISITS";
	"1KLIKES";
	"Release";
}

pcall(function()
	game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Error:Destroy()
	game:GetService("Players").LocalPlayer.PlayerGui.EggAnimation:Destroy()
end)

local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
local tickk = tick()
local reb = {}
local practiceArea = {}
local egg = {}

for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Rebirths.Frame:GetChildren()) do
	if v:IsA("ImageLabel") and not table.find(reb,v.Price.Text) then
		table.insert(reb,v.Price.Text)
	end
end

for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
	if v.Name == "Practice" and not table.find(practiceArea,v.Area.Value.." Boost: "..v.Boost.Value) then
		table.insert(practiceArea,v.Area.Value.." Boost: "..v.Boost.Value)
	end
end 

for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
	if v.Name == "EGG" and not table.find(egg,v.Tier.Value) then 
		table.insert(egg,v.Tier.Value)
	end
end

function noclip()
	for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("BasePart") and v.CanCollide == true then
			v.CanCollide = false
		end
	end
end

function teleport(mob)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.CFrame
end

-- Create Window & Library
local library = loadstring(game:HttpGet"https://pastebin.com/raw/CNw4eMqu")()
local Window = library:Window("Free2Play Hub", "Anime Punching Simulator", Color3.fromRGB(66, 134, 245), Enum.KeyCode.LeftControl)

-- Create Tab
local FarmingTab = Window:Tab("Farming", 6034287535)
local HeroTab = Window:Tab("Pet", 6031260792)
local ShopTab = Window:Tab("Shop", 6031265987)
local MiscTab = Window:Tab("Misc", 6031215984)

FarmingTab:Toggle("Auto Tap", "", _G.Settings.autosell, function(v)
	_G.Settings.autoTap = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoTap then break end
			game:GetService("ReplicatedStorage").Remotes.TappingEvent:FireServer()
		end
	end)
end)

FarmingTab:Dropdown("Select Rebirth Amount", reb, function(value)
	for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Rebirths.Frame:GetChildren()) do
		if v:IsA("ImageLabel") and v.Price.Text == tostring(value) then
			selectedNum = tonumber(v.Name)
		end
	end
end)

FarmingTab:Toggle("Auto Rebirth", "", _G.Settings.autosell, function(v)
	_G.Settings.autoRebirth = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoRebirth then break end
			game:GetService("ReplicatedStorage").Remotes.ClientRemote:InvokeServer("Rebirths",selectedNum)
		end
	end)
end)

FarmingTab:Dropdown("Select Practice Area", practiceArea, function(v)
	selectedArea = string.match(v,"%d+")
end)

FarmingTab:Toggle("Auto Practice", "", _G.Settings.autosell, function(v)
	_G.Settings.autoPractice = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoPractice then break end
			for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
				if v.Name == "Practice" and v.Boost.Value == tonumber(selectedArea) then
					pcall(function() 
						repeat task.wait()
							teleport(v)
							game:GetService('VirtualInputManager'):SendKeyEvent(true, "E", false, game) task.wait()
							game:GetService('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
						until not _G.Settings.autoPractice
					end)
				end
			end
		end
	end)
end)

HeroTab:Dropdown("Select Egg", egg, function(value)
	for i, v in pairs(game.Workspace.__SETTINGS.__INTERACT:GetChildren()) do
		if v.Name == "EGG" and v.Tier.Value == value then 
			selectedEgg = v
		end
	end  
end)

HeroTab:Toggle("Auto Open Egg", "", _G.Settings.autosell, function(v)
	_G.Settings.autoEgg = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoEgg then break end
			pcall(function() 
				teleport(selectedEgg)
				repeat task.wait()
					game:GetService('VirtualInputManager'):SendKeyEvent(true, "E", false, game) task.wait()
					game:GetService('VirtualInputManager'):SendKeyEvent(false, "E", false, game)
					if _G.Settings.tripleEgg == "1" then
						firesignal(game.Players.LocalPlayer.PlayerGui.Ui.CenterFrame.BuyEgg.Frame.Buy1.Button.MouseButton1Click)
					elseif _G.Settings.tripleEgg == "2" then
						firesignal(game.Players.LocalPlayer.PlayerGui.Ui.CenterFrame.BuyEgg.Frame.Buy3.Button.MouseButton1Click)
					end
				until not _G.Settings.autoEgg
			end)
		end
	end)
end)

HeroTab:Toggle("Triple Egg", "", _G.Settings.autosell, function(v)
	lulul = v

	if lulul then
		_G.Settings.tripleEgg = "2"
	else
		_G.Settings.tripleEgg = "1"
	end 
end)

HeroTab:Toggle("Auto Max Elite", "", _G.Settings.autosell, function(v)
	_G.Settings.autoMaxElite = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoMaxElite then break end
			game:GetService("ReplicatedStorage").Remotes.NPCSystem:FireServer(true, "MAXELITE")
		end
	end)
end)

HeroTab:Toggle("Auto Max Divine", "", _G.Settings.autosell, function(v)
	_G.Settings.autoMaxDivine = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoMaxElite then break end
			game:GetService("ReplicatedStorage").Remotes.NPCSystem:FireServer(true, "MAXDIVINE")
		end
	end)
end)

ShopTab:Toggle("Auto Buy Upgrade", "", _G.Settings.autosell, function(v)
	_G.Settings.autoUpgrade = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoUpgrade then break end
			for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Shop.Upgrades:GetChildren()) do
				if v:IsA("ImageLabel") then
					game:GetService("ReplicatedStorage").Remotes.ClientRemote:InvokeServer("Upgrade",tonumber(v.Name))
				end
			end
		end
	end)
end)

ShopTab:Toggle("Auto Buy Rank", "", _G.Settings.autosell, function(v)
	_G.Settings.autoUpgrade = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoUpgrade then break end
			for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Shop.Upgrades:GetChildren()) do
				if v:IsA("ImageLabel") then
					game:GetService("ReplicatedStorage").Remotes.ClientRemote:InvokeServer("Upgrade",tonumber(v.Name))
				end
			end
		end
	end)
end)

ShopTab:Toggle("Auto Buy Aura", "", _G.Settings.autosell, function(v)
	_G.Settings.autoUpgrade = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoUpgrade then break end
			for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Shop.Upgrades:GetChildren()) do
				if v:IsA("ImageLabel") then
					game:GetService("ReplicatedStorage").Remotes.ClientRemote:InvokeServer("Upgrade",tonumber(v.Name))
				end
			end
		end
	end)
end)

ShopTab:Toggle("Auto Buy World", "", _G.Settings.autosell, function(v)
	_G.Settings.autoUpgrade = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoUpgrade then break end
			for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Ui.CenterFrame.Shop.Upgrades:GetChildren()) do
				if v:IsA("ImageLabel") then
					game:GetService("ReplicatedStorage").Remotes.ClientRemote:InvokeServer("Upgrade",tonumber(v.Name))
				end
			end
		end
	end)
end)

MiscTab:Button("Claim Group Reward", "", _G.Settings.autosell, function(v)
	_G.Settings.autoClaim = v

	task.spawn(function()
		while task.wait() do
			if not _G.Settings.autoClaim then break end
			game:GetService("ReplicatedStorage").Remotes.ClientRemote:InvokeServer("GroupChest")
		end
	end)
end)

MiscTab:Button("Teleport to Second World", "", _G.Settings.autosell, function(v)
	for i, v in pairs(game.Workspace.__Map:GetChildren()) do
		if v:FindFirstChild("TouchInterest") then
			firetouchinterest(v,plr,0)
		end
	end
end)

MiscTab:Button("Redeem Codes", "", _G.Settings.autosell, function(v)
	for i, v in pairs(codes) do
		game:GetService("ReplicatedStorage").Remotes.ClientRemote:InvokeServer("Codes",v)
	end
end)

warn("Last Update: 2/8/22, 7:23 PM PST")
warn("script took ",string.format("%.0f",tick()-tickk),"seconds to load")
