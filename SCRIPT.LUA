-- CERTIFIQUE-SE DE EXECUTAR COMO "LOCAL SCRIPT" NO SEU EXECUTOR
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- DELETA VERSÕES ANTIGAS PARA NÃO BUGAR
if pgui:FindFirstChild("LK7_V6_FINAL") then pgui.LK7_V6_FINAL:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "LK7_V6_FINAL"
sg.Parent = pgui
sg.IgnoreGuiInset = true
sg.ResetOnSpawn = false -- Para o menu não sumir quando você morrer

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 550, 0, 380)
Main.Position = UDim2.new(0.5, -275, 0.5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15, 16, 22)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main)

-- Se o menu não aparecer de primeira, aperte a tecla "P"
Main.Visible = true 

local Title = Instance.new("TextLabel", Main)
Title.Text = "LK7 HUB - SUPREME"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

local TargetInput = Instance.new("TextBox", Main)
TargetInput.Size = UDim2.new(0, 150, 0, 30)
TargetInput.Position = UDim2.new(0, 10, 0, 50)
TargetInput.PlaceholderText = "Nick do Alvo"
TargetInput.BackgroundColor3 = Color3.fromRGB(30, 31, 40)
TargetInput.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", TargetInput)

local Pages = Instance.new("Frame", Main)
Pages.Size = UDim2.new(0, 380, 0, 280)
Pages.Position = UDim2.new(0, 160, 0, 90)
Pages.BackgroundColor3 = Color3.fromRGB(25, 26, 33)
Instance.new("UICorner", Pages)

-- FUNÇÃO DE CHAT (CORRIGIDA PARA TODOS OS JOGOS)
local function MandarMensagemNoAlvo(msg)
    local t = TargetInput.Text:lower()
    if t == "" then return end
    for _, p in pairs(game.Players:GetPlayers()) do
        if (p.Name:lower():find(t) or p.DisplayName:lower():find(t)) and p.Character then
            local head = p.Character:FindFirstChild("Head")
            if head then
                game:GetService("Chat"):Chat(head, msg, Enum.ChatColor.White)
            end
        end
    end
end

-- BOTÃO JAULAREAL (ANTI-KICK)
local JailBtn = Instance.new("TextButton", Main)
JailBtn.Size = UDim2.new(0, 140, 0, 40)
JailBtn.Position = UDim2.new(0, 10, 0, 100)
JailBtn.Text = "Jail (5 Seg)"
JailBtn.BackgroundColor3 = Color3.fromRGB(40, 41, 50)
JailBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", JailBtn)

JailBtn.MouseButton1Click:Connect(function()
    MandarMensagemNoAlvo("/jail")
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        local jailModel = Instance.new("Model", char)
        
        -- Paredes da jaula
        local function Wall(pos)
            local p = Instance.new("Part", jailModel)
            p.Size = (pos.Y ~= 0) and Vector3.new(10, 1, 10) or (pos.X ~= 0 and Vector3.new(1, 12, 10) or Vector3.new(10, 12, 1))
            p.CFrame = hrp.CFrame * CFrame.new(pos.X*5, pos.Y*6, pos.Z*5)
            p.Anchored, p.CanCollide, p.Transparency = true, true, 0.7
            p.Material = Enum.Material.Glass
            Instance.new("SelectionBox", p).Adornee = p
        end
        Wall({X=1, Y=0, Z=0}) Wall({X=-1, Y=0, Z=0}) Wall({X=0, Y=0, Z=1}) Wall({X=0, Y=0, Z=-1}) Wall({X=0, Y=1, Z=0})
        
        -- Texto PRESO!
        local head = char:FindFirstChild("Head")
        local bg = Instance.new("BillboardGui", head)
        bg.Size = UDim2.new(0,200,0,50)
        bg.AlwaysOnTop = true
        bg.ExtentsOffset = Vector3.new(0,3,0)
        local tl = Instance.new("TextLabel", bg)
        tl.Size = UDim2.new(1,0,1,0)
        tl.Text = "PRESO!"; tl.TextColor3 = Color3.new(1,0,0); tl.Font = "GothamBold"; tl.TextSize = 30; tl.BackgroundTransparency = 1

        task.wait(5)
        jailModel:Destroy(); bg:Destroy()
    end
end)

-- TECLA PARA ABRIR/FECHAR (P)
game:GetService("UserInputService").InputBegan:Connect(function(i, g)
    if not g and i.KeyCode == Enum.KeyCode.P then Main.Visible = not Main.Visible end
end)

print("LK7 HUB EXECUTADO! Aperte P para abrir.")
