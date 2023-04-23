local stormSpinner = Instance.new("ScreenGui")
local mainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local title = Instance.new("TextLabel")
local message = Instance.new("TextLabel")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

stormSpinner.Name = "stormSpinner"
stormSpinner.Parent = game.CoreGui.RobloxGui
stormSpinner.ResetOnSpawn = false

mainFrame.Name = "mainFrame"
mainFrame.Parent = stormSpinner
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
mainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.Size = UDim2.new(0, 345, 0, 150)

UICorner.Parent = mainFrame

title.Name = "title"
title.Parent = mainFrame
title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1.000
title.BorderColor3 = Color3.fromRGB(255, 255, 255)
title.Position = UDim2.new(0.210013181, 0, 0.0905991644, 0)
title.Size = UDim2.new(0, 200, 0, 50)
title.Font = Enum.Font.SourceSans
title.Text = "<font color=\"rgb(255,0,0)\"><b>STORM</b></font> <font color=\"rgb(255,255,255)\"><b>Spinner</b></font>"
title.TextColor3 = Color3.fromRGB(0, 0, 0)
title.TextSize = 25.000
title.RichText = true

message.Name = "message"
message.Parent = mainFrame
message.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
message.BorderColor3 = Color3.fromRGB(255, 255, 255)
message.BorderSizePixel = 0
message.Position = UDim2.new(0.157839209, 0, 0.489147484, 0)
message.Size = UDim2.new(0, 235, 0, 50)
message.Font = Enum.Font.SourceSansSemibold
message.Text = "Waiting For Game"
message.TextColor3 = Color3.fromRGB(255, 255, 255)
message.TextSize = 20.000

UIAspectRatioConstraint.Parent = stormSpinner
UIAspectRatioConstraint.AspectRatio = 1.507

local function VBIPQTT_fake_script() -- mainFrame.handler 
	local script = Instance.new('LocalScript', mainFrame)

	repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("CC")
	
	function getClan()
		return game:GetService("Players").LocalPlayer.PlayerGui.CC.Main.Clan.LName.Text
	end
	
	function getSpins()
		local first = game:GetService("Players").LocalPlayer.PlayerGui.CC.Main.Clan.Spins.Text
		local second = first:split(" ");
		return tonumber(second[1])
	end
	
	function dataLoss()
		game:GetService("Players").LocalPlayer.PlayerGui.Gui.Ui.UiModule.Modules.Settings.Set:InvokeServer(1, "\255")
	end
	
	function spinClan()
		game:GetService("ReplicatedStorage").Events.GetStats:InvokeServer({["Stat"] = "Spins"})
		game:GetService("Players").LocalPlayer.PlayerGui.CC.Main.Clan.RRLastName.LocalScript.RR:InvokeServer("RRLastName")
	end
	
	if table.find(storm_spinner.desired_clans, getClan()) then
		script.Parent.message.Text = "You already have a desired clan."
		task.wait(3)
		script.Parent.Parent:Destroy()
		return
	end
	
	if getSpins() <= 0 then
		script.Parent.message.Text = "You have no spins to use."
		task.wait(3)
		script.Parent.Parent:Destroy()
		return
	end
	
	script.Parent.message.Text = "Spinning."
	
	for count = 0, getSpins() do
		spinClan()
		
		if table.find(storm_spinner.desired_clans, getClan()) then
			
			script.Parent.message.Text = "You got " .. getClan() .. "!"
			task.wait(3)
			script.Parent.Parent:Destroy()
			
			break
		elseif getSpins() <= 0 then
			
			script.Parent.message.Text = "Ran out of spins, rejoining."
			task.wait(1)
			dataLoss()
			
			game:GetService('TeleportService'):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
		end
	end
end
coroutine.wrap(VBIPQTT_fake_script)()
