-- Garantir que o jogo carregou
repeat task.wait() until game:IsLoaded()

-- Serviços
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Variável de controle
local invisivelAtivo = false

-- Função de invisibilidade + anti hit
local function toggleInvisibilidade()
    invisivelAtivo = not invisivelAtivo
    if invisivelAtivo then
        -- Invisibilidade
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
                part.CanCollide = false
            end
        end
        -- Anti hit básico
        Humanoid.Health = math.huge
    else
        -- Reaplicar visibilidade normal
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
                part.CanCollide = true
            end
        end
    end
end

-- Criar GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "InvisibilidadeHub"
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,200,0,100)
Frame.Position = UDim2.new(0.5,-100,0.5,-50)
Frame.BackgroundColor3 = Color3.fromRGB(128,0,128) -- Roxo
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,30)
Title.Position = UDim2.new(0,0,0,0)
Title.Text = "Invisibilidade"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Parent = Frame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0,150,0,40)
ToggleButton.Position = UDim2.new(0.5,-75,0,40)
ToggleButton.Text = "Ativar/Desativar"
ToggleButton.BackgroundColor3 = Color3.fromRGB(80,80,80) -- Cinza escuro
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Parent = Frame

ToggleButton.MouseButton1Click:Connect(toggleInvisibilidade)

-- Loop para manter anti hit ativo
RunService.RenderStepped:Connect(function()
    if invisivelAtivo then
        Humanoid.Health = math.huge
        for _, part in pairs(Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.Transparency = 1
            end
        end
    end
end)
