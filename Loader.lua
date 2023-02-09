
_G.Settings = {
	UI = {
		Color = Color3.fromRGB(35,35,35),
		Logo = "12258186601",
	},
}

_G.Color = _G.Settings.UI.Color or Color3.fromRGB(255, 0, 0)
local LogoUI = _G.Settings.Logo or "12258186601"

do  local ui =  game:GetService("CoreGui").RobloxGui.Modules.Profile:FindFirstChild("G3LIB")  if ui then ui:Destroy() end end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

getgenv().UiSettings = {
    Key = Enum.KeyCode.RightControl,
}

local function Tween(instance, properties,style,wa)
	if style == nil or "" then
		return Back
	end
	tween:Create(instance,TweenInfo.new(wa,Enum.EasingStyle[style]),{properties}):Play()
end

local ActualTypes = {
	RoundFrame = "ImageLabel",
	Shadow = "ImageLabel",
	Circle = "ImageLabel",
	CircleButton = "ImageButton",
	Frame = "Frame",
	Label = "TextLabel",
	Button = "TextButton",
	SmoothButton = "ImageButton",
	Box = "TextBox",
	ScrollingFrame = "ScrollingFrame",
	Menu = "ImageButton",
	NavBar = "ImageButton"
}

local Properties = {
	RoundFrame = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	SmoothButton = {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	Shadow = {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554236805",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(23,23,277,277),
		Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
		Position = UDim2.fromOffset(-15,-15)
	},
	Circle = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	CircleButton = {
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	Frame = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1,1)
	},
	Label = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Button = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Box = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	ScrollingFrame = {
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.fromScale(0,0),
		Size = UDim2.fromScale(1,1)
	},
	Menu = {
		Name = "More",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5555108481",
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
	},
	NavBar = {
		Name = "SheetToggle",
		Image = "http://www.roblox.com/asset/?id=5576439039",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromOffset(5,5),
		AutoButtonColor = false
	}
}

local Types = {
	"RoundFrame",
	"Shadow",
	"Circle",
	"CircleButton",
	"Frame",
	"Label",
	"Button",
	"SmoothButton",
	"Box",
	"ScrollingFrame",
	"Menu",
	"NavBar"
}

function FindType(String)
	for _, Type in next, Types do
		if Type:sub(1, #String):lower() == String:lower() then
			return Type
		end
	end
	return false
end

local Objects = {}

function Objects.new(Type)
	local TargetType = FindType(Type)
	if TargetType then
		local NewImage = Instance.new(ActualTypes[TargetType])
		if Properties[TargetType] then
			for Property, Value in next, Properties[TargetType] do
				NewImage[Property] = Value
			end
		end
		return NewImage
	else
		return Instance.new(Type)
	end
end

local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Objects.new("Circle")
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(0.4), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(0.4)
		Circle:Destroy()
	end)
end


local function Tween(instance, properties,style,wa)
    if style == nil or "" then
        return Back
    end
    tween:Create(instance,TweenInfo.new(wa,Enum.EasingStyle[style]),{properties}):Play()
end

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil	
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
        Tween:Play()
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                input.UserInputType == Enum.UserInputType.Touch
            then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end





local G3LIB = Instance.new("ScreenGui")

G3LIB.Name = "G3LIB"
G3LIB.Parent = game:GetService("CoreGui").RobloxGui.Modules.Profile
G3LIB.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Ui = {}

function Ui:Window(text) 
    local Main = Instance.new("Frame")
    local Top = Instance.new("Frame")
    local UICorner_Top = Instance.new("UICorner")
    local Logo = Instance.new("ImageLabel")
    local NameHub = Instance.new("TextLabel")
    local ScrollingFrameTab = Instance.new("ScrollingFrame")
    local UIListLayoutTab = Instance.new("UIListLayout")
    local ImageSetting = Instance.new("ImageLabel")
    local UICorner_Setting = Instance.new("UICorner")
    local ButtonSetttings = Instance.new("TextButton")
    local UICorner_Main = Instance.new("UICorner")
    local SettingFrame = Instance.new("Frame")
    local ScrollingFrameSetting = Instance.new("ScrollingFrame")
    local UIListLayoutSetting = Instance.new("UIListLayout")
    local KeyBindUi = Instance.new("TextLabel")
    local Container_Page = Instance.new("Frame")
    local PageFolder = Instance.new("Folder")
    local UIPageLayout = Instance.new("UIPageLayout")
    local toggonsetting = false
    local FocusUi = false

    Main.Name = "Main"
    Main.Parent = G3LIB
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.ClipsDescendants = true
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.AnchorPoint = Vector2.new(0.5,0.5)
    
    TweenService:Create(Main,TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.new(0, 600, 0, 400)}):Play()

    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Top.Size = UDim2.new(0, 600, 0, 40)

    UICorner_Top.CornerRadius = UDim.new(0, 4)
    UICorner_Top.Name = "UICorner_Top"
    UICorner_Top.Parent = Top

    Logo.Name = "Logo"
    Logo.Parent = Top
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1.000
    Logo.Position = UDim2.new(0.00999999978, 0, 0.075000003, 0)
    Logo.Size = UDim2.new(0, 34, 0, 34)
    Logo.Image = "http://www.roblox.com/asset/?id="..LogoUI

    NameHub.Name = "NameHub"
    NameHub.Parent = Top
    NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameHub.BackgroundTransparency = 1.000
    NameHub.Position = UDim2.new(0, 45, 0, 6)
    NameHub.Size = UDim2.new(0, 83, 0, 37)
    NameHub.Font = Enum.Font.GothamBold
    NameHub.Text = text
    NameHub.TextColor3 = Color3.fromRGB(236, 236, 236)
    NameHub.TextSize = 16.000
    NameHub.TextXAlignment = Enum.TextXAlignment.Left

    ScrollingFrameTab.Parent = Top
    ScrollingFrameTab.Active = true
    ScrollingFrameTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrameTab.BackgroundTransparency = 1.000
    ScrollingFrameTab.Position = UDim2.new(0.27700001, 0, 0.25, 0)
    ScrollingFrameTab.Size = UDim2.new(0, 345, 0, 23)
    ScrollingFrameTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrameTab.ScrollBarThickness = 0

    
    UIListLayoutTab.Parent = ScrollingFrameTab
    UIListLayoutTab.FillDirection = Enum.FillDirection.Horizontal
    UIListLayoutTab.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayoutTab.Padding = UDim.new(0, 5)
    
    UICorner_Main.CornerRadius = UDim.new(0, 4)
    UICorner_Main.Name = "UICorner_Main"
    UICorner_Main.Parent = Main

    local BackSettingFrame = Instance.new("Frame")

    BackSettingFrame.Name = "BackSettingFrame"
    BackSettingFrame.Parent = Main
    BackSettingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    BackSettingFrame.BackgroundTransparency = 0.45
    BackSettingFrame.BorderSizePixel = 0
    BackSettingFrame.ClipsDescendants = true
    BackSettingFrame.Position = UDim2.new(0, 0, 0.0571428575, 0)
    BackSettingFrame.Size = UDim2.new(0, 0, 0, 440)
    BackSettingFrame.ZIndex = 2

    SettingFrame.Name = "SettingFrame"
    SettingFrame.Parent = Main
    SettingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SettingFrame.BackgroundTransparency = 0
    SettingFrame.BorderSizePixel = 0
    SettingFrame.ClipsDescendants = true
    SettingFrame.Position = UDim2.new(0, 0, 0.0571428575, 2)
    SettingFrame.Size = UDim2.new(0, 0, 0, 440)
    SettingFrame.ZIndex = 3

    local SettingFrameE = Instance.new("Frame")

    SettingFrameE.Name = "SettingFrameE"
    SettingFrameE.Parent = SettingFrame
    SettingFrameE.BackgroundColor3 = Color3.fromRGB(255, 25, 25)
    SettingFrameE.BackgroundTransparency = 1
    SettingFrameE.BorderSizePixel = 0
    SettingFrameE.ClipsDescendants = true
    SettingFrameE.Position = UDim2.new(0, 0, 0, 2)
    SettingFrameE.Size = UDim2.new(0, 255, 0, 614)

    ScrollingFrameSetting.Name = "ScrollingFrameSetting"
    ScrollingFrameSetting.Parent = SettingFrameE
    ScrollingFrameSetting.Active = true
    ScrollingFrameSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrameSetting.BackgroundTransparency = 1.000
    ScrollingFrameSetting.BorderSizePixel = 0
    ScrollingFrameSetting.Size = UDim2.new(0, 0, 0, 440)
    ScrollingFrameSetting.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrameSetting.ScrollBarThickness = 4
    ScrollingFrameSetting.ClipsDescendants = true

    UIListLayoutSetting.Name = "UIListLayoutSetting"
    UIListLayoutSetting.Parent = ScrollingFrameSetting
    UIListLayoutSetting.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayoutSetting.Padding = UDim.new(0, 10)



    KeyBindUi.Name = "KeyBindUi"
    KeyBindUi.Parent = SettingFrame
    KeyBindUi.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    KeyBindUi.BackgroundTransparency = 1.000
    KeyBindUi.Position = UDim2.new(-0.00392156886, 0, 0.943939388, 0)
    KeyBindUi.Size = UDim2.new(0, 255, 0, 27)
    KeyBindUi.Font = Enum.Font.GothamBold
    KeyBindUi.Text = "[ Right Control ]"
    KeyBindUi.TextColor3 = Color3.fromRGB(222, 222, 222)
    KeyBindUi.TextSize = 14.000
    KeyBindUi.ZIndex = 4

    Container_Page.Name = "Container_Page"
    Container_Page.Parent = Main
    Container_Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Container_Page.BackgroundTransparency = 1.000
    Container_Page.ClipsDescendants = true
    Container_Page.Position = UDim2.new(0.0266666673, 0, 0.0842857137, 0)
    Container_Page.Size = UDim2.new(0, 567, 0, 621)

    PageFolder.Name = "PageFolder"
    PageFolder.Parent = Container_Page

    UIPageLayout.Parent = PageFolder
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.Padding = UDim.new(0.5, 0)
    UIPageLayout.TweenTime = 0.500

    local ButtonKeybind = Instance.new("TextButton")

    ButtonKeybind.Name = "ButtonKeybind"
    ButtonKeybind.Parent = SettingFrame
    ButtonKeybind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ButtonKeybind.Position = UDim2.new(-0.00392156886, 0, 0.943939388, 0)
    ButtonKeybind.BackgroundTransparency = 1.000
    ButtonKeybind.Size = UDim2.new(0, 255, 0, 27)
    ButtonKeybind.Font = Enum.Font.SourceSans
    ButtonKeybind.Text = ""
    ButtonKeybind.TextColor3 = Color3.fromRGB(0, 0, 0)
    ButtonKeybind.TextSize = 14.000

    
    ButtonKeybind.MouseButton1Click:Connect(function()
        KeyBindUi.Text = "[ Select Key ]"
        local inputwait = UserInputService.InputBegan:wait()
        if inputwait.KeyCode.Name ~= "Unknown" then
            getgenv().UiSettings.Key = inputwait.KeyCode
            KeyBindUi.Text = "[ " .. getgenv().UiSettings.Key.Name .." ] "

            Key = inputwait.KeyCode.Name
        end
    end)
    local uitoggled = false
    UserInputService.InputBegan:Connect(function(io, p)
        if io.KeyCode == getgenv().UiSettings.Key then
            if uitoggled == false then
                uitoggled = true
                TweenService:Create(
                    Main,
                    TweenInfo.new(.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
                    {Size = UDim2.new(0, 0, 0, 0)}
                ):Play()
            else
                TweenService:Create(
                    Main,
                    TweenInfo.new(.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 600, 0, 400)}
                ):Play()
                repeat wait() until Main.Size == UDim2.new(0, 600, 0, 400)
                uitoggled = false
            end
        end
    end)

    MakeDraggable(Top,Main)
    game:GetService("RunService").Stepped:Connect(function()
        pcall(function()
            ScrollingFrameTab.CanvasSize =  UDim2.new(0,UIListLayoutTab.AbsoluteContentSize.X +10,0,0)
            ScrollingFrameSetting.CanvasSize =  UDim2.new(0, 0, 0,UIListLayoutSetting.AbsoluteContentSize.Y + 10)
        end)
    end)

    function SettingsLabel(text)
        local LabelFrameSetting = Instance.new("Frame")
        local LabelSetting = Instance.new("TextLabel")
        local ReturnLabelSet = {}

        LabelFrameSetting.Name = "LabelFrameSetting"
        LabelFrameSetting.Parent = ScrollingFrameSetting
        LabelFrameSetting.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
        LabelFrameSetting.BackgroundTransparency = 1.000
        LabelFrameSetting.Size = UDim2.new(0, 255, 0, 38)
        
        LabelSetting.Name = "LabelSetting"
        LabelSetting.Parent = LabelFrameSetting
        LabelSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelSetting.BackgroundTransparency = 1.000
        LabelSetting.Position = UDim2.new(0.0235294141, 0, 0, 0)
        LabelSetting.Size = UDim2.new(0, 245, 0, 38)
        LabelSetting.Font = Enum.Font.GothamBold
        LabelSetting.Text = text
        LabelSetting.TextColor3 = Color3.fromRGB(255, 255, 255)
        LabelSetting.TextSize = 14.000
        LabelSetting.TextXAlignment = Enum.TextXAlignment.Left

        function ReturnLabelSet:SetUpdate(newtext)
            LabelSetting.Text = newtext
        end
        
        return ReturnLabelSet
    end
    function SettingsToggle(text,default,callback)
        local ToggleFrameSetting = Instance.new("Frame")
        local TgleFrameSetting = Instance.new("Frame")
        local UICornerTgleSetting = Instance.new("UICorner")
        local Tgle = Instance.new("ImageLabel")
        local TgleSetting = Instance.new("TextLabel")
        local ToggleSetting = Instance.new("TextButton")
        local ToggleSet_UIStroke = Instance.new("UIStroke")
        local ToggleSet = false
        local lockerset = true
        local checkfirsttimeset = true 

        
        if default == nil then default = false end

        ToggleFrameSetting.Name = "ToggleFrameSetting"
        ToggleFrameSetting.Parent = ScrollingFrameSetting
        ToggleFrameSetting.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
        ToggleFrameSetting.BackgroundTransparency = 1.000
        ToggleFrameSetting.Size = UDim2.new(0, 255, 0, 26)

        TgleFrameSetting.Name = "TgleFrameSetting"
        TgleFrameSetting.Parent = ToggleFrameSetting
        TgleFrameSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TgleFrameSetting.BackgroundTransparency = 1.000
        TgleFrameSetting.BorderSizePixel = 0
        TgleFrameSetting.ClipsDescendants = true
        TgleFrameSetting.Position = UDim2.new(0.0239999816, 0, 0, 0)
        TgleFrameSetting.Size = UDim2.new(0, 26, 0, 26)

        UICornerTgleSetting.CornerRadius = UDim.new(0, 3)
        UICornerTgleSetting.Name = "UICornerTgleSetting"
        UICornerTgleSetting.Parent = TgleFrameSetting

        ToggleSet_UIStroke.Thickness = 1
        ToggleSet_UIStroke.Name = ""
        ToggleSet_UIStroke.Parent = TgleFrameSetting
        ToggleSet_UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        ToggleSet_UIStroke.LineJoinMode = Enum.LineJoinMode.Round
        ToggleSet_UIStroke.Color = _G.Color
        ToggleSet_UIStroke.Transparency = 0

        Tgle.Name = "Tgle"
        Tgle.Parent = TgleFrameSetting
        Tgle.AnchorPoint = Vector2.new(0.5, 0.5)
        Tgle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tgle.BackgroundTransparency = 1.000
        Tgle.Position = UDim2.new(0.512559988, 0, 0.514999986, 0)
        Tgle.Size = UDim2.new(0, 0, 0, 0)
        Tgle.Image = "rbxassetid://6031068421"
        Tgle.ImageColor3 = _G.Color

        TgleSetting.Name = "TgleSetting"
        TgleSetting.Parent = ToggleFrameSetting
        TgleSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TgleSetting.BackgroundTransparency = 1.000
        TgleSetting.Position = UDim2.new(0.164705887, 0, 0, 0)
        TgleSetting.Size = UDim2.new(0, 197, 0, 26)
        TgleSetting.Font = Enum.Font.GothamBold
        TgleSetting.Text = "Toggle  Bypass"
        TgleSetting.TextColor3 = Color3.fromRGB(255, 255, 255)
        TgleSetting.TextSize = 14.000
        TgleSetting.TextXAlignment = Enum.TextXAlignment.Left

        ToggleSetting.Name = "ToggleSetting"
        ToggleSetting.Parent = ToggleFrameSetting
        ToggleSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleSetting.BackgroundTransparency = 1.000
        ToggleSetting.Size = UDim2.new(0, 255, 0, 26)
        ToggleSetting.Font = Enum.Font.SourceSans
        ToggleSetting.Text = ""
        ToggleSetting.TextColor3 = Color3.fromRGB(0, 0, 0)
        ToggleSetting.TextSize = 14.000


        ToggleSetting.MouseButton1Click:Connect(function()
            if ToggleSet == false and lockerset == true then
                ToggleSet = true
                TweenService:Create(
                    Tgle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 0, 0)}
                ):Play()
                callback(false)
            elseif ToggleSet == true and lockerset == true then
                ToggleSet = false
                TweenService:Create(
                    Tgle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 29, 0, 28)}
                ):Play()
                callback(true)
            end 
        end)

        if default == true then
            ToggleSet = false
            TweenService:Create(
                Tgle,
                TweenInfo.new(0.2, Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 29, 0, 28)}
            ):Play()
            callback(true)
        end

        local LockerFrame = Instance.new("Frame")
        local LockIcon = Instance.new("ImageLabel")
        local togglesetfunc = {}


        LockerFrame.Name = "LockerFrame"
        LockerFrame.Parent = ToggleFrameSetting
        LockerFrame.Active = true
        LockerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        LockerFrame.BackgroundTransparency = 0.200
        LockerFrame.BorderSizePixel = 0
        LockerFrame.ClipsDescendants = true
        LockerFrame.Position = UDim2.new(0, 0, -0.053222228, 0)
        LockerFrame.Size = UDim2.new(0, 255, 0, 35)
        LockerFrame.BackgroundTransparency = 1

        LockIcon.Name = "LockIcon"
        LockIcon.Parent = LockerFrame
        LockIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        LockIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LockIcon.BackgroundTransparency = 1.000
        LockIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        LockIcon.Size = UDim2.new(0, 0, 0, 0)
        LockIcon.Image = "http://www.roblox.com/asset/?id=3926305904"
        LockIcon.ImageRectOffset = Vector2.new(404, 364)
        LockIcon.ImageRectSize = Vector2.new(36, 36)
        LockIcon.ImageColor3 = Color3.fromRGB(255,25,25)

                        
        function togglesetfunc:StatsTrue()
            if (ToggleSet == true and lockerset == true) or checkfirsttimeset == true then
                checkfirsttimeset = false
                ToggleSet = false
                TweenService:Create(
                    Tgle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 29, 0, 28)}
                ):Play()
                callback(true)
            end
        end
        
        function togglesetfunc:StatsFalse()
            if ToggleSet == false and lockerset == true then
                ToggleSet = true
                TweenService:Create(
                    Tgle,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {Size = UDim2.new(0, 0, 0, 0)}
                ):Play()
                callback(false)
            end
        end

        function togglesetfunc:Lock()
            lockerset = false
            TweenService:Create(
                LockerFrame,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                {BackgroundTransparency = 0.45}
            ):Play()
            wait()
            TweenService:Create(
                LockIcon,
                TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out,0.1),
                {Size = UDim2.new(0, 25, 0, 25)}
            ):Play()
        end
        function togglesetfunc:Unlock()
            lockerset = true
            TweenService:Create(
                LockerFrame,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                {BackgroundTransparency = 1}
            ):Play()
            wait()
            TweenService:Create(
                LockIcon,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                {Size = UDim2.new(0, 0, 0, 0)}
            ):Play()
        end
        return togglesetfunc
    end

    function SettingsButton(text,callback)
        local ButtonFrameSetting = Instance.new("Frame")
        local BtnFrameSetting = Instance.new("Frame")
        local UICornerBtnSetting = Instance.new("UICorner")
        local BtnSetting = Instance.new("TextLabel")
        local ButtonSetting = Instance.new("TextButton")

        ButtonFrameSetting.Name = "ButtonFrameSetting"
        ButtonFrameSetting.Parent = ScrollingFrameSetting
        ButtonFrameSetting.BackgroundColor3 = Color3.fromRGB(122, 122, 122)
        ButtonFrameSetting.BackgroundTransparency = 1.000
        ButtonFrameSetting.Size = UDim2.new(0, 255, 0, 26)
        

        BtnFrameSetting.Name = "BtnFrameSetting"
        BtnFrameSetting.Parent = ButtonFrameSetting
        BtnFrameSetting.BackgroundColor3 = _G.Color
        BtnFrameSetting.BorderSizePixel = 0
        BtnFrameSetting.Position = UDim2.new(0.0240000002, 0, 0, 0)
        BtnFrameSetting.Size = UDim2.new(0, 239, 0, 26)
        BtnFrameSetting.ClipsDescendants = true

        UICornerBtnSetting.CornerRadius = UDim.new(0, 3)
        UICornerBtnSetting.Name = "UICornerBtnSetting"
        UICornerBtnSetting.Parent = BtnFrameSetting

        BtnSetting.Name = "BtnSetting"
        BtnSetting.Parent = BtnFrameSetting
        BtnSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        BtnSetting.BackgroundTransparency = 1.000
        BtnSetting.Size = UDim2.new(0, 239, 0, 26)
        BtnSetting.Font = Enum.Font.GothamBold
        BtnSetting.Text = text
        BtnSetting.TextColor3 = Color3.fromRGB(255, 255, 255)
        BtnSetting.TextSize = 14.000


        ButtonSetting.Name = "ButtonSetting"
        ButtonSetting.Parent = ButtonFrameSetting
        ButtonSetting.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ButtonSetting.BackgroundTransparency = 1.000
        ButtonSetting.Size = UDim2.new(0, 255, 0, 26)
        ButtonSetting.Font = Enum.Font.SourceSans
        ButtonSetting.Text = ""
        ButtonSetting.TextColor3 = Color3.fromRGB(0, 0, 0)
        ButtonSetting.TextSize = 14.000

        ButtonSetting.MouseButton1Click:Connect(function()
            if toggonsetting == true then
                CircleAnim(BtnFrameSetting, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
                BtnSetting.TextSize = 0
                TweenService:Create(
                    BtnSetting,
                    TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {TextSize = 14}
                ):Play()
                callback()   
            end
        end)
    end
    local Tab = {}
    function Tab:CraftTab(text)
        local name = tostring(text) or tostring(math.random(1,5000))
        local TabFrame = Instance.new("Frame")
        local TabUICorner = Instance.new("UICorner")
        local LabelTab = Instance.new("TextLabel")
        local TextTab = Instance.new("TextButton")
        local PageMain = Instance.new("Frame")
        local PageMainUICorner = Instance.new("UICorner")
        local G3 = false

        TabFrame.Name = "TabFrame"
        TabFrame.Parent = ScrollingFrameTab
        TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TabFrame.ClipsDescendants = true
        TabFrame.Size = UDim2.new(0, 100, 0, 24)
    
        TabUICorner.CornerRadius = UDim.new(0, 4)
        TabUICorner.Name = "TabUICorner"
        TabUICorner.Parent = TabFrame
    
        LabelTab.Name = "LabelTab"
        LabelTab.Parent = TabFrame
        LabelTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        LabelTab.BackgroundTransparency = 1.000
        LabelTab.Size = UDim2.new(0, 100, 0, 24)
        LabelTab.Font = Enum.Font.GothamBold
        LabelTab.Text = text
        LabelTab.TextColor3 = Color3.fromRGB(255, 255, 255)
        LabelTab.TextSize = 13.000
    
        TextTab.Name = text.."Server"
        TextTab.Parent = TabFrame
        TextTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextTab.BackgroundTransparency = 1.000
        TextTab.Size = UDim2.new(0, 100, 0, 24)
        TextTab.Font = Enum.Font.SourceSans
        TextTab.Text = ""
        TextTab.TextColor3 = Color3.fromRGB(0, 0, 0)
        TextTab.TextSize = 14.000

        local PageMain = Instance.new("Frame")
        local PageMainUICorner = Instance.new("UICorner")
        local Scrolling_PageMain = Instance.new("ScrollingFrame")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local Pageleft = Instance.new("Frame")
        local UIListLayout_Pageleft = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")
        local Pageright = Instance.new("Frame")
        local UIListLayout_Pageright = Instance.new("UIListLayout")
        local UIPaddingSetting = Instance.new("UIPadding")

        PageMain.Name = "PageMain"
        PageMain.Parent = PageFolder
        PageMain.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        PageMain.ClipsDescendants = true
        PageMain.Position = UDim2.new(0.00529100513, 0, 0.00161030598, 0)
        PageMain.Size = UDim2.new(0, 567, 0, 415)
        
        PageMainUICorner.CornerRadius = UDim.new(0, 4)
        PageMainUICorner.Name = "PageMainUICorner"
        PageMainUICorner.Parent = PageMain
        
        Scrolling_PageMain.Name = "Scrolling_PageMain"
        Scrolling_PageMain.Parent = PageMain
        Scrolling_PageMain.Active = true
        Scrolling_PageMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Scrolling_PageMain.BackgroundTransparency = 1.000
        Scrolling_PageMain.BorderSizePixel = 0
        Scrolling_PageMain.Size = UDim2.new(0, 567, 0, 415)
        Scrolling_PageMain.CanvasSize = UDim2.new(0, 0, 0, 0)
        Scrolling_PageMain.ScrollBarThickness = 4
        
        UIListLayout_2.Parent = Scrolling_PageMain
        UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
        UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_2.Padding = UDim.new(0, 5)
        
        Pageleft.Name = "Pageleft"
        Pageleft.Parent = Scrolling_PageMain
        Pageleft.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Pageleft.BackgroundTransparency = 1
        Pageleft.BorderSizePixel = 0
        Pageleft.ClipsDescendants = true
        Pageleft.Size = UDim2.new(0, 274, 0, 385)
        
        UIListLayout_Pageleft.Name = "UIListLayout_Pageleft"
        UIListLayout_Pageleft.Parent = Pageleft
        UIListLayout_Pageleft.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_Pageleft.Padding = UDim.new(0, 10)

        UIPadding.Parent = Scrolling_PageMain
        UIPadding.PaddingLeft = UDim.new(0, 7)
        UIPadding.PaddingTop = UDim.new(0, 8)

        Pageright.Name = "Pageright"
        Pageright.Parent = Scrolling_PageMain
        Pageright.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Pageright.BackgroundTransparency = 1
        Pageright.BorderSizePixel = 0
        Pageright.ClipsDescendants = true
        Pageright.Size = UDim2.new(0, 274, 0, 385)

        UIListLayout_Pageright.Name = "UIListLayout_Pageleft"
        UIListLayout_Pageright.Parent = Pageright
        UIListLayout_Pageright.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout_Pageright.Padding = UDim.new(0, 10)

        UIPaddingSetting.Name = "UIPaddingSetting"
        UIPaddingSetting.Parent = ScrollingFrameSetting
        UIPaddingSetting.PaddingTop = UDim.new(0, 10)


        game:GetService("RunService").Stepped:Connect(function()
            Pageleft.Size = UDim2.new(0, 274, 0, UIListLayout_Pageleft.AbsoluteContentSize.Y + 5)
        end)
        game:GetService("RunService").Stepped:Connect(function()
            Pageright.Size = UDim2.new(0, 274, 0, UIListLayout_Pageright.AbsoluteContentSize.Y + 5)
        end)

        game:GetService("RunService").Stepped:Connect(function()
            if UIListLayout_Pageleft.AbsoluteContentSize.Y > UIListLayout_Pageright.AbsoluteContentSize.Y then
                Scrolling_PageMain.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_Pageleft.AbsoluteContentSize.Y + 10)
            end
        end)
        game:GetService("RunService").Stepped:Connect(function()
            if UIListLayout_Pageright.AbsoluteContentSize.Y > UIListLayout_Pageleft.AbsoluteContentSize.Y then
                Scrolling_PageMain.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_Pageright.AbsoluteContentSize.Y + 10)
            end
        end)
        TextTab.MouseButton1Click:Connect(function()
            CircleAnim(TabFrame, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
            LabelTab.TextSize = 0
            TweenService:Create(
                LabelTab,
                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {TextSize = 13}
            ):Play()
            for i,v in next, PageFolder:GetChildren() do 
                if PageMain.Name == "PageMain" then
                    UIPageLayout:JumpTo(PageMain)
                end
            end
        end)

		if FocusUi == false then
            UIPageLayout:JumpToIndex(1)
			FocusUi = true
		end


        local Page = {}
        function Page:CraftPage(text,Type)
            local Page = Instance.new("Frame")
            local UICorner_Page = Instance.new("UICorner")
            local PageFrame = Instance.new("Frame")
            local TextPage = Instance.new("TextLabel")
            local UIListLayout_Page = Instance.new("UIListLayout")
            local function GetType(value)
                if value == 1 then
                    return Pageleft
                elseif value == 2 then
                    return Pageright
                else
                    return Pageleft
                end
            end   

            Page.Name = "Page"
            Page.Parent = GetType(Type)
            Page.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Page.Size = UDim2.new(0, 274, 0, 385)
            Page.Visible = true
            Page.ClipsDescendants = true

            UICorner_Page.CornerRadius = UDim.new(0, 4)
            UICorner_Page.Name = "UICorner_Page"
            UICorner_Page.Parent = Page

            PageFrame.Name = "PageFrame"
            PageFrame.Parent = Page
            PageFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            PageFrame.BackgroundTransparency = 1.000
            PageFrame.Size = UDim2.new(0, 274, 0, 24)

            TextPage.Name = "TextPage"
            TextPage.Parent = PageFrame
            TextPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextPage.BackgroundTransparency = 1.000
            TextPage.BorderSizePixel = 0
            TextPage.Position = UDim2.new(0.0401459858, 0, 0.0978244171, 0)
            TextPage.Size = UDim2.new(0, 251, 0, 19)
            TextPage.Font = Enum.Font.GothamBold
            TextPage.Text = text
            TextPage.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextPage.TextSize = 13.000
            TextPage.TextXAlignment = Enum.TextXAlignment.Left

            UIListLayout_Page.Name = "UIListLayout_Page"
            UIListLayout_Page.Parent = Page
            UIListLayout_Page.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_Page.Padding = UDim.new(0, 5)

            game:GetService("RunService").Stepped:Connect(function()
                Page.Size =  UDim2.new(0, 274, 0,UIListLayout_Page.AbsoluteContentSize.Y + 15)
            end)
            local Item = {}
            function Item:Button(text,callback)

                local Btn = Instance.new("Frame")
                local Button = Instance.new("Frame")
                local TextButton = Instance.new("TextLabel")
                local UICorner_Button = Instance.new("UICorner")
                local Buttonn = Instance.new("TextButton")
                
                Btn.Name = "Btn"
                Btn.Parent = Page
                Btn.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
                Btn.BackgroundTransparency = 1
                Btn.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Btn.Position = UDim2.new(0, 0, 0.0562913902, 0)
                Btn.Size = UDim2.new(0, 274, 0, 28)

                Button.Name = "Button"
                Button.Parent = Btn
                Button.AnchorPoint = Vector2.new(0.5, 0.5)
                Button.BackgroundColor3 = _G.Color
                Button.BorderSizePixel = 0
                Button.ClipsDescendants = true
                Button.Position = UDim2.new(0.5, 0, 0.5, 0)
                Button.Size = UDim2.new(0, 262, 0, 24)

                TextButton.Name = "TextButton"
                TextButton.Parent = Button
                TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextButton.BackgroundTransparency = 1.000
                TextButton.Size = UDim2.new(0, 262, 0, 24)
                TextButton.Font = Enum.Font.GothamBold
                TextButton.Text = text
                TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextButton.TextSize = 14.000

                UICorner_Button.CornerRadius = UDim.new(0, 4)
                UICorner_Button.Name = "UICorner_Button"
                UICorner_Button.Parent = Button


                Buttonn.Name = "Button"
                Buttonn.Parent = Btn
                Buttonn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Buttonn.BackgroundTransparency = 1.000
                Buttonn.Size = UDim2.new(0, 274, 0, 28)
                Buttonn.Font = Enum.Font.SourceSans
                Buttonn.Text = ""
                Buttonn.TextColor3 = Color3.fromRGB(0, 0, 0)
                Buttonn.TextSize = 14.000

                Buttonn.MouseButton1Click:Connect(function()
                    if toggonsetting == false then
                        CircleAnim(Button, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
                        TextButton.TextSize = 0
                        TweenService:Create(
                            TextButton,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {TextSize = 14}
                        ):Play()
                        callback()   
                        TweenService:Create(
                            Button,
                            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 270, 0, 20)}
                        ):Play()
                        wait(0.1)
                        TweenService:Create(
                            Button,
                            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 262, 0, 24)}
                        ):Play()
                    end  
                end)
            end
            function Item:Slider(text,floor,min,max,de,callback)
                local SliderFrame = Instance.new("Frame")
                local LabelNameSlider = Instance.new("TextLabel")
                local ShowValueFrame = Instance.new("Frame")
                local CustomValue = Instance.new("TextBox")
                local ShowValueFrameUICorner = Instance.new("UICorner")
                local ValueFrame = Instance.new("Frame")
                local ValueFrameUICorner = Instance.new("UICorner")
                local PartValue = Instance.new("Frame")
                local PartValueUICorner = Instance.new("UICorner")
                local MainValue = Instance.new("Frame")
                local MainValueUICorner = Instance.new("UICorner")
                local sliderfunc = {}

                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = Page
                SliderFrame.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
                SliderFrame.Position = UDim2.new(0.109489053, 0, 0.708609283, 0)
                SliderFrame.Size = UDim2.new(0, 274, 0, 54)
                SliderFrame.BackgroundTransparency = 1.000

                LabelNameSlider.Name = "LabelNameSlider"
                LabelNameSlider.Parent = SliderFrame
                LabelNameSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelNameSlider.BackgroundTransparency = 1.000
                LabelNameSlider.Position = UDim2.new(0.0729926974, 0, 0.0396823473, 0)
                LabelNameSlider.Size = UDim2.new(0, 182, 0, 25)
                LabelNameSlider.Font = Enum.Font.GothamBold
                LabelNameSlider.Text = tostring(text)
                LabelNameSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                LabelNameSlider.TextSize = 14.000
                LabelNameSlider.TextXAlignment = Enum.TextXAlignment.Left

                ShowValueFrame.Name = "ShowValueFrame"
                ShowValueFrame.Parent = SliderFrame
                ShowValueFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ShowValueFrame.Position = UDim2.new(0.733576655, 0, 0.0656082779, 0)
                ShowValueFrame.Size = UDim2.new(0, 58, 0, 21)

                CustomValue.Name = "CustomValue"
                CustomValue.Parent = ShowValueFrame
                CustomValue.AnchorPoint = Vector2.new(0.5, 0.5)
                CustomValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                CustomValue.BackgroundTransparency = 1.000
                CustomValue.Position = UDim2.new(0.5, 0, 0.5, 0)
                CustomValue.Size = UDim2.new(0, 55, 0, 21)
                CustomValue.Font = Enum.Font.GothamBold
                CustomValue.Text = "50"
                CustomValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                CustomValue.TextSize = 11.000

                ShowValueFrameUICorner.CornerRadius = UDim.new(0, 4)
                ShowValueFrameUICorner.Name = "ShowValueFrameUICorner"
                ShowValueFrameUICorner.Parent = ShowValueFrame

                ValueFrame.Name = "ValueFrame"
                ValueFrame.Parent = SliderFrame
                ValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                ValueFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ValueFrame.Position = UDim2.new(0.5, 0, 0.777777791, 0)
                ValueFrame.Size = UDim2.new(0, 245, 0, 5)

                ValueFrameUICorner.CornerRadius = UDim.new(0, 30)
                ValueFrameUICorner.Name = "ValueFrameUICorner"
                ValueFrameUICorner.Parent = ValueFrame

                PartValue.Name = "PartValue"
                PartValue.Parent = ValueFrame
                PartValue.AnchorPoint = Vector2.new(0.5, 0.5)
                PartValue.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                PartValue.BackgroundTransparency = 1.000
                PartValue.Position = UDim2.new(0.5, 0, 0.777777791, 0)
                PartValue.Size = UDim2.new(0, 245, 0, 5)

                PartValueUICorner.CornerRadius = UDim.new(0, 30)
                PartValueUICorner.Name = "PartValueUICorner"
                PartValueUICorner.Parent = PartValue

                MainValue.Name = "MainValue"
                MainValue.Parent = PartValue
                MainValue.BackgroundColor3 = _G.Color
                MainValue.Size = UDim2.new((de or 0) / max, 0, 0, 5)
                MainValue.BorderSizePixel = 0

                MainValueUICorner.CornerRadius = UDim.new(0, 30)
                MainValueUICorner.Name = "MainValueUICorner"
                MainValueUICorner.Parent = MainValue


                local ConneValue = Instance.new("Frame")
                ConneValue.Name = "ConneValue"
                ConneValue.Parent = PartValue
                ConneValue.AnchorPoint = Vector2.new(0.5, 0.5)
                ConneValue.BackgroundColor3 = _G.Color
                ConneValue.Position = UDim2.new((de or 0)/max, 0.5, 0.5,0, 0)
                ConneValue.Size = UDim2.new(0, 13, 0, 13)
                ConneValue.BorderSizePixel = 0
    
                local UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 10)
                UICorner.Parent = ConneValue


                if floor == true then
                    CustomValue.Text =  tostring(de and string.format((de / max) * (max - min) + min) or 0)
                else
                    CustomValue.Text =  tostring(de and math.floor((de / max) * (max - min) + min) or 0)
                end

                local function move(input)
                    local pos =
                        UDim2.new(
                            math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
                            0,
                            0.5,
                            0
                        )
                    local pos1 =
                        UDim2.new(
                            math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
                            0,
                            0,
                            5
                        )
                    MainValue:TweenSize(pos1, "Out", "Sine", 0.2, true)
                    ConneValue:TweenPosition(pos, "Out", "Sine", 0.2, true)
                    if floor == true then
                        local value = string.format("%.0f",((pos.X.Scale * max) / max) * (max - min) + min)
                        CustomValue.Text = tostring(value)
                        callback(value)
                    else
                        local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                        CustomValue.Text = tostring(value)
                        callback(value)
                    end
                end
                local dragging = false
                ConneValue.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                        end
                    end)
                ConneValue.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                SliderFrame.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                        end
                    end)
                SliderFrame.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                ValueFrame.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                        end
                    end)
                ValueFrame.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                    game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            move(input)
                        end
                    end)
                    CustomValue.FocusLost:Connect(function()
                        if CustomValue.Text == "" then
                            CustomValue.Text  = de
                        end
                        if  tonumber(CustomValue.Text) > max then
                            CustomValue.Text  = max
                        end
                        MainValue:TweenSize(UDim2.new((CustomValue.Text or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
                        ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.6, 0) , "Out", "Sine", 0.2, true)
                        if floor == true then
                            CustomValue.Text = tostring(CustomValue.Text and string.format("%.0f",(CustomValue.Text / max) * (max - min) + min) )
                        else
                            CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
                        end
                        pcall(callback, CustomValue.Text)
                    end)
                    
                    function sliderfunc:Update(value)
                        MainValue:TweenSize(UDim2.new((value or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
                        ConneValue:TweenPosition(UDim2.new((value or 0)/max, 0.5, 0.5,0, 0) , "Out", "Sine", 0.2, true)
                        CustomValue.Text = value
                        pcall(function()
                            callback(value)
                        end)
                    end
                    return sliderfunc
            end
            
            function Item:Dropdown(text,item,default,callback)
                local Drop_Frame = Instance.new("Frame")
                local DropDownFrame = Instance.new("Frame")
                local UICorner_Drop = Instance.new("UICorner")
                local Label_Drop = Instance.new("TextLabel")
                local Arrow = Instance.new("ImageLabel")
                local Down_Frame = Instance.new("Frame")
                local Down = Instance.new("Frame")
                local UICorner_Down = Instance.new("UICorner")
                local ScrollingDownFrame = Instance.new("ScrollingFrame")
                local UIListLayout_Dwon = Instance.new("UIListLayout")
                local UIPadding_Down = Instance.new("UIPadding")
                local ButtonDrop = Instance.new("TextButton")
                local DropToggle = false

                if default == nil then default = "nil" end

                Drop_Frame.Name = "Drop_Frame"
                Drop_Frame.Parent = Page
                Drop_Frame.AnchorPoint = Vector2.new(0.5, 0.5)
                Drop_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Drop_Frame.BackgroundTransparency = 1.000
                Drop_Frame.ClipsDescendants = true
                Drop_Frame.Position = UDim2.new(0, 0, 0.392454112, 0)
                Drop_Frame.Size = UDim2.new(0, 274, 0, 27)

                DropDownFrame.Name = "DropDownFrame"
                DropDownFrame.Parent = Drop_Frame
                DropDownFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                DropDownFrame.BorderSizePixel = 0
                DropDownFrame.ClipsDescendants = true
                DropDownFrame.Position = UDim2.new(0.0255474448, 0, 0, 0)
                DropDownFrame.Size = UDim2.new(0, 258, 0, 27)

                UICorner_Drop.CornerRadius = UDim.new(0, 4)
                UICorner_Drop.Name = "UICorner_Drop"
                UICorner_Drop.Parent = DropDownFrame

                Label_Drop.Name = "Label_Drop"
                Label_Drop.Parent = DropDownFrame
                Label_Drop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Label_Drop.BackgroundTransparency = 1.000
                Label_Drop.Position = UDim2.new(0.0348837227, 0, 0, 0)
                Label_Drop.Size = UDim2.new(0, 202, 0, 26)
                Label_Drop.Font = Enum.Font.GothamBold
                Label_Drop.Text = text.." : "..default
                Label_Drop.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label_Drop.TextSize = 14.000
                Label_Drop.TextXAlignment = Enum.TextXAlignment.Left

                Arrow.Name = "Arrow"
                Arrow.Parent = DropDownFrame
                Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Arrow.BackgroundTransparency = 1.000
                Arrow.Position = UDim2.new(0.871363997, 0, 0.0370371342, 0)
                Arrow.Rotation = 180.000
                Arrow.Size = UDim2.new(0, 24, 0, 24)
                Arrow.Image = "rbxassetid://6031094670"
                
                Down_Frame.Name = "Down_Frame"
                Down_Frame.Parent = Page
                Down_Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Down_Frame.BackgroundTransparency = 1.000
                Down_Frame.Position = UDim2.new(0, 0, 0.445364237, 0)
                Down_Frame.Size = UDim2.new(0, 274, 0, 0)
                Down_Frame.ClipsDescendants = true

                Down.Name = "Down"
                Down.Parent = Down_Frame
                Down.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                Down.BorderSizePixel = 0
                Down.Position = UDim2.new(0.0255474448, 0, 0.0190476142, 0)
                Down.Size = UDim2.new(0, 258, 0, 100)

                UICorner_Down.CornerRadius = UDim.new(0, 4)
                UICorner_Down.Name = "UICorner_Down"
                UICorner_Down.Parent = Down

                ScrollingDownFrame.Name = "ScrollingDownFrame"
                ScrollingDownFrame.Parent = Down
                ScrollingDownFrame.Active = true
                ScrollingDownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScrollingDownFrame.BackgroundTransparency = 1.000
                ScrollingDownFrame.BorderSizePixel = 0
                ScrollingDownFrame.Size = UDim2.new(0, 258, 0, 100)
                ScrollingDownFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
                ScrollingDownFrame.ScrollBarThickness = 4

                UIListLayout_Dwon.Name = "UIListLayout_Dwon"
                UIListLayout_Dwon.Parent = ScrollingDownFrame
                UIListLayout_Dwon.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout_Dwon.Padding = UDim.new(0, 7)

                UIPadding_Down.Name = "UIPadding_Down"
                UIPadding_Down.Parent = ScrollingDownFrame
                UIPadding_Down.PaddingTop = UDim.new(0, 10)

                ButtonDrop.Name = "ButtonItem"
                ButtonDrop.Parent = Drop_Frame
                ButtonDrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonDrop.BackgroundTransparency = 1.000
                ButtonDrop.Font = Enum.Font.SourceSans
                ButtonDrop.Text = ""
                ButtonDrop.TextColor3 = Color3.fromRGB(0, 0, 0)
                ButtonDrop.TextSize = 14.000
                ButtonDrop.Size = UDim2.new(0, 274, 0, 27)

                if default ~= "nil" then
                    callback(default)
                end

                ButtonDrop.MouseButton1Click:Connect(function()
                    if toggonsetting == false then
                        if DropToggle == false then
                            DropToggle = true
                            CircleAnim(DropDownFrame, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
                            TweenService:Create(
                                Down_Frame,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 274, 0, 105)}
                            ):Play()
                            TweenService:Create(
                                Arrow,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Rotation = 270}
                            ):Play()
                        elseif DropToggle == true then
                            DropToggle = false
                            CircleAnim(DropDownFrame, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
                            TweenService:Create(
                                Down_Frame,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 274, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                Arrow,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Rotation = 180}
                            ):Play()
                        end
                    end
                end
                )


                for i,v in pairs(item) do
                    local ItemFrame = Instance.new("Frame")
                    local Item = Instance.new("Frame")
                    local UICorner_Item = Instance.new("UICorner")
                    local ItemLabel = Instance.new("TextLabel")
                    local ButtonItem = Instance.new("TextButton")

                                        
                    ItemFrame.Name = "ItemFrame"
                    ItemFrame.Parent = ScrollingDownFrame
                    ItemFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemFrame.BackgroundTransparency = 1.000
                    ItemFrame.Size = UDim2.new(0, 258, 0, 24)

                    Item.Name = "Item"
                    Item.Parent = ItemFrame
                    Item.BackgroundColor3 = _G.Color
                    Item.BorderSizePixel = 0
                    Item.Position = UDim2.new(0.0503875986, 0, 0, 0)
                    Item.Size = UDim2.new(0, 234, 0, 24)
                    Item.ClipsDescendants = true

                    UICorner_Item.CornerRadius = UDim.new(0, 4)
                    UICorner_Item.Name = "UICorner_Item"
                    UICorner_Item.Parent = Item

                    ItemLabel.Name = "ItemLabel"
                    ItemLabel.Parent = Item
                    ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemLabel.BackgroundTransparency = 1.000
                    ItemLabel.Size = UDim2.new(0, 233, 0, 24)
                    ItemLabel.Font = Enum.Font.GothamBold
                    ItemLabel.Text = tostring(v)
                    ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ItemLabel.TextSize = 14.000

                    ButtonItem.Name = "ButtonItem"
                    ButtonItem.Parent = ItemFrame
                    ButtonItem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ButtonItem.BackgroundTransparency = 1
                    ButtonItem.Size = UDim2.new(0, 256, 0, 24)
                    ButtonItem.Font = Enum.Font.SourceSans
                    ButtonItem.Text = ""
                    ButtonItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                    ButtonItem.TextSize = 14.000


                    ButtonItem.MouseButton1Down:Connect(function()
                        if toggonsetting == false then
                            ItemLabel.TextSize = 0
                            TweenService:Create(
                                ItemLabel,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                                {TextSize = 12}
                            ):Play()
                            Label_Drop.Text = tostring(text.." : "..v)
                            CircleAnim(Item,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
                            callback(v)
                            DropToggle = false
                            TweenService:Create(
                                Down_Frame,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 274, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                Arrow,
                                TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Rotation = 180}
                            ):Play()
                        end         
                    end)
                end
                ScrollingDownFrame.CanvasSize = UDim2.new(0,0,0,UIListLayout_Dwon.AbsoluteContentSize.Y + 10)

                local dropfunc = {}
                
                function dropfunc:Add(nameitem)
                    local ItemFrame = Instance.new("Frame")
                    local Item = Instance.new("Frame")
                    local UICorner_Item = Instance.new("UICorner")
                    local ItemLabel = Instance.new("TextLabel")
                    local ButtonItem = Instance.new("TextButton")

                                        
                    ItemFrame.Name = "ItemFrame"
                    ItemFrame.Parent = ScrollingDownFrame
                    ItemFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemFrame.BackgroundTransparency = 1.000
                    ItemFrame.Size = UDim2.new(0, 258, 0, 24)

                    Item.Name = "Item"
                    Item.Parent = ItemFrame
                    Item.BackgroundColor3 = _G.Color
                    Item.BorderSizePixel = 0
                    Item.Position = UDim2.new(0.0503875986, 0, 0, 0)
                    Item.Size = UDim2.new(0, 234, 0, 24)
                    Item.ClipsDescendants = true

                    UICorner_Item.CornerRadius = UDim.new(0, 4)
                    UICorner_Item.Name = "UICorner_Item"
                    UICorner_Item.Parent = Item

                    ItemLabel.Name = "ItemLabel"
                    ItemLabel.Parent = Item
                    ItemLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemLabel.BackgroundTransparency = 1.000
                    ItemLabel.Size = UDim2.new(0, 233, 0, 24)
                    ItemLabel.Font = Enum.Font.GothamBold
                    ItemLabel.Text = tostring(nameitem)
                    ItemLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ItemLabel.TextSize = 14.000

                    ButtonItem.Name = "ButtonItem"
                    ButtonItem.Parent = ItemFrame
                    ButtonItem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ButtonItem.BackgroundTransparency = 1
                    ButtonItem.Size = UDim2.new(0, 256, 0, 24)
                    ButtonItem.Font = Enum.Font.SourceSans
                    ButtonItem.Text = ""
                    ButtonItem.TextColor3 = Color3.fromRGB(0, 0, 0)
                    ButtonItem.TextSize = 14.000


                    ButtonItem.MouseButton1Down:Connect(function()
                        if toggonsetting == false then
                            ItemLabel.TextSize = 0
                            TweenService:Create(
                                ItemLabel,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                                {TextSize = 12}
                            ):Play()
                            Label_Drop.Text = tostring(text.." : "..nameitem)
                            CircleAnim(Item,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
                            callback(nameitem)
                            DropToggle = false
                            TweenService:Create(
                                Down_Frame,
                                TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 274, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                Arrow,
                                TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Rotation = 180}
                            ):Play()
                        end         
                    end)
                    ScrollingDownFrame.CanvasSize = UDim2.new(0,0,0,UIListLayout_Dwon.AbsoluteContentSize.Y + 10)
                end

                function dropfunc:Clear()

                    DropToggle = false
                    Label_Drop.Text = tostring(text).." : "
                    TweenService:Create(
                        Down_Frame,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 274, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        Arrow,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Rotation = 180}
                    ):Play()
                    for i, v in next, ScrollingDownFrame:GetChildren() do
                        if v:IsA("Frame") then
                            v:Destroy()
                        end
                    end
                    ScrollingDownFrame.CanvasSize = UDim2.new(0,0,0,UIListLayout_Dwon.AbsoluteContentSize.Y + 10)
                end
                return dropfunc
            end
            function Item:Seperator(text)
                local SepFrame = Instance.new("Frame")
                local LabelSep = Instance.new("TextLabel")
                local Liner1 = Instance.new("Frame")
                local LIner2 = Instance.new("Frame")

                SepFrame.Name = "SepFrame"
                SepFrame.Parent = Page
                SepFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SepFrame.BackgroundTransparency = 1.000
                SepFrame.Position = UDim2.new(0, 0, 0.102649003, 0)
                SepFrame.Size = UDim2.new(0, 274, 0, 30)

                LabelSep.Name = "LabelSep"
                LabelSep.Parent = SepFrame
                LabelSep.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelSep.BackgroundTransparency = 1.000
                LabelSep.Position = UDim2.new(0.0328467153, 0, 0, 0)
                LabelSep.Size = UDim2.new(0, 255, 0, 30)
                LabelSep.Font = Enum.Font.GothamBold
                LabelSep.Text = text
                LabelSep.TextColor3 = Color3.fromRGB(255, 255, 255)
                LabelSep.TextSize = 14.000

                Liner1.Name = "Liner1"
                Liner1.Parent = SepFrame
                Liner1.BackgroundColor3 = _G.Color
                Liner1.Position = UDim2.new(0.0620437972, 0, 0.5, 0)
                Liner1.Size = UDim2.new(0, 64, 0, 1)

                LIner2.Name = "LIner2"
                LIner2.Parent = SepFrame
                LIner2.BackgroundColor3 = _G.Color
                LIner2.Position = UDim2.new(0.708029211, 0, 0.5, 0)
                LIner2.Size = UDim2.new(0, 64, 0, 1)
            end
            function Item:Line(text)
                local LineFrame = Instance.new("Frame")
                local Liner = Instance.new("Frame")

                LineFrame.Name = "LineFrame"
                LineFrame.Parent = Page
                LineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LineFrame.BackgroundTransparency = 1.000
                LineFrame.Position = UDim2.new(0, 0, 0.102649003, 0)
                LineFrame.Size = UDim2.new(0, 274, 0, 30)

                Liner.Name = "Liner"
                Liner.Parent = LineFrame
                Liner.BackgroundColor3 = _G.Color
                Liner.Position = UDim2.new(0.0620437972, 0, 0.5, 0)
                Liner.Size = UDim2.new(0, 241, 0, 1)
            end
            function Item:Label(text)
                local LabelFrame = Instance.new("Frame")
                local LabelTitle = Instance.new("TextLabel")
                local funclabel = {}

                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = Page
                LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelFrame.BackgroundTransparency = 1.000
                LabelFrame.Position = UDim2.new(0, 0, 0.102649003, 0)
                LabelFrame.Size = UDim2.new(0, 274, 0, 30)

                LabelTitle.Name = "LabelTitle"
                LabelTitle.Parent = LabelFrame
                LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.BackgroundTransparency = 1.000
                LabelTitle.Position = UDim2.new(0.0328467153, 0, 0, 0)
                LabelTitle.Size = UDim2.new(0, 255, 0, 30)
                LabelTitle.Font = Enum.Font.GothamBold
                LabelTitle.Text = text
                LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                LabelTitle.TextSize = 14.000

                function funclabel:Update(newtext)
                    LabelTitle.Text = newtext
                end
                return funclabel
            end
            function Item:Toggle(text,default,callback) -- Mobile
				local default = default or HowToHub
                local Toggle = Instance.new("Frame")
                local ToggleCorner = Instance.new("UICorner")
                local Tgle = Instance.new("Frame")
                local TgleCorner = Instance.new("UICorner")
                local tglebtn = Instance.new("TextButton")
                local ToggleLabel = Instance.new("TextLabel")
                local ToggleImage = Instance.new("Frame")
                local ToggleImageCorner = Instance.new("UICorner")
                local tgleimg = Instance.new("ImageLabel")
                local tgleimg_2 = Instance.new("UICorner")
                local imgLabelIcon = Instance.new("ImageLabel")

                Toggle.Name = "Toggle"
                Toggle.Parent = Page
                Toggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                Toggle.BackgroundTransparency = 1
                Toggle.Size = UDim2.new(0, 274, 0, 30)

                ToggleCorner.CornerRadius = UDim.new(0, 5)
                ToggleCorner.Name = "ToggleCorner"
                ToggleCorner.Parent = Toggle
                
                Tgle.Name = "Tgle"
                Tgle.Parent = Toggle
                Tgle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                --Tgle.BackgroundTransparency = 1
                Tgle.Size = UDim2.new(0, 274, 0, 30)

                TgleCorner.CornerRadius = UDim.new(0, 5)
                TgleCorner.Name = "TgleCorner"
                TgleCorner.Parent = Tgle

                tglebtn.Name = "tglebtn"
                tglebtn.Parent = Tgle
                tglebtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                tglebtn.BackgroundTransparency = 1.000
                tglebtn.Size = UDim2.new(0, 258, 0, 36)
                tglebtn.Font = Enum.Font.SourceSans
                tglebtn.Text = ""
                tglebtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                tglebtn.TextSize = 14.000

                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.Parent = Tgle
                ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.BackgroundTransparency = 1.000
                ToggleLabel.Position = UDim2.new(0.156934306, 0, 0, 0)
                ToggleLabel.Size = UDim2.new(0, 190, 0, 36)
                ToggleLabel.Font = Enum.Font.GothamSemibold
                ToggleLabel.Text = text
                ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.TextSize = 16.000
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

                ToggleImage.Name = "ToggleImage"
                ToggleImage.Parent = Tgle
                ToggleImage.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                ToggleImage.BackgroundTransparency = 0.500
                ToggleImage.Position = UDim2.new(0, 10, 0, 5)
                ToggleImage.Size = UDim2.new(0, 26, 0, 26)

                ToggleImageCorner.CornerRadius = UDim.new(0, 5)
                ToggleImageCorner.Name = "ToggleImageCorner"
                ToggleImageCorner.Parent = ToggleImage

                tgleimg.Name = "tgleimg"
                tgleimg.Parent = ToggleImage
                tgleimg.AnchorPoint = Vector2.new(0.5, 0.5)
                tgleimg.BackgroundColor3 = _G.Color
                tgleimg.BackgroundTransparency = 0.500
                tgleimg.Position = UDim2.new(0.5095, 0, 0.514999986, 0)
                tgleimg.Image = "rbxassetid://6031068421"
                tgleimg.ImageColor3 = _G.Color
                tgleimg.Size = UDim2.new(0, 0, 0, 0)

                tgleimg_2.CornerRadius = UDim.new(0, 5)
                tgleimg_2.Name = "tgleimg_2"
                tgleimg_2.Parent = tgleimg
                
               
                tglebtn.MouseEnter:Connect(function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
				    ):Play()
                    TweenService:Create(
                        ToggleLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextTransparency = 0}
				    ):Play()
                    TweenService:Create(
                        ToggleImage,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
				    ):Play()
                    TweenService:Create(
                        tgleimg,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0}
				    ):Play()
                end)
                tglebtn.MouseLeave:Connect(function()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.5}
				    ):Play()
                    TweenService:Create(
                        ToggleLabel,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {TextTransparency = 0}
				    ):Play()
                    TweenService:Create(
                        ToggleImage,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.5}
				    ):Play()
                    TweenService:Create(
                        tgleimg,
                        TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundTransparency = 0.5}
				    ):Play()
                end)
                
                local togglecheck = default or false
				if default == true then
                    togglecheck = true
                    pcall(callback,istoggled)
                    tgleimg:TweenSize(UDim2.new(0, 26, 0, 26),"In","Quad",0.1,true)
                end
				
                tglebtn.MouseButton1Click:Connect(function()
                    if togglecheck == false then
                        togglecheck = true
						HowToHub = true
                        tgleimg:TweenSize(UDim2.new(0, 26, 0, 26),"In","Quad",0.1,true)
                    else
                        togglecheck = false
						HowToHub = false 
                        tgleimg:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.1,true)
                    end
                    pcall(callback,HowToHub)
                end)
            end
            return Item
        end
        return Page
    end
    return Tab
end




local Config = {
    WindowName = "V.G Hub",
	Color = Color3.fromRGB(255,128,64),
	Keybind = Enum.KeyCode.RightControl
}

local Players = Get.Players
local Workspace = Get.Workspace
local RunService = Get.RunService
local ReplicatedStorage = Get.ReplicatedStorage
local HttpService = Get.HttpService
local RunService = Get.RunService
local Player = Players.LocalPlayer
local Coins = Workspace["__THINGS"].Coins
local wait = task.wait 
local spawn = task.spawn
local Client = require(ReplicatedStorage.Library.Client)
local Orbs = getsenv(Player.PlayerScripts.Scripts.Game.Orbs)
local Lootbags = getsenv(Player.PlayerScripts.Scripts.Game.Lootbags)
debug.setupvalue(Client.Network.Invoke, 1, function() return true end)
debug.setupvalue(Client.Network.Fire, 1, function() return true end)

local Name = "PS.json"

Des = {}
if makefolder then
    makefolder("V.G Hub")
end

local Settings

if
    not pcall(
        function()
            readfile("V.G Hub//" .. Name)
        end
    )
 then
    writefile("V.G Hub//" .. Name, HttpService:JSONEncode(Des))
end

Settings = HttpService:JSONDecode(readfile("V.G Hub//" .. Name))

local function Save()
    writefile("V.G Hub//" .. Name, HttpService:JSONEncode(Settings))
end

local Egg = {}
for i,v in pairs(Eggs) do
    if not table.find(Egg,v) then
        table.insert(Egg,i)
    end 
end 
local Areas = {}
for i,v in pairs(Areas) do
    table.insert(Areas,v)
end 



local function getNearestCoin()
    local TargetDistance = math.huge
    local Target
    for i, v in ipairs(Coins:GetChildren()) do
        if v:FindFirstChild("Coin") then
            local Mag =
                (Get.Players.LocalPlayer.Character.HumanoidRootPart.Position -
                v:FindFirstChild("Coin").Position).Magnitude
            if Mag < TargetDistance then
                TargetDistance = Mag
                Target = v
            end
        end
    end
    return Target
end



local Win = Ui:Window('NEVA HUB')
local tab1 = Win:CraftTab('Main')
local tab2 = Win:CraftTab('Shop')
local page1 = tab1:CraftPage('Main',1)
local page2 = tab1:CraftPage('Function Toggle',2)


page1:Line()
local Label1 = page1:Label('Synap1_x')
page1:Seperator('UwU')
page1:Button("Button / Set Label",function()
    Label1:Update("Native")
end)

page1:Toggle("AutoFarm", Settings.Cum, function(State)
Settings.Cum = State
RunService.RenderStepped:Connect(function()
    pcall(function()
        if Settings.Cum then
        local Pets = Client.PetCmds.GetEquipped() 
        for K,O in pairs(Pets) do
            Client.Network.Invoke('Join Coin', getNearestCoin().Name, {O.uid})
            Client.Network.Fire('Farm Coin', getNearestCoin().Name, O.uid)
            for i,v in pairs(Workspace["__THINGS"].Orbs:GetChildren()) do
                v.CFrame = Player.Character:GetModelCFrame()
            end 
            for i,v in pairs(Workspace["__THINGS"].Lootbags:GetChildren()) do
                v.CFrame = Player.Character:GetModelCFrame()
            end
        end 
        end 
    end)
end)

end)

local dropdown = page1:Dropdown("Dropdown",{'Item1',"Item2",'Item3'},'Item1',function(a)
    print(a)
end)

page1:Button('Dropdown Add',function()
    _G.Random = math.random(1,1000)
    wait()
    dropdown:Add(_G.Random)
end)

page1:Button('Dropdown Clear',function()
    dropdown:Clear()
end)

local Slider = page1:Slider("Slider",true,0,100,20,function(v)
    print(v)
end)

page1:Button('Slider Update',function()
    Slider:Update(50)
end)

page2:Line()

local Label2 = page1:Label('Synap1_x2')

page2:Seperator('UwU')

page2:Button("Button / Set Label",function()
    Label2:Update("Native2")
end)

page2:Toggle('Toggle',true,function(a) -- Mobile
    print(a)
end)

local dropd0own = page2:Dropdown("Dropdown",{'Item1',"Item2",'Item3'},'Item1',function(a)
    print(a)
end)

page2:Button('Dropdown Add',function()
    _G.Random = math.random(1,1000)
    wait()
    dropd0own:Add(_G.Random)
end)

page2:Button('Dropdown Clear',function()
    dropdown:Clear()
end)

local Slide9r = page2:Slider("Slider",true,0,100,20,function(v)
    print(v)
end)

page2:Button('Slider Update',function()
    Slide9r:Update(50)
end)
