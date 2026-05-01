-- ABA FUN - JAULA IGUAL A FOTO (PRENDE POR 5 SEGUNDOS)
CreateAction("Jail (V)", FunPage, function()
    MandarMensagemNoAlvo("jail") -- Faz o player alvo "mandar" o comando
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if hrp then
        -- Criar um modelo para a Jaula
        local jailModel = Instance.new("Model", char)
        jailModel.Name = "RealJailSystem"
        
        -- Função para criar as paredes (Vidro escuro com borda preta)
        local function CreateWall(name, size, offset)
            local wall = Instance.new("Part", jailModel)
            wall.Name = name
            wall.Size = size
            wall.CFrame = hrp.CFrame * offset
            wall.Anchored = true
            wall.CanCollide = true -- Ativado para te prender
            wall.Transparency = 0.7 -- Transparência igual a foto
            wall.Color = Color3.fromRGB(15, 15, 15)
            wall.Material = Enum.Material.Glass
            
            -- Borda preta fina da jaula
            local box = Instance.new("SelectionBox", wall)
            box.Adornee = wall
            box.Color3 = Color3.new(0, 0, 0)
            box.LineThickness = 0.03
        end

        -- Criando a estrutura (Oca por dentro para evitar Kick)
        CreateWall("Frente", Vector3.new(10, 12, 0.5), CFrame.new(0, 0, -5))
        CreateWall("Tras", Vector3.new(10, 12, 0.5), CFrame.new(0, 0, 5))
        CreateWall("Esquerda", Vector3.new(0.5, 12, 10), CFrame.new(-5, 0, 0))
        CreateWall("Direita", Vector3.new(0.5, 12, 10), CFrame.new(5, 0, 0))
        CreateWall("Teto", Vector3.new(10, 0.5, 10), CFrame.new(0, 6, 0))
        CreateWall("Chao", Vector3.new(10, 0.5, 10), CFrame.new(0, -6, 0))

        -- Texto Vermelho "PRESO!" na cabeça
        local head = char:FindFirstChild("Head")
        if head then
            local billboard = Instance.new("BillboardGui", head)
            billboard.Name = "PresoTag"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.AlwaysOnTop = true
            billboard.ExtentsOffset = Vector3.new(0, 3, 0)

            local text = Instance.new("TextLabel", billboard)
            text.Size = UDim2.new(1, 0, 1, 0)
            text.BackgroundTransparency = 1
            text.Text = "PRESO!"
            text.TextColor3 = Color3.new(1, 0, 0) -- Vermelho vivo
            text.Font = Enum.Font.GothamBold
            text.TextSize = 30
            text.TextStrokeTransparency = 0 -- Borda no texto para ler melhor
            
            -- Espera 5 segundos e deleta tudo
            task.delay(5, function()
                jailModel:Destroy()
                billboard:Destroy()
            end)
        end
    end
end)
