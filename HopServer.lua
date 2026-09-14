local queue_on_teleport = queue_on_teleport or queueonteleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or (getgenv and getgenv().queue_on_teleport)

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

-- Target Parent GUI (CoreGui paling aman untuk Delta)
local TargetParent = CoreGui

if TargetParent:FindFirstChild("ServerFinderGui") then
    TargetParent.ServerFinderGui:Destroy()
end

-- ScreenGui Main (With IgnoreGuiInset for Full Device Coverage)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ServerFinderGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = TargetParent

-- Full Screen Dark Overlay (Full coverage across notches & status bars)
local OverlayFrame = Instance.new("Frame")
OverlayFrame.Name = "OverlayFrame"
OverlayFrame.Size = UDim2.new(1, 0, 1, 0)
OverlayFrame.Position = UDim2.new(0, 0, 0, 0)
OverlayFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OverlayFrame.BackgroundTransparency = 0.55
OverlayFrame.Active = true
OverlayFrame.Visible = false
OverlayFrame.ZIndex = 1000
OverlayFrame.Parent = ScreenGui

-- Independent Centered Dialog Frame (Always centered on screen regardless of MainFrame state)
local DialogFrame = Instance.new("Frame")
DialogFrame.Name = "ConfirmDialog"
DialogFrame.Size = UDim2.new(0, 270, 0, 135)
DialogFrame.AnchorPoint = Vector2.new(0.5, 0.5)
DialogFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
DialogFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 34)
DialogFrame.BorderSizePixel = 0
DialogFrame.ZIndex = 1001
DialogFrame.Parent = OverlayFrame

local DialogCorner = Instance.new("UICorner")
DialogCorner.CornerRadius = UDim.new(0, 8)
DialogCorner.Parent = DialogFrame

local DialogStroke = Instance.new("UIStroke")
DialogStroke.Color = Color3.fromRGB(60, 60, 75)
DialogStroke.Thickness = 1
DialogStroke.Parent = DialogFrame

local DialogTitle = Instance.new("TextLabel")
DialogTitle.Size = UDim2.new(1, -20, 0, 50)
DialogTitle.Position = UDim2.new(0, 10, 0, 10)
DialogTitle.BackgroundTransparency = 1
DialogTitle.Text = "Are you sure you want to unload the script?"
DialogTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
DialogTitle.TextSize = 13
DialogTitle.Font = Enum.Font.SourceSansBold
DialogTitle.TextWrapped = true
DialogTitle.ZIndex = 1002
DialogTitle.Parent = DialogFrame

local YesBtn = Instance.new("TextButton")
YesBtn.Size = UDim2.new(0, 100, 0, 32)
YesBtn.Position = UDim2.new(0.5, -107, 1, -44)
YesBtn.BackgroundColor3 = Color3.fromRGB(217, 83, 79)
YesBtn.Text = "Yes"
YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
YesBtn.Font = Enum.Font.SourceSansBold
YesBtn.TextSize = 13
YesBtn.ZIndex = 1002
YesBtn.Parent = DialogFrame

local YesCorner = Instance.new("UICorner")
YesCorner.CornerRadius = UDim.new(0, 5)
YesCorner.Parent = YesBtn

local NoBtn = Instance.new("TextButton")
NoBtn.Size = UDim2.new(0, 100, 0, 32)
NoBtn.Position = UDim2.new(0.5, 7, 1, -44)
NoBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 82)
NoBtn.Text = "No"
NoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoBtn.Font = Enum.Font.SourceSansBold
NoBtn.TextSize = 13
NoBtn.ZIndex = 1002
NoBtn.Parent = DialogFrame

local NoCorner = Instance.new("UICorner")
NoCorner.CornerRadius = UDim.new(0, 5)
NoCorner.Parent = NoBtn

-- Main Frame (Compact, Centered & Draggable)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 310)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 1
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 58)
MainStroke.Thickness = 1
MainStroke.Parent = MainFrame

-- Header Frame
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Color3.fromRGB(28, 28, 36)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 90, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Server Finder"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Close Button (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 12
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

-- Minimize Button (-)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 24, 0, 24)
ToggleBtn.Position = UDim2.new(1, -58, 0.5, -12)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
ToggleBtn.Text = "-"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14
ToggleBtn.Parent = Header

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 4)
ToggleCorner.Parent = ToggleBtn

-- Refresh Button
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(0, 60, 0, 26)
RefreshBtn.Position = UDim2.new(1, -122, 0.5, -13)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
RefreshBtn.Text = "Refresh"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Font = Enum.Font.SourceSansBold
RefreshBtn.TextSize = 12
RefreshBtn.Parent = Header

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 5)
RefreshCorner.Parent = RefreshBtn

-- Auto Hop Button
local AutoHopBtn = Instance.new("TextButton")
AutoHopBtn.Size = UDim2.new(0, 65, 0, 26)
AutoHopBtn.Position = UDim2.new(1, -191, 0.5, -13)
AutoHopBtn.BackgroundColor3 = Color3.fromRGB(142, 68, 173)
AutoHopBtn.Text = "Auto Hop"
AutoHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoHopBtn.Font = Enum.Font.SourceSansBold
AutoHopBtn.TextSize = 12
AutoHopBtn.Parent = Header

local AutoHopCorner = Instance.new("UICorner")
AutoHopCorner.CornerRadius = UDim.new(0, 5)
AutoHopCorner.Parent = AutoHopBtn

-- Content Frame Container
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -42)
ContentFrame.Position = UDim2.new(0, 0, 0, 42)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Scroll Frame
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -16, 1, -12)
ScrollFrame.Position = UDim2.new(0, 8, 0, 6)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollFrame.ScrollBarThickness = 4
ScrollFrame.Parent = ContentFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 6)
UIList.Parent = ScrollFrame

UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 6)
end)

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.Position = UDim2.new(0, 0, 0, 10)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Loading server list..."
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 13
StatusLabel.Parent = ScrollFrame

local serverCards = {}
local validServersList = {}
local statusTimer = nil

-- Dual Notification System
local function Notify(title, message, duration)
    duration = duration or 3
    StatusLabel.Visible = true
    StatusLabel.Text = message
    
    if statusTimer then
        pcall(task.cancel, statusTimer)
        statusTimer = nil
    end
    
    statusTimer = task.delay(duration, function()
        if #validServersList > 0 then
            StatusLabel.Visible = false
        end
    end)

    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "Server Finder",
            Text = message,
            Duration = duration
        })
    end)
end

CloseBtn.MouseButton1Click:Connect(function()
    OverlayFrame.Visible = true
end)

YesBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

NoBtn.MouseButton1Click:Connect(function()
    OverlayFrame.Visible = false
end)

local isMinimized = false
ToggleBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentFrame.Visible = not isMinimized
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 340, 0, 42)
        ToggleBtn.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 340, 0, 310)
        ToggleBtn.Text = "-"
    end
end)

local lastAttemptedServerId = nil
local isAutoHopping = false
local lastFetchTime = 0
local FETCH_COOLDOWN = 3
local MAX_SEPI_THRESHOLD = 3

-- Direct Roblox API Fetcher via Executor HTTP Request
local function CustomRequest(url)
    local bodyText = nil
    local reqFunc = (syn and syn.request) or http_request or request or (http and http.request)

    if reqFunc then
        pcall(function()
            local res = reqFunc({
                Url = url,
                Method = "GET",
                Headers = {
                    ["User-Agent"] = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
                }
            })
            if res and res.Body then
                bodyText = res.Body
            end
        end)
    end

    if (not bodyText or bodyText == "") and not url:find("roblox.com") then
        pcall(function()
            bodyText = game:HttpGet(url)
        end)
    end

    if bodyText and bodyText ~= "" then
        local jsonOk, decoded = pcall(function() return HttpService:JSONDecode(bodyText) end)
        if jsonOk and decoded and decoded.data then
            return decoded.data
        end
    end
    return nil
end

local function FetchServers()
    local placeId = game.PlaceId
    local apiEndpoints = {
        "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100",
        "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Desc&limit=100",
        "https://games.roproxy.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100",
        "https://games.roproxy.com/v1/games/" .. placeId .. "/servers/Public?limit=100"
    }

    for _, url in ipairs(apiEndpoints) do
        local data = CustomRequest(url)
        if data and #data > 0 then
            return data
        end
        task.wait(0.2)
    end
    return {}
end

local function GetProcessedServers()
    local rawServers = FetchServers()
    local result = {}

    for _, s in ipairs(rawServers) do
        local playingCount = s.playing or s.players or 0
        local maxCapacity = s.maxPlayers or 12
        
        if playingCount >= 1 and playingCount < maxCapacity and s.id ~= game.JobId then
            table.insert(result, s)
        end
    end

    table.sort(result, function(a, b)
        return (a.playing or 0) < (b.playing or 0)
    end)

    return result
end

local TriggerAutoHop

-- Auto-dismiss Error Popups & Cleanup Dark Background Overlay
task.spawn(function()
    local robloxPromptGui = CoreGui:FindFirstChild("RobloxPromptGui") or CoreGui:WaitForChild("RobloxPromptGui", 5)
    if robloxPromptGui then
        local promptOverlay = robloxPromptGui:FindFirstChild("promptOverlay")
        if promptOverlay then
            local function handlePrompt(child)
                if child.Name == "ErrorPrompt" then
                    child.Visible = false
                    promptOverlay.Visible = false
                    
                    if lastAttemptedServerId and serverCards[lastAttemptedServerId] then
                        if serverCards[lastAttemptedServerId].Parent then
                            serverCards[lastAttemptedServerId]:Destroy()
                        end
                        serverCards[lastAttemptedServerId] = nil
                    end

                    local button = child:FindFirstChild("Button", true)
                    if button and button:IsA("TextButton") and getconnections then
                        for _, conn in pairs(getconnections(button.MouseButton1Click)) do
                            conn:Fire()
                        end
                    end

                    if isAutoHopping then
                        Notify("Teleport Error", "Teleport failed. Trying next server...", 2)
                        task.wait(0.5)
                        TriggerAutoHop()
                    else
                        Notify("Teleport Error", "Teleport failed. Try another server.", 3)
                    end
                end
            end

            promptOverlay.ChildAdded:Connect(handlePrompt)
            for _, child in ipairs(promptOverlay:GetChildren()) do
                if child.Name == "ErrorPrompt" then
                    handlePrompt(child)
                end
            end
        end
    end
end)

-- Teleport Logic + Auto Re-queue Script
local function JoinServer(serverId, joinBtn, frame, setAutoHopFlag)
    lastAttemptedServerId = serverId
    if joinBtn then
        joinBtn.Text = "Joining..."
        joinBtn.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
    end

    Notify("Server Finder", "Teleporting to server...", 3)

    if queue_on_teleport then
        pcall(function()
            if setAutoHopFlag then
                getgenv().AUTO_HOP_ACTIVE = true
            else
                getgenv().AUTO_HOP_ACTIVE = false
            end
            queue_on_teleport(function()
                local HttpService = game:GetService("HttpService")
                local TeleportService = game:GetService("TeleportService")
                local Players = game:GetService("Players")
                
                if getgenv().AUTO_HOP_ACTIVE then
                    task.wait(2)
                    local currentPlayers = #Players:GetPlayers()
                    if currentPlayers > 3 then
                        getgenv().AUTO_HOP_ACTIVE = false
                    end
                end
            end)
        end)
    end

    local tpSuccess, _ = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, LocalPlayer)
    end)

    if not tpSuccess then
        if frame and frame.Parent then
            frame:Destroy()
        end
        serverCards[serverId] = nil
        
        if isAutoHopping then
            Notify("Teleport Error", "Failed to join server. Trying another...", 2)
            task.wait(0.5)
            TriggerAutoHop()
        end
    end
end

local function RenderServers(servers)
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    serverCards = {}

    if #servers == 0 then
        Notify("Server Finder", "No available servers found. Tap Refresh to try again.", 4)
        return
    end

    StatusLabel.Visible = false

    for index, server in ipairs(servers) do
        local playing = server.playing or server.players or 0
        local maxPlayers = server.maxPlayers or 12

        local ItemFrame = Instance.new("Frame")
        ItemFrame.Name = server.id
        ItemFrame.Size = UDim2.new(1, -4, 0, 42)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
        ItemFrame.BorderSizePixel = 0
        ItemFrame.LayoutOrder = index
        ItemFrame.Parent = ScrollFrame

        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 6)
        ItemCorner.Parent = ItemFrame

        local InfoLabel = Instance.new("TextLabel")
        InfoLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
        InfoLabel.Position = UDim2.new(0, 8, 0, 3)
        InfoLabel.BackgroundTransparency = 1
        InfoLabel.Text = "Players: " .. tostring(playing) .. "/" .. tostring(maxPlayers)
        InfoLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
        InfoLabel.Font = Enum.Font.SourceSansBold
        InfoLabel.TextSize = 13
        InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
        InfoLabel.Parent = ItemFrame

        local PingLabel = Instance.new("TextLabel")
        PingLabel.Size = UDim2.new(0.6, 0, 0.5, 0)
        PingLabel.Position = UDim2.new(0, 8, 0.5, -2)
        PingLabel.BackgroundTransparency = 1
        PingLabel.Text = "Ping: " .. (server.ping and tostring(server.ping) .. " ms" or "N/A")
        PingLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
        PingLabel.Font = Enum.Font.SourceSans
        PingLabel.TextSize = 11
        PingLabel.TextXAlignment = Enum.TextXAlignment.Left
        PingLabel.Parent = ItemFrame

        local JoinBtn = Instance.new("TextButton")
        JoinBtn.Size = UDim2.new(0, 60, 0, 24)
        JoinBtn.Position = UDim2.new(1, -68, 0.5, -12)
        JoinBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
        JoinBtn.Text = "Join"
        JoinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        JoinBtn.Font = Enum.Font.SourceSansBold
        JoinBtn.TextSize = 12
        JoinBtn.Parent = ItemFrame

        local JoinCorner = Instance.new("UICorner")
        JoinCorner.CornerRadius = UDim.new(0, 4)
        JoinCorner.Parent = JoinBtn

        serverCards[server.id] = ItemFrame

        JoinBtn.MouseButton1Click:Connect(function()
            isAutoHopping = false
            JoinServer(server.id, JoinBtn, ItemFrame, false)
        end)
    end
end

local function RefreshList()
    local now = tick()
    if now - lastFetchTime < FETCH_COOLDOWN then
        local remaining = math.ceil(FETCH_COOLDOWN - (now - lastFetchTime))
        Notify("Server Finder", "Wait " .. tostring(remaining) .. "s before refreshing again...", 2)
        return
    end

    lastFetchTime = tick()
    RefreshBtn.Text = "..."
    Notify("Server Finder", "Fetching server data...", 2)

    task.spawn(function()
        validServersList = GetProcessedServers()
        RenderServers(validServersList)
        RefreshBtn.Text = "Refresh"
        if #validServersList > 0 then
            Notify("Server Finder", "Done fetching server data!", 2)
        end
    end)
end

TriggerAutoHop = function()
    isAutoHopping = true
    AutoHopBtn.Text = "Hopping..."
    AutoHopBtn.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
    Notify("Auto Hop", "Searching for lowest player server...", 3)

    task.spawn(function()
        if #validServersList == 0 then
            validServersList = GetProcessedServers()
        end

        if #validServersList > 0 then
            local targetServer = table.remove(validServersList, 1)
            JoinServer(targetServer.id, nil, nil, true)
        else
            Notify("Auto Hop", "No available servers found. Tap Refresh to try again.", 4)
            AutoHopBtn.Text = "Auto Hop"
            AutoHopBtn.BackgroundColor3 = Color3.fromRGB(142, 68, 173)
            isAutoHopping = false
        end
    end)
end

RefreshBtn.MouseButton1Click:Connect(RefreshList)
AutoHopBtn.MouseButton1Click:Connect(TriggerAutoHop)

RefreshList()

-- Smart Check
if getgenv().AUTO_HOP_ACTIVE then
    task.spawn(function()
        Notify("Auto Hop", "Verifying player count...", 3)
        task.wait(2)
        
        local currentPlayers = #Players:GetPlayers()
        if currentPlayers > MAX_SEPI_THRESHOLD then
            Notify("Auto Hop", "Server has " .. tostring(currentPlayers) .. " players (Too full). Re-hopping...", 3)
            task.wait(1)
            TriggerAutoHop()
        else
            getgenv().AUTO_HOP_ACTIVE = false
            Notify("Auto Hop Success", "Found quiet server! (" .. tostring(currentPlayers) .. " players)", 5)
        end
    end)
end
