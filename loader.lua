--[[
    BLESSED HUB - KEY SYSTEM
    * Key: Lasius
    * Supported Lucky Block IDs: 662417684, 106931261124996
    * Discord: Copy to Clipboard
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- // SETTINGS
local CORRECT_KEY = "Lasius"
local LUCKY_BLOCK_IDS = {662417684, 106931261124996}
local LUCKY_BLOCK_URL = "https://raw.githubusercontent.com/realdausita/Luckyblock/refs/heads/main/luckyblock.lua"
local DEFAULT_URL = "https://raw.githubusercontent.com/wallyxlv/BlessedHub/refs/heads/main/BlessedHub.lua"
local DISCORD_LINK = "https://discord.gg/n5dfgBgHnC"
local EXECUTION_API = "https://blessedhub.vercel.app/api/execution" -- Vercel URL'ini buraya yaz

-- // UI CONSTRUCTION
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlessedHubKeySystem"
ScreenGui.ResetOnSpawn = false

local Success, Error = pcall(function()
    if gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = game:GetService("CoreGui")
    end
end)
if not Success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Main Panel
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(350, 220)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromHex("#0d0d15")
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromHex("#7c6aef")
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "BLESSED HUB KEYSYSTEM"
Title.TextColor3 = Color3.fromHex("#e8e6f0")
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Key Input Box
local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(0.85, 0, 0, 45)
KeyInput.Position = UDim2.fromScale(0.5, 0.45)
KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInput.BackgroundColor3 = Color3.fromHex("#12121e")
KeyInput.BorderSizePixel = 0
KeyInput.Text = ""
KeyInput.PlaceholderText = "Enter Key Here..."
KeyInput.TextColor3 = Color3.fromHex("#e8e6f0")
KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 16
KeyInput.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = KeyInput

-- Buttons
local Buttons = Instance.new("Frame")
Buttons.Size = UDim2.new(0.85, 0, 0, 40)
Buttons.Position = UDim2.fromScale(0.5, 0.75)
Buttons.AnchorPoint = Vector2.new(0.5, 0.5)
Buttons.BackgroundTransparency = 1
Buttons.Parent = MainFrame

local RedeemBtn = Instance.new("TextButton")
RedeemBtn.Size = UDim2.new(0.48, 0, 1, 0)
RedeemBtn.BackgroundColor3 = Color3.fromHex("#7c6aef")
RedeemBtn.Text = "Redeem"
RedeemBtn.TextColor3 = Color3.fromHex("#e8e6f0")
RedeemBtn.Font = Enum.Font.GothamBold
RedeemBtn.TextSize = 14
RedeemBtn.Parent = Buttons

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 8)
BtnCorner1.Parent = RedeemBtn

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0.48, 0, 1, 0)
DiscordBtn.Position = UDim2.fromScale(1, 0)
DiscordBtn.AnchorPoint = Vector2.new(1, 0)
DiscordBtn.BackgroundColor3 = Color3.fromHex("#12121e")
DiscordBtn.Text = "Copy Discord"
DiscordBtn.TextColor3 = Color3.fromHex("#e8e6f0")
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 14
DiscordBtn.Parent = Buttons

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 8)
BtnCorner2.Parent = DiscordBtn

-- // DRAGGING SYSTEM
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- // NOTIFICATION FUNCTION
local function Notify(msg, color)
    Title.Text = msg
    Title.TextColor3 = color
    task.wait(2)
    Title.Text = "BLESSED HUB KEYSYSTEM"
    Title.TextColor3 = Color3.fromHex("#e8e6f0")
end

-- // PING EXECUTION API
local function PingExecution()
    pcall(function()
        local http = game:GetService("HttpService")
        http:RequestAsync({
            Url = EXECUTION_API,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = http:JSONEncode({ place = game.PlaceId })
        })
    end)
end

-- // MAIN LOGIC
RedeemBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == CORRECT_KEY then
        Notify("SUCCESS! DETECTING GAME...", Color3.new(0, 1, 0))
        task.wait(1)

        -- Execution ping gönder
        task.spawn(PingExecution)

        local TargetScript = DEFAULT_URL
        local isLuckyBlock = false

        for _, id in pairs(LUCKY_BLOCK_IDS) do
            if game.PlaceId == id then
                isLuckyBlock = true
                break
            end
        end

        if isLuckyBlock then
            TargetScript = LUCKY_BLOCK_URL
            Notify("LUCKY BLOCK DETECTED!", Color3.new(0.5, 0.5, 1))
        else
            Notify("LOADING BLESSED HUB...", Color3.new(1, 1, 1))
        end

        TweenService:Create(MainFrame, TweenInfo.new(0.5), {Size = UDim2.fromOffset(0,0), BackgroundTransparency = 1}):Play()
        task.wait(0.5)
        ScreenGui:Destroy()

        pcall(function()
            loadstring(game:HttpGet(TargetScript))()
        end)
    else
        Notify("INVALID KEY!", Color3.new(1, 0, 0))
        KeyInput.Text = ""
    end
end)

-- // DISCORD COPY
DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        Notify("LINK COPIED!", Color3.fromHex("#7c6aef"))
    else
        Notify("ERROR COPYING!", Color3.new(1, 0, 0))
    end
end)

print("BLESSED HUB KEY SYSTEM V3 LOADED")
