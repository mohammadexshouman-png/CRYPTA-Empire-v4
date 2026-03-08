-- CRYPTA EMPIRE MOBILE v4.0 FIXED | Mohammadexshouman-png EDITION
-- Delta/Mobile Safe | All Seas TPs | Kavo UI Dark Theme

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

print("🚀 CRYPTA v4.0 MOBILE FIXED! Dark UI Loaded - Mohammadexshouman-png")

local Window = Library.CreateLib("📱 CRYPTA v4.0 ULTIMATE", "DarkTheme")
Window:SetBackgroundImage("rbxassetid://6403373529")
Library:SetWatermark("CRYPTA Empire | Mohammadexshouman-png | Delta Ready")

-- TPs (All Seas - 24 locations)
local TPs = {
    ["Starter Island"] = CFrame.new(-323, 73, 5641),
    ["Jungle"] = CFrame.new(-1320, 16, 377),
    ["Windmill"] = CFrame.new(632, 54, 376),
    ["Frozen Village"] = CFrame.new(1222, 11, 441),
    ["Ice Castle"] = CFrame.new(6033, 11, -1108),
    ["Prison"] = CFrame.new(4874, 54, 733),
    ["Colosseum"] = CFrame.new(-1440, 62, 245),
    ["Magma Village"] = CFrame.new(3861, 37, -3526),
    ["Underwater City"] = CFrame.new(61164, 18, 1514),
    ["Snow Mountain"] = CFrame.new(-1240, 330, -1900),
    ["Hot and Cold"] = CFrame.new(5700, 15, -1900),
    ["Green Zone"] = CFrame.new(-2437, 72, -2037),
    ["Graveyard"] = CFrame.new(2650, 65, -2260),
    ["Dark Step"] = CFrame.new(-5055, 215, -321),
    ["Flame"] = CFrame.new(-5422, 15, -528),
    ["Haunted Castle"] = CFrame.new(-9475, 142, 6056),
    ["Sea 3 Start"] = CFrame.new(-7904, 5545, 89),
    ["Castle on the Sea"] = CFrame.new(-5075, 313, -3153),
    ["Sea 4 Start"] = CFrame.new(-4251, 40, 952),
    ["Hydra Island"] = CFrame.new(-5419, 314, -2406),
    ["Great Tree"] = CFrame.new(1449, 88, -26),
    ["Floating Turtle"] = CFrame.new(-2742, 330, 6850),
    ["Port Town"] = CFrame.new(-2880, 43, 5533),
    ["Mansion"] = CFrame.new(5234, 61, 840)
}

-- Teleports Tab
local TP = Window:NewTab("🌟 Teleports")
local TPSection = TP:NewSection("All Sea Islands/Bosses")
for name, cf in pairs(TPs) do
    TPSection:NewButton(name, "TP", function()
        pcall(function()
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = cf
            end
        end)
    end)
end

-- Fly System
local flying = false
local flySpeed = 50
local bodyVelocity
local flyConnection

local FlyTab = Window:NewTab("✈️ Movement")
local FlySection = FlyTab:NewSection("Mobile Fly + Speed")

FlySection:NewToggle("Fly", "Toggle Fly (Mobile Safe)", function(state)
    flying = state
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    if flying then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVelocity.Parent = char.HumanoidRootPart
        flyConnection = RunService.RenderStepped:Connect(function()
            if char.Parent and char:FindFirstChild("HumanoidRootPart") then
                bodyVelocity.Velocity = game.Workspace.CurrentCamera.CFrame.LookVector * flySpeed
            end
        end)
    else
        if bodyVelocity then 
            bodyVelocity:Destroy() 
            bodyVelocity = nil
        end
        if flyConnection then 
            flyConnection:Disconnect() 
            flyConnection = nil
        end
    end
end)

FlySection:NewSlider("Fly Speed", "16-500", 50, function(s)
    flySpeed = s
end)

FlySection:NewSlider("Walk Speed", "16-500", 16, function(s)
    pcall(function()
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = s
        end
    end)
end)

-- Stats Tab
local StatsTab = Window:NewTab("💪 Stats")
local StatsSection = StatsTab:NewSection("Max Stats (1000 Points)")

local stats = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}
for _, stat in pairs(stats) do
    StatsSection:NewButton("Max " .. stat, "Add 1000 Points", function()
        pcall(function()
            local CommF_ = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("CommF_")
            if CommF_ then
                CommF_:InvokeServer("AddPoint", stat, 1000)
            end
        end)
    end)
end

-- Farm Tab
local FarmTab = Window:NewTab("⚔️ Auto Farm")
local FarmSection = FarmTab:NewSection("Auto Farm + Quest")

local autoFarm = false
FarmSection:NewToggle("Auto Farm", "TP to nearest enemy + quest", function(state)
    autoFarm = state
    spawn(function()
        while autoFarm do
            task.wait(0.1)
            pcall(function()
                local char = Player.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char.Humanoid.Health > 0 then
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            char.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 10, 0)
                            local CommF_ = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("CommF_")
                            if CommF_ then
                                CommF_:InvokeServer("StartQuest")
                            end
                            break
                        end
                    end
                end
            end)
        end
    end)
end)

-- Misc Tab
local MiscTab = Window:NewTab("⚙️ Misc")
local MiscSection = MiscTab:NewSection("Extras")

MiscSection:NewButton("Infinite Stamina", "Unlimited Energy", function()
    pcall(function()
        local char = Player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.MaximumStamina = math.huge
            char.Humanoid.Stamina = math.huge
        end
    end)
end)

MiscSection:NewButton("Rejoin Server", "Fast Rejoin", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, Player)
end)

-- Character Respawn Fix
Player.CharacterAdded:Connect(function()
    task.wait(3)
    if flying then
        -- Restart fly after respawn
        flying = false
        task.wait(1)
        flying = true
    end
end)

print("✅ CRYPTA v4.0 FULLY LOADED - Mohammadexshouman-png")
