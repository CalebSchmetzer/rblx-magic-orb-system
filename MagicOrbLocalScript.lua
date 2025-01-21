local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local rs = game:GetService("ReplicatedStorage")
local magicOrbEvent = rs:WaitForChild("MagicOrbRE")

local orbSpeed = 50 -- Speed of the orb
local cooldownTime = 3 -- Cooldown time for the orb to limit how often players can cast it
local lastFireTime = 0 -- Tracks the last time the orb was fired

local mouseButtonDownConnection -- Holds mouse button connection

tool.Equipped:Connect(function()
	-- Create a new connection when the tool is equipped
	mouseButtonDownConnection = mouse.Button1Down:Connect(function()
		local currentTime = tick() -- Get the current time
		if currentTime - lastFireTime >= cooldownTime then
			lastFireTime = currentTime -- Update the last fire time
			magicOrbEvent:FireServer(mouse.Hit.p, orbSpeed)
		end
	end)
end)

tool.Unequipped:Connect(function()
	-- Disconnect the mouse button event when the tool is unequipped. Prevents the orb from being cast when the player isn't using the power.
	if mouseButtonDownConnection then
		mouseButtonDownConnection:Disconnect()
		mouseButtonDownConnection = nil 
	end
end)
