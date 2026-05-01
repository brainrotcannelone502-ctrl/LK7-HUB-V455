local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- Remove versão antiga se existir para não dar lag
if pgui:FindFirstChild("LK7_KurdStyle_V6") then pgui.LK7_KurdStyle_V6:Destroy() end

local sg = Instance.new("ScreenGui", pgui)
sg.Name = "LK7_KurdStyle_V6"
sg.ResetOnSpawn = false

local VALOR_ROBUX = 100000
local TECLA_TOGGLE = Enum.KeyCode.P

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local TopBar = Instance.new("Frame", Main)
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Text = "LK7 HUB - BRAINROT EDITION"
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local TargetInput = Instance.new("TextBox", Main)
TargetInput.Size = UDim2.new(0, 120, 0, 30)
TargetInput.Position = UDim2.new(0, 10, 0, 55)
TargetInput.BackgroundColor3 = Color3.fromRGB(30, 31, 40)
TargetInput.PlaceholderText = "Nome do Player"
TargetInput.Text = ""
TargetInput.TextColor3 = Color3.new(1, 1, 1)
TargetInput.Font = Enum.Font.GothamSemibold
TargetInput.TextSize = 12
Instance.new("UICorner", TargetInput)

local Sidebar = Instance.new("ScrollingFrame", Main)
Sidebar.Size = UDim2.new(0, 120, 1, -100)
Sidebar.Position = UDim2.new(0, 10, 0, 95)
Sidebar.BackgroundTransparency = 1
Sidebar.ScrollBarThickness = 0
Instance.new("UIListLayout", Sidebar).Padding = UDim.new(0, 5)

local Pages = Instance.new("Frame", Main)
Pages.Size = UDim2.new(1, -150, 1, -70)
Pages.Position = UDim2.new(0, 140, 0, 60)
Pages.BackgroundColor3 = Color3.fromRGB(20, 21, 28)
Instance.new("UICorner", Pages).CornerRadius = UDim.new(0, 8)

local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", Pages)
    p.Name = name
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.ScrollBarThickness = 0
    local layout = Instance.new("UIGridLayout", p)
    layout.CellSize = UDim2.new(0, 180, 0, 40)
    layout.CellPadding = UDim2.new(0, 10, 0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(25, 26, 35)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        for _, page in pairs(Pages:GetChildren()) do 
            if page:IsA("ScrollingFrame") then page.Visible = false end 
        end
        p.Visible = true
    end)
    return p
end

local PlayerPage = CreatePage("Player")
local VisualPage = CreatePage("Visual")
local FunPage = CreatePage("Fun")
FunPage.Visible = true

local function CreateAction(name, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.BackgroundColor3 = Color3.fromRGB(30, 31, 40)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 11
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

local function FakeVouch(msg)
    local t = TargetInput.Text:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Name:lower():find(t) or p.DisplayName:lower():find(t) then
            game:GetService("Chat"):Chat(p.Character.Head, msg, "White")
        end
    end
end

-- ABA PLAYER (TODOS OS VOUCHS)
CreateAction("Vouch: Vlww mn", PlayerPage, function() FakeVouch("vlww mn") end)
CreateAction("Vouch: Chegou aqui", PlayerPage, function() FakeVouch("chegou aqui") end)
CreateAction("Vouch: Tmjjjj", PlayerPage, function() FakeVouch("tmjjjj") end)
CreateAction("Vouch: Confiavel", PlayerPage, function() FakeVouch("confiavel") end)

-- ABA VISUAL (JUMP E TOOLS)
CreateAction("Fake Jump", VisualPage, function()
    local target = nil
    local dist = math.huge
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Humanoid") then
            local d = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then target = p dist = d end
        end
    end
    if target then target.Character.Humanoid.Jump = true end
end)
CreateAction("Fake: Carpete", VisualPage, function() print("Carpete") end)
CreateAction("Fake: Martelo", VisualPage, function() print("Martelo") end)

-- ABA FUN (ROCKET, BALLOON, RAGDOLL)
CreateAction("Rocket Fogo (V)", FunPage, function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local f = Instance.new("Fire", hrp)
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Velocity = Vector3.new(0, 100, 0)
        task.wait(2)
        f:Destroy(); bv:Destroy()
    end
end)

CreateAction("Balloon Brainrot (V)", FunPage, function()
    local head = player.Character:FindFirstChild("Head")
    if head then
        local b = Instance.new("Part", player.Character)
        b.Shape = "Ball"
        b.Size = Vector3.new(3,3,3)
        b.Color = Color3.new(1,0,1)
        b.Position = head.Position + Vector3.new(0,5,0)
        local r = Instance.new("RopeConstraint", player.Character)
        local a0, a1 = Instance.new("Attachment", b), Instance.new("Attachment", head)
        r.Attachment0, r.Attachment1, r.Length, r.Visible = a0, a1, 5, true
        task.wait(5)
        b:Destroy(); r:Destroy()
    end
end)

CreateAction("Ragdoll", FunPage, function()
    local h = player.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h:ChangeState(Enum.HumanoidStateType.Physics)
        task.wait(2)
        h:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end)

local RobuxDisplay = Instance.new("TextLabel", Main)
RobuxDisplay.Size = UDim2.new(0, 200, 0, 30)
RobuxDisplay.Position = UDim2.new(1, -210, 1, -35)
RobuxDisplay.BackgroundTransparency = 1
RobuxDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)
RobuxDisplay.Text = "Robux: 100.000"
RobuxDisplay.Font = Enum.Font.GothamBold

game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == TECLA_TOGGLE then Main.Visible = not Main.Visible end
end)
