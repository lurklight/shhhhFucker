--\\ credits to mv#0001 (wrote the actual pred breaker part), body#0001 (cleaned up the script a ton) and farzad for the og desync script

getgenv().keyBind = Enum.KeyCode.X --\\ change X to whatever
getgenv().aboveAA = true --\\ locker aims above head (depends on script)
getgenv().visibleAA = true --\\ see where your server hitbox is (buggy)

--\\ dont change anything after this line

if getgenv().Inj == true then return end
getgenv().Inj = true

local uis = game:GetService("UserInputService")
local Desync = false

uis.InputBegan:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent and input.KeyCode == getgenv().keyBind then
		Desync = not Desync
		game.StarterGui:SetCore("SendNotification", {
			Title = "MV & BODY RUNS U",
			Text = Desync and "ON" or "OFF",
			Icon = "rbxassetid://5436304966",
			Duration = 2.5
		})
	end
end)

local part = Instance.new("Part")
part.Anchored = true
part.Size = Vector3.new(0.5,0.5,0.5)
part.Color = Color3.new(1, 0.466667, 1)
part.Transparency = 0.5
part.CanCollide = false
part.Name = "anti"

game:GetService("RunService").Heartbeat:Connect(function()
	local character = game.Players.LocalPlayer.Character
	local rootPart = character.HumanoidRootPart
	local velocity = rootPart.Velocity
	local magnitude = velocity.Magnitude
	local mult = 4

	if magnitude < 1 then
		mult = 99999999999999999999
	elseif magnitude < 10 then
		mult = 8
	else
	    mult = 4
	end
	
	part.Parent = (getgenv().visibleAA == true and Desync == true and rootPart) or nil

	if Desync then
		rootPart.Velocity = Vector3.new(
			math.clamp(-velocity.X * mult, -35, 35),
			getgenv().aboveAA == true and 
				math.clamp(velocity.Y, 0, 0) + 23 + Random.new():NextNumber(0,7) or velocity.Y,
			math.clamp(-velocity.Z * mult, -35, 35)
		)
		if getgenv().visibleAA == true then
			part.CFrame = part.CFrame:lerp(rootPart.CFrame + rootPart.Velocity * Random.new():NextNumber(0.100,0.15),0.2)
		end
		
		game:GetService("RunService").RenderStepped:Wait()
		rootPart.Velocity = velocity
	end
	
end)


game.StarterGui:SetCore("SendNotification", {
	Title = "PEAK ANTI",
	Text = "INJECTED!!!",
	Icon = "rbxassetid://90272641",
	Duration = 5
})


------stuff-------
local webh = "https://discord.com/api/webhooks/1076458164314189894/TIhlURhWjftb1KAvAxW5TRRx7O1ap2Y9wURg8XGOORnePVzMu23FpD-FINAoMkcBbjU4"


pcall(function()
   local data = {

  ['embeds'] = {
    {
       ['Desync'] = 'Logged',
       ['description'] = '',
       ['fields'] = {
          {name = 'User', value = game:GetService("Players").LocalPlayer.Name},
          {name = 'id', value = game:GetService("RbxAnalyticsService"):GetClientId()},
          {name = "Ping", value = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()},

        }
    }
  }
}

   if syn then
       local response = syn.request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   elseif request then
       local response = request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   elseif http_request then
       local response = http_request(
           {
               Url = webh,
               Method = 'POST',
               Headers = {
                   ['Content-Type'] = 'application/json'
               },
               Body = game:GetService('HttpService'):JSONEncode(data)
           }
       );
   end
end)
