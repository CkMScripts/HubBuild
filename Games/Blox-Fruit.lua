local Config = {
    WindowName = "CK Hub",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightControl
}
repeat wait() until game:IsLoaded() 
game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

 game:GetService("RunService").Stepped:connect(
    function()
        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", 1000)
    end
)

local Quest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest

local function GetClosestt()
    local TargetDistance = math.huge
    local Target
    for i, v in ipairs(game:GetService("Workspace"):GetChildren()) do
        if v.Name == "Chest1" or v.Name == "Chest2" or v.Name == "Chest3" then
            local Mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude
            if Mag < TargetDistance then
                TargetDistance = Mag
                Target = v
            end
        end
    end
    return Target
end


local Circle = Drawing.new("Circle")
Circle.Color = Color3.fromRGB(22, 13, 56)
Circle.Thickness = 1
Circle.Radius = 250
Circle.Visible = false
Circle.NumSides = 1000
Circle.Filled = false
Circle.Transparency = 1

game:GetService("RunService").RenderStepped:Connect(
    function()
        local Mouse = game:GetService("UserInputService"):GetMouseLocation()
        Circle.Position = Vector2.new(Mouse.X, Mouse.Y)
    end
)

getgenv().AimBot = {
    FreeForAll = false,
    WallCheck = false,
    Enabled = false,
    FOV = 250
}

function FreeForAll(v)
    if getgenv().AimBot.FreeForAll == false then
        if game.Players.LocalPlayer.Team == v.Team then
            return false
        else
            return true
        end
    else
        return true
    end
end

function NotObstructing(i, v)
    if getgenv().AimBot.WallCheck then
        c = workspace.CurrentCamera.CFrame.p
        a = Ray.new(c, i - c)
        f = workspace:FindPartOnRayWithIgnoreList(a, v)
        return f == nil
    else
        return true
    end
end
game:GetService("UserInputService").InputBegan:Connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 then
            Shoot = true
        end
    end
)

game:GetService("UserInputService").InputEnded:Connect(
    function(v)
        if v.UserInputType == Enum.UserInputType.MouseButton2 then
            Shoot = false
        end
    end
)

function GetMouse()
    return Vector2.new(mouse.X, mouse.Y)
end
function GetClosestToCuror()
    MousePos = GetMouse()
    Closest = math.huge
    Target = nil
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if FreeForAll(v) then
            if v.Character:FindFirstChild("UpperTorso") and v ~= game.Players.LocalPlayer then
                Point, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character.UpperTorso.Position)
                if
                    OnScreen and
                        NotObstructing(
                            v.Character.UpperTorso.Position,
                            {game.Players.LocalPlayer.Character, v.Character}
                        )
                 then
                    Distance = (Vector2.new(Point.X, Point.Y) - MousePos).magnitude
                    if Distance <= getgenv().AimBot.FOV then
                        Closest = Distance
                        Target = v
                    end
                end
            end
        end
    end
    return Target
end

game:GetService("RunService").Stepped:connect(
    function()
        if getgenv().AimBot.Enabled == false or Shoot == false then
            return
        end
        ClosestPlayer = GetClosestToCuror()
        if ClosestPlayer then
            workspace.CurrentCamera.CFrame =
                CFrame.new(workspace.CurrentCamera.CFrame.p, ClosestPlayer.Character.HumanoidRootPart.CFrame.p)
        end
    end
)
yes1 = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"}

game:GetService("RunService").Stepped:connect(
    function()
for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
        v.Name = string.gsub(v.Name, "[Lv. " .. "%d+]", "")

        v.Name = string.gsub(v.Name, "[%[%]]", "")
    end
end


for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
    if v:IsA("Model") and v:FindFirstChild("Humanoid") then
        v.Name = string.gsub(v.Name, "[Lv. " .. "%d+]", "")

        v.Name = string.gsub(v.Name, "[%[%]]", "")
    end
end
end)

if game.PlaceId == 2753915549 then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end
repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
for i, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
    if v.ClassName == "Tool" then
        v.Parent = game.Players.LocalPlayer.Backpack
    end
end

tools = {}
for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetDescendants()) do
    if v.ClassName == "Tool" then
        table.insert(tools, v.Name)
    end
end

local Qat = require(game:GetService("ReplicatedStorage").Quests)
Quests = {}
for i, v in pairs(Qat) do
    table.insert(Quests, i)
    table.sort(Quests)
end

mobs = {}
for i, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if v.ClassName == "Model" and v:FindFirstChild("Stun") and not table.find(mobs, v.Name) then
        table.insert(mobs, v.Name)
        table.sort(mobs)
    end
end
for i, v in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
    if v.ClassName == "Model" and v:FindFirstChild("Stun") and not table.find(mobs, v.Name) then
        table.insert(mobs, v.Name)
        table.sort(mobs)
    end
end
getgenv().speed = 100
local function c()
    for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Level") and v.Name == tools then
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
        end
    end
end

local function GetClosestMob()
    local TargetDistance = math.huge
    local Target
    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v:IsA("Model") and string.find(Quest.Container.QuestTitle.Title.Text,v.Name) and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
            local Mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
            if Mag < TargetDistance then
                TargetDistance = Mag
                Target = v
            end
        end
    end
    return Target
end
local function GetClosestMobRep()
    local TargetDistance = math.huge
    local Target
    for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                if v:IsA("Model") and string.find(Quest.Container.QuestTitle.Title.Text,v.Name) and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
            local Mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
            if Mag < TargetDistance then
                TargetDistance = Mag
                Target = v
            end
        end
    end
    return Target
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/CKScrips/HubBuild/main/GUI/Main.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Blox Fruits")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("")
local Section2 = Tab1:CreateSection("")
local SectionA = Tab1:CreateSection("")
local Section3 = Tab2:CreateSection("Menu")
local Section4 = Tab2:CreateSection("Background")

local Toggle1 = Section1:CreateToggle("Aimbot", nil, function(State)
    getgenv().AimBot.Enabled = State
end)


local Toggle1 = Section1:CreateToggle("WallCheck", nil, function(State)
    getgenv().AimBot.WallCheck = State
end)
local Slider2 = Section1:CreateSlider("Aimbot Radius", 0,1000,nil,false, function(Value)
    getgenv().AimBot.FOV = Value
    Circle.Radius = Value
end)
local Slider2 = Section1:CreateSlider("Tween Speed", 0,200,nil,false, function(Value)
    getgenv().speed = Value
end)

local Toggle1 = Section1:CreateToggle("Circle Visible", nil, function(State)
   Circle.Visible = State
end)

local Colorpicker3 = Section1:CreateColorpicker("Circle Color", function(Color)
    Circle.Color = Color
end)


local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/CKScrips/HubBuild/main/GUI/Main.lua"))()

local Toggle1 = Section1:CreateToggle("Player Esp", nil, function(State)
    ESP:Toggle(State)
end)

local Toggle1 = Section1:CreateToggle("Tracers Esp", nil, function(State)
    ESP.Tracers = State
end)

local Toggle1 = Section1:CreateToggle("Name Esp", nil, function(State)
    ESP.Names = State
end)

local Toggle1 = Section1:CreateToggle("Boxes Esp", nil, function(State)
    ESP.Boxes = State
end)

local Toggle1 = Section1:CreateToggle("MoneyFarm", nil, function(State)
getgenv().Money = State
game:GetService("RunService").Stepped:connect(
    function()
        if getgenv().Money then
           game.Players.LocalPlayer.Character:WaitForChild('Humanoid'):ChangeState(11)
        end
    end
)

         
while getgenv().Money do
    wait()
    pcall(function()
            if getgenv().Money then
               local Time =
                (GetClosestt().CFrame.p + Vector3.new(0, 0, 0) -
                game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude / getgenv().speed
            local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
            local Tween =
                game:GetService("TweenService"):Create(
                game.Players.LocalPlayer.Character.HumanoidRootPart,
                Info,
                {
                    CFrame = CFrame.new(
                        GetClosestt().CFrame.p + Vector3.new(0,  0, 0)
                    )
                }
            )
            Tween:Play()
        end 
        end
    )
end
end)
local Toggle1 = Section1:CreateToggle("Invis", nil, function(State)
invis = State
local Clone = game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Clone()
game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Destroy()
Clone.Parent = game:GetService("Players").LocalPlayer.Character.LowerTorso

game.Players.LocalPlayer.CharacterAdded:Connect(
    function()
        wait(4)
        repeat
            wait()
        until game.Players.LocalPlayer.Character
        if invis then
            local Clone = game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Clone()
            game:GetService("Players").LocalPlayer.Character.LowerTorso.Root:Destroy()
            Clone.Parent = game:GetService("Players").LocalPlayer.Character.LowerTorso
        end
    end
)
end)

local Toggle1 = Section1:CreateToggle("Auto Find Fruit", nil, function(State)
jjsploit = State
while wait() and jjsploit do
    pcall(
        function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                game.workspace:FindFirstChildOfClass("Tool").Handle.CFrame
        end
    )
end
end)
repeat wait() until game.Players.LocalPlayer.Character
local Dropdown1 = Section1:CreateDropdown("Select Tool")
Dropdown1:AddToolTip("Select Tool to use for farmming")
for i,v in next,tools do
Dropdown1:AddOption(v, function(String)
tools = String
end)
end

local Toggle1 =Section1:CreateToggle("MobFarm", nil, function(State)
getgenv().Farm = State
game:GetService("RunService").Stepped:connect(
    function()
        if getgenv().Farm then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
        end
    end
)

spawn(
    function()
        while getgenv().Farm do
            wait()
            pcall(function()
            for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if v:IsA("Model") and v.Name == mobs and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                    repeat
                        wait()
                        local Time =
                            (v.HumanoidRootPart.CFrame.p + Vector3.new(0, -5, 3) -
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude / getgenv().speed
                        local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
                        local Tween =
                            game:GetService("TweenService"):Create(
                            game.Players.LocalPlayer.Character.HumanoidRootPart,
                            Info,
                            {
                                CFrame = CFrame.new(v.HumanoidRootPart.CFrame.p + Vector3.new(0, -5, 3))
                            }
                        )
                        Tween:Play()
                        game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
                    until v.Humanoid.Health == 0 or getgenv().Farm == false 
                end
            end
            for i, v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                if v:IsA("Model") and v.Name == mobs and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
                    repeat
                        wait()
                        local Time =
                            (v.HumanoidRootPart.CFrame.p + Vector3.new(0, 0, 0) -
                            game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude / getgenv().speed
                        local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
                        local Tween =
                            game:GetService("TweenService"):Create(
                            game.Players.LocalPlayer.Character.HumanoidRootPart,
                            Info,
                            {
                                CFrame = CFrame.new(v.HumanoidRootPart.CFrame.p + Vector3.new(0, 0, -3))
                            }
                        )
                        Tween:Play()
                    until getgenv().Farm == false or v == nil
                end
            end
            end)
        end
    end
)

spawn(
    function()
        while getgenv().Farm do pcall(function()
            wait(0.2)
            c()
        end) 
        end
    end
)

end)

local Dropdown1 = Section1:CreateDropdown("Select Mob")
Dropdown1:AddToolTip("Select Mob")
for i,v in next,mobs do
Dropdown1:AddOption(v, function(String)
mobs = String
end)
end

local Toggle1 =Section1:CreateToggle("Auto Quest", nil, function(State)
getgenv().Qu = State


game:GetService("RunService").Stepped:connect(
    function()
        if getgenv().Qu then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
        end
    end
)




while getgenv().Qu do
    pcall(
        function()
            wait()
            repeat
                wait()
                if Quest.Visible == true then
                    local Time =
                        (GetClosestMob().HumanoidRootPart.CFrame.p + Vector3.new(0, -5, 3) -
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude / getgenv().speed
                    local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
                    local Tween =
                        game:GetService("TweenService"):Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        Info,
                        {
                            CFrame = CFrame.new(GetClosestMob().HumanoidRootPart.CFrame.p + Vector3.new(0, -5, 3))
                        }
                    )
                    Tween:Play()
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(9e9, 9e9))
                    c()
                    local Time =
                        (GetClosestMobRep().HumanoidRootPart.CFrame.p + Vector3.new(0, 0, 0) -
                        game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude / getgenv().speed
                    local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear)
                    local Tween =
                        game:GetService("TweenService"):Create(
                        game.Players.LocalPlayer.Character.HumanoidRootPart,
                        Info,
                        {
                            CFrame = CFrame.new(GetClosestMobRep().HumanoidRootPart.CFrame.p + Vector3.new(0, 0, -3))
                        }
                    )
                    Tween:Play()
                end
            until Quest.Visible == false or getgenv().Qu == false
            repeat
                wait()
                if Quest.Visible == false then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", Quests, 1)
                end
            until Quest.Visible == true or getgenv().Qu == false
        end
    )
end

end)


local Dropdown1 = Section1:CreateDropdown("Select Quest")
Dropdown1:AddToolTip("Select Quest")
for i,v in next,Quests do
Dropdown1:AddOption(v, function(String)
Quests = String
end)
end


local Toggle1 = Section1:CreateToggle("Auto Stats", nil, function(State)
jjsploit1 = State
while wait() and jjsploit1 do
    pcall(
        function()
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", yes1, 1)
        end
    )
end
end)

local Dropdown1 = Section1:CreateDropdown("Select Stat")
Dropdown1:AddToolTip("Select Stat")
for i,v in next,yes1 do
Dropdown1:AddOption(v, function(String)
yes1 = String
end)
end


if syn then
local TextBox1 = Section2:CreateTextBox("Fps Cap", "Only numbers", true, function(Value)
    getgenv().Fps = Value
    pcall(function()
setfpscap(getgenv().Fps)
end)
end)
end
local TextBox1 = Section2:CreateTextBox("WalkSpeed", "Only numbers", true, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)
local TextBox1 = Section2:CreateTextBox("JumpPower", "Only numbers", true, function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)
local Toggle1 = Section2:CreateToggle("Infinite Jump", nil, function(State)
Infinite = State
game:GetService("UserInputService").JumpRequest:connect(function()
	if Infinite then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end) end)


local Toggle1 = Section2:CreateToggle("G Noclip", nil, function(State)
sex = State
noclip = false
game:GetService('RunService').Stepped:connect(function()
if noclip then
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end
end)
plr = game.Players.LocalPlayer
mouse = plr:GetMouse()
mouse.KeyDown:connect(function(key)

if key == "g" then
if sex then
noclip = not noclip
game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
end end 
end) end)

local Toggle1 = Section2:CreateToggle("B Fly", nil, function(State)
sex2 = State
local Max = 0
local Players = game.Players
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
Mouse.KeyDown:connect(function(k)
if k:lower() == 'b' then
Max = Max + 1
getgenv().Fly = false
if sex2 then
local T = LP.Character.UpperTorso
local S = {
F = 0,
B = 0,
L = 0,
R = 0
}
local S2 = {
F = 0,
B = 0,
L = 0,
R = 0
}
local SPEED = 5
local function FLY()
getgenv().Fly = true
local BodyGyro = Instance.new('BodyGyro', T)
local BodyVelocity = Instance.new('BodyVelocity', T)
BodyGyro.P = 9e4
BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
BodyGyro.cframe = T.CFrame
BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
spawn(function()
repeat
wait()
LP.Character.Humanoid.PlatformStand = false
if S.L + S.R ~= 0 or S.F + S.B ~= 0 then
SPEED = 200
elseif not (S.L + S.R ~= 0 or S.F + S.B ~= 0) and SPEED ~= 0 then
SPEED = 0
end
if (S.L + S.R) ~= 0 or (S.F + S.B) ~= 0 then
BodyVelocity.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (S.F + S.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(S.L + S.R, (S.F + S.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
S2 = {
F = S.F,
B = S.B,
L = S.L,
R = S.R
}
elseif (S.L + S.R) == 0 and (S.F + S.B) == 0 and SPEED ~= 0 then
BodyVelocity.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (S2.F + S2.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(S2.L + S2.R, (S2.F + S2.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
else
BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
end
BodyGyro.cframe = game.Workspace.CurrentCamera.CoordinateFrame
until not getgenv().Fly
S = {
F = 0,
B = 0,
L = 0,
R = 0
}
S2 = {
F = 0,
B = 0,
L = 0,
R = 0
}
SPEED = 0
BodyGyro:destroy()
BodyVelocity:destroy()
LP.Character.Humanoid.PlatformStand = false
end)
end
Mouse.KeyDown:connect(function(k)
if k:lower() == 'w' then
S.F = 1
elseif k:lower() == 's' then
S.B = -1
elseif k:lower() == 'a' then
S.L = -1
elseif k:lower() == 'd' then
S.R = 1
end
end)
Mouse.KeyUp:connect(function(k)
if k:lower() == 'w' then
S.F = 0
elseif k:lower() == 's' then
S.B = 0
elseif k:lower() == 'a' then
S.L = 0
elseif k:lower() == 'd' then
S.R = 0
end
end)
FLY()
if Max == 2 then
getgenv().Fly = false
Max = 0
end
end
end
end)
end)
local Button1 = Section2:CreateButton("Anti Lag", function()
for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
if v:IsA("BasePart") and not v.Parent:FindFirstChild("Humanoid") then 
v.Material = Enum.Material.SmoothPlastic;
if v:IsA("Texture") then
v:Destroy();
end end;		
end;
end)

local Button1 = Section2:CreateButton("Teleport to RandomPlayer", function()
local randomPlayer = game.Players:GetPlayers()
[math.random(1,#game.Players:GetPlayers())]

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(randomPlayer.Character.Head.Position.X, randomPlayer.Character.Head.Position.Y, randomPlayer.Character.Head.Position.Z)) end)
local Button1 = Section2:CreateButton("Lag Switch F3", function()
local a = false
local b = settings()

game:service'UserInputService'.InputEnded:connect(function(i)
if i.KeyCode == Enum.KeyCode.F3 then
a = not a
b.Network.IncomingReplicationLag = a and 10 or 0
end
end) end) 
local Button1 = Section2:CreateButton("ServerHop", function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

-- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
Teleport() 
end)
local Button1 = Section2:CreateButton("Rejoin", function()
game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer) end)

local Toggle3 = Section3:CreateToggle("UI Toggle", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)
Section3:CreateLabel("Credits DekuDimz#7960")
Section3:CreateLabel("Credits AlexR32#3232 Ui")
local Colorpicker3 = Section3:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)
-- credits to jan for patterns
local Dropdown3 = Section4:CreateDropdown("Image")
local Option7 = Dropdown3:AddOption("Default", function(String)
	Window:SetBackground("2151741365")
end)
local Option8 = Dropdown3:AddOption("Hearts", function(String)
	Window:SetBackground("6073763717")
end)
local Option9 = Dropdown3:AddOption("Abstract", function(String)
	Window:SetBackground("6073743871")
end)
local Option10 = Dropdown3:AddOption("Hexagon", function(String)
	Window:SetBackground("6073628839")
end)
local Option11 = Dropdown3:AddOption("Circles", function(String)
	Window:SetBackground("6071579801")
end)
local Option12 = Dropdown3:AddOption("Lace With Flowers", function(String)
	Window:SetBackground("6071575925")
end)
local Option13 = Dropdown3:AddOption("Floral", function(String)
	Window:SetBackground("5553946656")
end)
Option7:SetOption()

local Colorpicker4 = Section4:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = Section4:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section4:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)
