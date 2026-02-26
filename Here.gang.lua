local p=game.Players.LocalPlayer
local sg=game:GetService("StarterGui")
local cas=game:GetService("ContextActionService")
local uis=game:GetService("UserInputService")
local cam=workspace.CurrentCamera

-- GUI
local g=Instance.new("ScreenGui",p.PlayerGui)
g.ResetOnSpawn=false
g.IgnoreGuiInset=true

local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,420,0,200)
f.Position=UDim2.new(.5,-210,.5,-100)
f.BackgroundColor3=Color3.fromRGB(10,10,10)
Instance.new("UICorner",f).CornerRadius=UDim.new(0,25)
Instance.new("UIStroke",f).Color=Color3.fromRGB(170,0,255)

local t=Instance.new("TextLabel",f)
t.Size=UDim2.new(1,0,.4,0)
t.BackgroundTransparency=1
t.Text="Brainrot Lagger"
t.Font=Enum.Font.Arcade
t.TextScaled=true
t.TextColor3=Color3.fromRGB(100,150,255)

local b=Instance.new("TextButton",f)
b.Size=UDim2.new(.6,0,.4,0)
b.Position=UDim2.new(.2,0,.5,0)
b.Text="Lag"
b.Font=Enum.Font.Arcade
b.TextScaled=true
b.BackgroundColor3=Color3.fromRGB(40,40,40)
Instance.new("UICorner",b).CornerRadius=UDim.new(0,20)

-- Drag
f.Active=true
f.Draggable=true

-- Freeze
b.MouseButton1Click:Connect(function()
	f.Visible=false
	
	pcall(function()
		sg:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
		sg:SetCore("ResetButtonCallback",false)
	end)

	cam.CameraType=Enum.CameraType.Scriptable
	local cf=cam.CFrame
	
	cas:BindAction("F",function()
		return Enum.ContextActionResult.Sink
	end,false,unpack(Enum.PlayerActions:GetEnumItems()))
	
	if p.Character and p.Character:FindFirstChild("Humanoid") then
		p.Character.Humanoid.WalkSpeed=0
		p.Character.Humanoid.JumpPower=0
	end
	
	local black=Instance.new("Frame",g)
	black.Size=UDim2.new(1,0,1,0)
	black.BackgroundColor3=Color3.new(0,0,0)
	
	local txt=Instance.new("TextLabel",black)
	txt.Size=UDim2.new(1,0,1,0)
	txt.BackgroundTransparency=1
	txt.Text="GET SCAMMED AHH"
	txt.TextColor3=Color3.fromRGB(255,0,0)
	txt.Font=Enum.Font.Arcade
	txt.TextScaled=true
	
	while true do
		cam.CFrame=cf
		task.wait()
	end
end)
