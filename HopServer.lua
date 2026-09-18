local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local TargetParent = CoreGui

if TargetParent:FindFirstChild("ServerFinderGui") then
    TargetParent.ServerFinderGui:Destroy()
end

-- ScreenGui Main
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ServerFinderGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = TargetParent

-- Dark Overlay
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

-- Dialog Frame
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

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 310)
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
RefreshBtn.Size = UDim2.new(0, 75, 0, 26)
RefreshBtn.Position = UDim2.new(1, -138, 0.5, -13)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
RefreshBtn.Text = "Refresh"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.Font = Enum.Font.SourceSansBold
RefreshBtn.TextSize = 11
RefreshBtn.Parent = Header

local RefreshCorner = Instance.new("UICorner")
RefreshCorner.CornerRadius = UDim.new(0, 5)
RefreshCorner.Parent = RefreshBtn

local AutoHopBtn = Instance.new("TextButton")
AutoHopBtn.Size = UDim2.new(0, 60, 0, 26)
AutoHopBtn.Position = UDim2.new(1, -203, 0.5, -13)
AutoHopBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
AutoHopBtn.Text = "Auto Hop"
AutoHopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoHopBtn.Font = Enum.Font.SourceSansBold
AutoHopBtn.TextSize = 11
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
local visitedServers = {}
local statusTimer = nil
local isMinimized = false
local isRefreshing = false

local FETCH_COOLDOWN = 3
local lastFetchTime = 0

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

ToggleBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ContentFrame.Visible = not isMinimized
    
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 380, 0, 42)
        MainFrame.Position = UDim2.new(
            MainFrame.Position.X.Scale, 
            MainFrame.Position.X.Offset, 
            MainFrame.Position.Y.Scale, 
            MainFrame.Position.Y.Offset - 134
        )
        ToggleBtn.Text = "+"
    else
        MainFrame.Size = UDim2.new(0, 380, 0, 310)
        MainFrame.Position = UDim2.new(
            MainFrame.Position.X.Scale, 
            MainFrame.Position.X.Offset, 
            MainFrame.Position.Y.Scale, 
            MainFrame.Position.Y.Offset + 134
        )
        ToggleBtn.Text = "-"
    end
end)

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
            return decoded
        end
    end
    return nil
end

local function FetchServersPage(cursor)
    local placeId = game.PlaceId
    local query = "?sortOrder=Asc&limit=100"
    if cursor and cursor ~= "" then
        query = query .. "&cursor=" .. cursor
    end

    local apiEndpoints = {
        "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public" .. query,
        "https://games.roproxy.com/v1/games/" .. placeId .. "/servers/Public" .. query
    }

    for _, url in ipairs(apiEndpoints) do
        local decoded = CustomRequest(url)
        if decoded and decoded.data and #decoded.data > 0 then
            return decoded
        end
    end
    return nil
end

local function GetProcessedServers(maxPages)
    maxPages = maxPages or 6
    local result = {}
    local cursor = nil

    for page = 1, maxPages do
        local response = FetchServersPage(cursor)
        if not response or not response.data then break end

        for _, s in ipairs(response.data) do
            local playingCount = s.playing or s.players or 0
            local maxCapacity = s.maxPlayers or 12
            
            if playingCount >= 1 and playingCount < maxCapacity and s.id ~= game.JobId and not visitedServers[s.id] then
                table.insert(result, s)
            end
        end

        cursor = response.nextPageCursor
        if not cursor or cursor == "" then break end
    end

    table.sort(result, function(a, b)
        return (a.playing or 0) < (b.playing or 0)
    end)

    return result
end

local function JoinServer(serverId, joinBtn, frame)
    visitedServers[serverId] = true

    if joinBtn then
        joinBtn.Text = "Joining..."
        joinBtn.BackgroundColor3 = Color3.fromRGB(230, 126, 34)
    end

    Notify("Server Finder", "Teleporting to server...", 3)

    local tpSuccess, tpErr = pcall(function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, serverId, LocalPlayer)
    end)

    if not tpSuccess then
        if frame and frame.Parent then
            frame:Destroy()
        end
        serverCards[serverId] = nil
        Notify("Teleport Error", "Failed to join server. Try another.", 2)
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
        Notify("Server Finder", "No available servers found. Tap Refresh to try again.", 3)
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
            JoinServer(server.id, JoinBtn, ItemFrame)
        end)
    end
end

local function RefreshList()
    if isRefreshing then return end
    
    local now = tick()
    if now - lastFetchTime < FETCH_COOLDOWN then return end

    isRefreshing = true
    lastFetchTime = tick()
    RefreshBtn.Text = "Scanning..."
    Notify("Server Finder", "Fast scanning 6 pages (~600 servers)...", 2)

    task.spawn(function()
        validServersList = GetProcessedServers(6)
        RenderServers(validServersList)
        
        if #validServersList > 0 then
            Notify("Server Finder", "Found " .. tostring(#validServersList) .. " low-player servers!", 2)
        end

        for i = FETCH_COOLDOWN, 1, -1 do
            RefreshBtn.Text = "Wait (" .. tostring(i) .. "s)"
            task.wait(1)
        end
        
        RefreshBtn.Text = "Refresh"
        isRefreshing = false
    end)
end

local function AutoHop()
    Notify("Auto Hop", "Searching lowest player server...", 2)
    task.spawn(function()
        local servers = GetProcessedServers(6)
        if #servers > 0 then
            local targetServer = servers[1]
            JoinServer(targetServer.id)
        else
            Notify("Auto Hop", "No low player server found.", 3)
        end
    end)
end

RefreshBtn.MouseButton1Click:Connect(RefreshList)
AutoHopBtn.MouseButton1Click:Connect(AutoHop)

RefreshList()
