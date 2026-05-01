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







local Content = Instance.new("Frame", Main)



Content.Size = UDim2.new(1, -150, 1, -70)



Content.Position = UDim2.new(0, 140, 0, 60)



Content.BackgroundColor3 = Color3.fromRGB(20, 21, 28)



Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)







local ContentLayout = Instance.new("UIGridLayout", Content)



ContentLayout.CellSize = UDim2.new(0.46, 0, 0, 40)



ContentLayout.CellPadding = UDim2.new(0.04, 0, 0.05, 0)



ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center







local function CreateTab(name)



    local btn = Instance.new("TextButton", Sidebar)



    btn.Size = UDim2.new(1, 0, 0, 35)



    btn.BackgroundColor3 = Color3.fromRGB(25, 26, 35)



    btn.Text = name



    btn.TextColor3 = Color3.fromRGB(200, 200, 200)



    btn.Font = Enum.Font.GothamSemibold



    btn.TextSize = 13



    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)



end







CreateTab("Player")



CreateTab("Visual")



CreateTab("Fun")







local function GetTarget()



    local text = TargetInput.Text:lower()



    local targets = {}



    if text == "" or text == "all" then return game.Players:GetPlayers() end



    for _, p in pairs(game.Players:GetPlayers()) do



        if p.Name:lower():find(text) or p.DisplayName:lower():find(text) then



            table.insert(targets, p)



        end



    end



    return targets



end







local function SendVisualChat(msg)



    local tList = GetTarget()



    for _, p in pairs(tList) do



        if p.Character and p.Character:FindFirstChild("Head") then



            game:GetService("Chat"):Chat(p.Character.Head, msg, "White")



        end



    end



end







local function CreateAction(name, callback)



    local btn = Instance.new("TextButton", Content)



    btn.BackgroundColor3 = Color3.fromRGB(30, 31, 40)



    btn.Text = name



    btn.TextColor3 = Color3.new(1, 1, 1)



    btn.Font = Enum.Font.GothamMedium



    btn.TextSize = 12



    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)



    btn.MouseButton1Click:Connect(callback)



end







-- FUNÇÃO BALLOON + CABEÇA GRANDE (ESTILO ROUBE UM BRAINROT)



CreateAction("Balloon Brainrot (V)", function()



    local char = player.Character



    local head = char:FindFirstChild("Head")



    local hrp = char:FindFirstChild("HumanoidRootPart")



    



    if char and head and hrp then



        -- Efeito de Cabeça Inchada



        local originalSize = head:FindFirstChild("Mesh") and head.Mesh.Scale or Vector3.new(1, 1, 1)



        if head:FindFirstChild("Mesh") then



            head.Mesh.Scale = Vector3.new(3, 3, 3) -- Incha a cabeça



        else



            -- Se não tiver mesh (R15), tenta usar SpecialMesh ou redimensionar



            local m = Instance.new("SpecialMesh", head)



            m.Scale = Vector3.new(3, 3, 3)



        end







        -- Criar o Balão



        local b = Instance.new("Part", char)



        b.Name = "BrainrotBalloon"



        b.Shape = Enum.PartType.Ball



        b.Size = Vector3.new(3.5, 3.5, 3.5)



        b.Color = Color3.fromRGB(255, 100, 255) -- Rosa Brainrot



        b.Material = Enum.Material.Neon



        b.CanCollide = false



        b.Position = hrp.Position + Vector3.new(0, 10, 0)



        



        -- Flutuação



        local bv = Instance.new("BodyVelocity", hrp)



        bv.Velocity = Vector3.new(0, 5, 0) -- Sobe devagar



        bv.MaxForce = Vector3.new(0, 4000, 0)



        



        -- Corda



        local rope = Instance.new("RopeConstraint", char)



        local a0 = Instance.new("Attachment", b)



        local a1 = Instance.new("Attachment", head)



        a1.Position = Vector3.new(0, 0.5, 0)



        rope.Attachment0 = a0



        rope.Attachment1 = a1



        rope.Length = 6



        rope.Visible = true







        task.wait(10) -- Duração do efeito



        



        -- Resetar tudo



        if head:FindFirstChild("Mesh") then head.Mesh.Scale = originalSize end



        if head:FindFirstChild("SpecialMesh") then head.SpecialMesh:Destroy() end



        b:Destroy()



        bv:Destroy()



        rope:Destroy()



    end



end)







CreateAction("Ragdoll", function()



    local hum = player.Character:FindFirstChildOfClass("Humanoid")



    if hum then



        hum:ChangeState(Enum.HumanoidStateType.Physics)



        task.wait(2)



        hum:ChangeState(Enum.HumanoidStateType.GettingUp)



    end



end)







CreateAction("Rocket Fogo (V)", function()



    local hrp = player.Character:FindFirstChild("HumanoidRootPart")



    if hrp then



        local fire = Instance.new("Fire", hrp)



        fire.Size, fire.Heat = 12, 25



        local smoke = Instance.new("Smoke", hrp)



        smoke.Size, smoke.Opacity = 8, 0.5



        local bv = Instance.new("BodyVelocity", hrp)



        bv.MaxForce = Vector3.new(0, math.huge, 0)



        bv.Velocity = Vector3.new(0, 150, 0)



        task.wait(2.5)



        fire:Destroy(); smoke:Destroy(); bv:Destroy()



    end



end)







CreateAction("Chat: Obrigado", function() SendVisualChat("Obrigado") end)



CreateAction("Chat: Tmj", function() SendVisualChat("Tmj") end)



CreateAction("Chat: Vlw", function() SendVisualChat("Vlw!") end)







local RobuxDisplay = Instance.new("TextLabel", Main)



RobuxDisplay.Size = UDim2.new(0, 200, 0, 30)



RobuxDisplay.Position = UDim2.new(1, -210, 1, -35)



RobuxDisplay.BackgroundTransparency = 1



RobuxDisplay.TextColor3 = Color3.fromRGB(255, 215, 0)



RobuxDisplay.Font = Enum.Font.GothamBold



RobuxDisplay.TextSize = 14



RobuxDisplay.TextXAlignment = Enum.TextXAlignment.Right







spawn(function()



    while task.wait(0.1) do



        RobuxDisplay.Text = "Robux: " .. string.format('%,d', VALOR_ROBUX):gsub(",", ".")



    end



end)







game:GetService("UserInputService").InputBegan:Connect(function(i, g)



    if not g and i.KeyCode == TECLA_TOGGLE then Main.Visible = not Main.Visible end



end)
