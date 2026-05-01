local player = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
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

-- CAIXA DE NOME (Usada para Vouch e Fake Tools)
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
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(callback)
end

-- FUNÇÃO FAKE TOOL (VISUAL)
local function GiveFakeTool(toolName, color)
    local targetName = TargetInput.Text:lower()
    if targetName == "" then return end
    
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Name:lower():find(targetName) or p.DisplayName:lower():find(targetName) then
            if p.Character and p.Character:FindFirstChild("RightHand") or p.Character:FindFirstChild("Right Arm") then
                local hand = p.Character:FindFirstChild("RightHand") or p.Character:FindFirstChild("Right Arm")
                
                -- Remove tool antiga se existir
                if p.Character:FindFirstChild("FakeHandle") then p.Character.FakeHandle:Destroy() end
                
                local tool = Instance.new("Part", p.Character)
                tool.Name = "FakeHandle"
                tool.Size = Vector3.new(0.5, 2.5, 0.5)
                tool.Color = color
                tool.Material = Enum.Material.Neon
                tool.CanCollide = false
                
                local weld = Instance.new("Weld", tool)
                weld.Part0 = tool
                weld.Part1 = hand
                weld.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(90), 0, 0)
                
                -- Label flutuante na tool
                local bbg = Instance.new("BillboardGui", tool)
                bbg.Size = UDim2.new(0, 100, 0, 30)
                bbg.AlwaysOnTop = true
                bbg.ExtentsOffset = Vector3.new(0, 2, 0)
                local txt = Instance.new("TextLabel", bbg)
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.Text = toolName
                txt.TextColor3 = color
                txt.BackgroundTransparency = 1
                txt.Font = Enum.Font.GothamBold
                txt.TextSize = 14
            end
        end
    end
end

--- ABA VISUAL ---
CreateAction("Fake Jump", VisualPage, function()
    local target = nil
    local dist = math.huge
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = (player.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then target = p dist = d end
        end
    end
    if target and target.Character:FindFirstChild("Humanoid") then
        target.Character.Humanoid.Jump = true
    end
end)

CreateAction("Fake: Carpete Voador", VisualPage, function() GiveFakeTool("Carpete Voador", Color3.fromRGB(170, 85, 255)) end)
CreateAction("Fake: Martelo Ban", VisualPage, function() GiveFakeTool("Ban Hammer", Color3.fromRGB(255, 0, 0)) end)
CreateAction("Fake: Arma Laser", VisualPage, function() GiveFakeTool("Laser Gun", Color3.fromRGB(0, 255, 255)) end)

--- ABA PLAYER ---
CreateAction("Vouch: Vlww mn", PlayerPage, function()
    local targetName = TargetInput.Text:lower()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Name:lower():find(targetName) or p.DisplayName:lower():find(targetName) then
            game:GetService("Chat"):Chat(p.Character.Head, "vlww mn", "White")
        end
    end
end)
-- (Repetir para os outros vouches...)

--- ABA FUN ---
CreateAction("Rocket Fogo (V)", FunPage, function()
    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local fire = Instance.new("Fire", hrp)
        fire.Size = 12
        local bv = Instance.new("BodyVelocity", hrp)
        bv.MaxForce = Vector3.new(0, math.huge, 0)
        bv.Velocity = Vector3.new(0, 150, 0)
        task.wait(2.5)
        fire:Destroy(); bv:Destroy()
    end
end)

-- (Display Robux e Tecla P mantidos...)
