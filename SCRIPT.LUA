-- ABA FUN - JAULA ANTI-KICK (PAREDES OCOAS)
CreateAction("Jail (V)", FunPage, function()
    MandarMensagemNoAlvo("/jail")
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        -- Criar um modelo para agrupar as paredes
        local jailModel = Instance.new("Model", char)
        jailModel.Name = "SafeJail"
        
        -- Função interna para criar cada parede
        local function CreateWall(name, size, offset)
            local wall = Instance.new("Part", jailModel)
            wall.Name = name
            wall.Size = size
            wall.CFrame = hrp.CFrame * offset
            wall.Anchored = true
            wall.CanCollide = true
            wall.Transparency = 0.8
            wall.Color = Color3.fromRGB(10, 10, 10)
            wall.Material = Enum.Material.Glass
            
            local box = Instance.new("SelectionBox", wall)
            box.Adornee = wall
            box.Color3 = Color3.new(0, 0, 0)
            box.LineThickness = 0.02
        end

        -- Criar as 4 paredes e o teto (deixando o centro livre para você)
        CreateWall("Front", Vector3.new(10, 12, 1), CFrame.new(0, 0, -5))
        CreateWall("Back", Vector3.new(10, 12, 1), CFrame.new(0, 0, 5))
        CreateWall("Left", Vector3.new(1, 12, 10), CFrame.new(-5, 0, 0))
        CreateWall("Right", Vector3.new(1, 12, 10), CFrame.new(5, 0, 0))
        CreateWall("Top", Vector3.new(10, 1, 10), CFrame.new(0, 6, 0))

        -- Texto Vermelho "PRESO!"
        local head = char:FindFirstChild("Head")
        if head then
            local billboard = Instance.new("BillboardGui", head)
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true
            billboard.ExtentsOffset = Vector3.new(0, 3, 0)
            local text = Instance.new("TextLabel", billboard)
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.Text = "PRESO!"
            text.TextColor3 = Color3.new(1, 0, 0)
            text.Font = Enum.Font.GothamBold
            text.TextSize = 30
            
            -- Remove tudo após 10 segundos
            task.delay(10, function()
                jailModel:Destroy()
                billboard:Destroy()
            end)
        end
    end
end)
