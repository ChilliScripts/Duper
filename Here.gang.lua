--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

--// Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "LagGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

--// Main Frame (SMALLER)
local mainFrame = Instance.new("Frame")
mainFrame.Parent = gui
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", mainFrame)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(170, 0, 255)

--// Title (SMALLER)
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Brainrot Lagger"
title.TextColor3 = Color3.fromRGB(80,120,255)
title.TextScaled = true
title.Font = Enum.Font.Arcade

--// Button (SMALLER)
local button = Instance.new("TextButton")
button.Parent = mainFrame
button.Size = UDim2.new(0, 160, 0, 55)
button.Position = UDim2.new(0.5, -80, 0.5, 20)
button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
button.Text = "Lag"
button.TextColor3 = Color3.fromRGB(100,150,255)
button.TextScaled = true
button.Font = Enum.Font.Arcade
button.BorderSizePixel = 0

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)

--// Effects
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local lagging = false
local connection

--// Fake 3 FPS Visual Lag (CLIENT ONLY)
local function fakeLag()

	if lagging then return end
	lagging = true
	button.Text = "3 FPS..."

	local fpsLimit = 1/3
	local accumulator = 0
	
	connection = RunService.RenderStepped:Connect(function(dt)
		
		accumulator += dt
		
		if accumulator >= fpsLimit then
			accumulator = 0
			
			local offset = Vector3.new(
				math.random(-4,4),
				math.random(-4,4),
				math.random(-4,4)
			) * 0.5
			
			camera.CFrame = camera.CFrame * CFrame.new(offset)
			blur.Size = math.random(20,40)
		end
	end)

	task.wait(8)
	
	if connection then
		connection:Disconnect()
	end
	
	blur.Size = 0
	button.Text = "Lag"
	lagging = false
end

button.MouseButton1Click:Connect(fakeLag)
