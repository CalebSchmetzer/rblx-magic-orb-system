local rs = game:GetService("ReplicatedStorage")
local debris = game:GetService("Debris")

local magicOrbEvent = rs:FindFirstChild("MagicOrbRE") -- Remote event to handle the orb

if not magicOrbEvent then 
	magicOrbEvent = Instance.new("RemoteEvent")
	magicOrbEvent.Name = "MagicOrbRE"
	magicOrbEvent.Parent = rs
end
	
local orbDamage = 50 -- Damage dealt by the orb
local orbSize = Vector3.new(4, 4, 4) -- Size of the orb

-- Explosion effect that will be created when the orb collides with a humanoid
local function createExplosion(position)
	local explosionPart = Instance.new("Part")
	explosionPart.Anchored = true
	explosionPart.CanCollide = false
	explosionPart.Transparency = 1
	explosionPart.Size = Vector3.new(1, 1, 1)
	explosionPart.CFrame = CFrame.new(position)
	explosionPart.Parent = workspace
	
	local explosionEmitter = Instance.new("ParticleEmitter", explosionPart)
	explosionEmitter.Texture = "rbxassetid://4770542473" -- Replace with your desired particle texture ID. This is the visual effect of the explosion particles.
	explosionEmitter.Lifetime = NumberRange.new(0.5, 1)
	explosionEmitter.Rate = 500
	explosionEmitter.Speed = NumberRange.new(5, 10)
	explosionEmitter.SpreadAngle = Vector2.new(180, 180)
	explosionEmitter.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 2),
		NumberSequenceKeypoint.new(1, 0)
	})
	explosionEmitter.Color = ColorSequence.new(Color3.fromRGB(239, 176, 255), Color3.fromRGB(182, 10, 255)) -- The color of the explosion
	explosionEmitter.LightEmission = 1 
	explosionEmitter.Enabled = true

	debris:AddItem(explosionPart, 1)

	local explosionSound = Instance.new("Sound", explosionPart)
	explosionSound.SoundId = "rbxassetid://5801257793" -- Replace with your desired Sound ID. This is the sound that will play whenever the
	explosionSound.Volume = 1
	explosionSound:Play()
end

local function createOrb(startPosition, targetPosition, speed, player)
	local orb = Instance.new("Part")
	orb.Shape = Enum.PartType.Ball
	orb.Size = orbSize
	orb.BrickColor = BrickColor.new("Royal purple") -- Color of the orb itself
	orb.Material = Enum.Material.Neon -- Material of the orb. I recommend neon as it gives it a more magical appearence. 
	orb.Transparency = 0.25
	orb.Anchored = false
	orb.CanCollide = false
	orb.CFrame = CFrame.new(startPosition) 

	local particleEmitter = Instance.new("ParticleEmitter", orb) -- Particles that are emitted around the orb while it's in motion. 
	particleEmitter.Texture = "rbxassetid://4770542473" -- Replace with your desired Texture ID. This is the visual effect of the particles.
	particleEmitter.Lifetime = NumberRange.new(0.5, 1)
	particleEmitter.Rate = 150
	particleEmitter.Speed = NumberRange.new(3, 6)
	particleEmitter.SpreadAngle = Vector2.new(10, 10)
	particleEmitter.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(1, 0)
	})
	particleEmitter.Color = ColorSequence.new(Color3.fromRGB(239, 176, 255), Color3.fromRGB(182, 10, 255)) -- Color of the particles
	particleEmitter.RotSpeed = NumberRange.new(50, 100)
	particleEmitter.LightEmission = 1

	local light = Instance.new("PointLight", orb)
	light.Color = Color3.fromRGB(182, 130, 255) -- Color of the light emitted by the orb
	light.Brightness = 8
	light.Range = 20

	local bodyVelocity = Instance.new("BodyVelocity", orb) -- Needed to propel the orb forward
	bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	bodyVelocity.Velocity = (targetPosition - startPosition).unit * speed

	orb.Parent = workspace
	game.Debris:AddItem(orb, 5)

	local castSound = Instance.new("Sound")
	castSound.SoundId = "rbxassetid://7260423115" -- Replace with your desired Sound ID. This is the sound that will play whenever the player uses the power.
	castSound.Volume = 0.5
	castSound.Parent = player
	castSound:Play()
	local debris = game:GetService("Debris")
	debris:AddItem(castSound,castSound.TimeLength)

	local hasHit = false -- Bool value to ensure players aren't hit more than once by an orb

	local function onTouch(hit)
		local humanoid = hit.Parent:FindFirstChildOfClass("Humanoid")
		local hitPlayer = game.Players:GetPlayerFromCharacter(hit.Parent)

		if humanoid and hit.Parent ~= player.Character and not hasHit then
			hasHit = true
			humanoid:TakeDamage(orbDamage)
			createExplosion(orb.Position)
			orb:Destroy()
		elseif hit.Name:find("Barrier") then -- Optional feature. Make the orb collide with any model with "Barrier" in its name. Creating barriers around your map is good for limiting the orb's power. 
			createExplosion(orb.Position)
			orb:Destroy()
		end
	end

	orb.Touched:Connect(onTouch)

	coroutine.wrap(function() 
		while orb do
			wait(0.05)
			orb.Position = orb.Position + bodyVelocity.Velocity * 0.05
		end
	end)()
end

magicOrbEvent.OnServerEvent:Connect(function(player, targetPosition, speed)
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		local startPosition = character.HumanoidRootPart.Position + Vector3.new(1, 3, 0)
		createOrb(startPosition, targetPosition, speed, player)
	end
end)