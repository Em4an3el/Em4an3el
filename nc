local noclip = false
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local uis = game:GetService("UserInputService")
local keybinder = script.Parent
local timespressed = 0

keybinder.MouseButton1Click:Connect(function()
	timespressed = 0
	keybinder.Text = "..."
    local input = uis.InputBegan:Wait()
	keybinder.Text = string.split(tostring(input.KeyCode), ".")[3]

	if keybinder.Text == "Unknown" then
		keybinder.Text = "N"
	end
	if syn then
		writefile("Astra Hub/noclip keybind.txt",keybinder.Text)
	end
end)

	
local function IsPushedDown()
	return uis:IsKeyDown(keybinder.Text)
end

local function Input(input, gameProcessedEvent)
	if IsPushedDown() then
		timespressed = timespressed + 1
		if timespressed > 1 then
			noclip = not noclip
		end
	end
end

uis.InputBegan:Connect(Input)
	
while true do
		player = game.Players.LocalPlayer
		character = player.Character

		if noclip then
			for _, v in pairs(character:GetDescendants()) do
				pcall(function()
				if v:IsA("BasePart") then
			
						v.CanCollide = false
					end
				end)
			end
		end

		game:GetService("RunService").Stepped:wait()
	end 
