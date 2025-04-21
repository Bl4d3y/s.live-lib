local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local cg = game:GetService("CoreGui")
local hs = game:GetService("HttpService")

local para = {}

--// Systems

 if (not isfolder("slive")) then
 rconsoleprint("Created folder")
 makefolder("slive")
 end

 if not isfolder("slive/cfgs") then
  rconsoleprint("Created configs folder")
    makefolder("slive/cfgs")
end

local function saveConfig()
    local folder = "slive/cfgs"
    local path = folder .. "/" .. game.GameId .. ".json"
    writefile(path, hs:JSONEncode(para)) -- all the values instead of para
  rconsoleprint("Config saved to game " .. tostring(game.GameId))
end

local function deleteConfig()
    local folder = "slive/cfgs"
    local path = folder .. "/" .. game.GameId .. ".json"
    if isfile(path) then
        delfile(path)
        rconsoleprint("Config deleted from game " .. tostring(game.GameId))
    else
          rconsoleprint("No config found for " .. tostring(game.GameId))
    end
end


--// Everything / Componsents and allat


function para:Win()

for i, v in pairs(cg:GetChildren()) do
	if v.Name == "sl" then
		v:Destroy()
	end
end

for i, v in pairs(game.Lighting:GetChildren()) do
	if v.Name == "RealUIBlur" then
		v:Destroy()
	end
end

	local screen = Instance.new("ScreenGui", cg)
	screen.Name = "sl"
    screen.IgnoreGuiInset = true

    local bg = Instance.new("Frame", screen)
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.new(0.113725, 0.101961, 0.101961)
    bg.BackgroundTransparency = 0.34
	
	local drag = function(obj, latency)
		obj = obj
		latency = latency or 0.06

		toggled = nil
		input = nil
		start = nil

		function updateInput(input)
			local Delta = input.Position - start
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			ts:Create(obj, TweenInfo.new(latency), {Position = Position}):Play()
		end

		obj.InputBegan:Connect(function(inp)
			if (inp.UserInputType == Enum.UserInputType.MouseButton1) then
				toggled = true
				start = inp.Position
				startPos = obj.Position
				inp.Changed:Connect(function()
					if (inp.UserInputState == Enum.UserInputState.End) then
						toggled = false
					end
				end)
			end
		end)

		obj.InputChanged:Connect(function(inp)
			if (inp.UserInputType == Enum.UserInputType.MouseMovement) then
				input = inp
			end
		end)

		uis.InputChanged:Connect(function(inp)
			if (inp == input and toggled) then
				updateInput(inp)
			end
		end)
	end
	
	local mainframe = Instance.new("Frame", bg)
	mainframe.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
	mainframe.BorderSizePixel = 0
	mainframe.Size = UDim2.new(0, 319, 0, 262)
	mainframe.Position = UDim2.new(0.089, 0, 0.115, 0)

    local uiblur = Instance.new("BlurEffect", game.Lighting)
    uiblur.Size = 11
    uiblur.Name = "RealUIBlur"

    local Hidden = false
    local Debounce = false

    uis.InputBegan:Connect(function(inp, processed)
	if (inp.KeyCode == Enum.KeyCode.RightControl and not processed) then
		if Debounce then return end
		if Hidden then
			Hidden = false
            uiblur.Size = 11
            screen.Enabled = true
			-- show it
		else
            Hidden = true
            uiblur.Size = 0
            screen.Enabled = false
			-- hide it
		end
	end
end)
	
	drag(mainframe, 0.06)
	
	local MainCorner = Instance.new("UICorner", mainframe)
	MainCorner.CornerRadius = UDim.new(0, 8)
	
	local MainStroke = Instance.new("UIStroke", mainframe)
	MainStroke.Color = Color3.fromRGB(216, 86, 106)
	MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	MainStroke.Thickness = 0.55
	MainStroke.Transparency = 0.24
	
	local MainList = Instance.new("UIListLayout", mainframe)
	MainList.FillDirection = Enum.FillDirection.Vertical
	MainList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	MainList.VerticalAlignment = Enum.VerticalAlignment.Top
	MainList.SortOrder = Enum.SortOrder.LayoutOrder
	MainList.Padding = UDim.new(0, 7)
	
	
	
	--// Info starts here
	
	local ScriptInfo = Instance.new("Frame", mainframe)
	ScriptInfo.Size = UDim2.new(0, 319, 0, 53)
	ScriptInfo.Position = UDim2.new(0, 0, 0, 0)
	ScriptInfo.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
	ScriptInfo.BackgroundTransparency = 1
	ScriptInfo.BorderSizePixel = 0
	
	local ScriptInfoList = Instance.new("UIListLayout", ScriptInfo)
	ScriptInfoList.FillDirection = Enum.FillDirection.Vertical
	ScriptInfoList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ScriptInfoList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	ScriptInfoList.SortOrder = Enum.SortOrder.Name
	ScriptInfoList.Padding = UDim.new(0, 11)
	
	local A = Instance.new("ImageLabel", ScriptInfo)
	A.Name = "A"
	A.Image = "http://www.roblox.com/asset/?id=114659793540273"
	A.Size = UDim2.new(0, 133,0, 32)
	A.ImageTransparency = 0.22
	A.BackgroundTransparency = 1
	A.BorderSizePixel = 0
	A.ImageColor3 = Color3.fromRGB(255, 255, 255)
	A.ScaleType = Enum.ScaleType.Stretch
	
	local B = Instance.new("Frame", ScriptInfo)
	B.Name = "B"
	B.BackgroundColor3 = Color3.fromRGB(255, 147, 149)
	B.BackgroundTransparency = 0.45
	B.Size = UDim2.new(0, 279,0, 1)
	B.BorderSizePixel = 0
	
	local FrameGradient = Instance.new("UIGradient", B)
	FrameGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.919), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0.919)})
	FrameGradient.Enabled = true
	
	--// Tabs start here
	
	local Buttons = Instance.new("Frame", mainframe)
	Buttons.Size = UDim2.new(0, 317, 0, 202)
	Buttons.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
	Buttons.BackgroundTransparency = 1
	Buttons.BorderSizePixel = 0
	
	local ButtonsList = Instance.new("UIListLayout", Buttons)
	ButtonsList.FillDirection = Enum.FillDirection.Vertical
	ButtonsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ButtonsList.VerticalAlignment = Enum.VerticalAlignment.Top
	ButtonsList.SortOrder = Enum.SortOrder.LayoutOrder
	ButtonsList.Padding = UDim.new(0, 12)
	
	local buttonHeight = 46
	local padding = 6

	local function resizeFrame()
		local buttonCount = 1
		for _, child in ipairs(Buttons:GetChildren()) do
			if child:IsA("TextButton") then
				buttonCount += 1
				print(buttonCount)
			end
		end

		local totalHeight = buttonCount * (buttonHeight + padding) - padding
		mainframe.Size = UDim2.new(mainframe.Size.X.Scale, mainframe.Size.X.Offset, 0, totalHeight)
	end

	Buttons.ChildAdded:Connect(function(child)
		if child:IsA("TextButton") then
			resizeFrame()
		end
	end)

	Buttons.ChildRemoved:Connect(function(child)
		if child:IsA("TextButton") then
			resizeFrame()
		end
	end)

	resizeFrame()

	local tabs = {}
	
	function tabs:Tab(name, icon)
		
		--// Buttons go here lel
		
		local TabButton = Instance.new("TextButton", Buttons)
		TabButton.BackgroundColor3 = Color3.fromRGB(250, 114, 118)
		TabButton.BackgroundTransparency = 1
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(0, 288,0, 38)
		TabButton.FontFace = Font.fromId(12187362578)
		TabButton.Text = name
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextSize = 15
		TabButton.TextTransparency = 0.44
		TabButton.TextXAlignment = Enum.TextXAlignment.Left
		
		local TabBPadding = Instance.new("UIPadding", TabButton)
		TabBPadding.PaddingLeft = UDim.new(0, 50)
		
		local TabIcon = Instance.new("ImageLabel", TabButton)
		TabIcon.Size = UDim2.new(0, 27,0, 27)
		TabIcon.Position = UDim2.new(-0.158, 0,0.145, 0)
		TabIcon.BackgroundTransparency = 1
		TabIcon.BorderSizePixel = 0
		TabIcon.ImageTransparency = 0.44
		TabIcon.Image = "http://www.roblox.com/asset/?id=" .. icon
		
		local Indicator = Instance.new("ImageLabel", TabButton)
		Indicator.Size = UDim2.new(0, 12,0, 14)
		Indicator.Position = UDim2.new(0.901, 0,0.3, 0)
		Indicator.BackgroundTransparency = 1
		Indicator.BorderSizePixel = 0
		Indicator.ImageTransparency = 0.44
		Indicator.Image = "http://www.roblox.com/asset/?id=102522364483534"
		
		--// Everything else goes here lel
		
		local Tabby = Instance.new("Frame", bg)
		Tabby.Name = "boom"
		Tabby.Visible =false
		Tabby.BackgroundColor3 = Color3.fromRGB(29, 29, 29)
		Tabby.BorderSizePixel = 0
		Tabby.Position = UDim2.new(0.494, 0,0.15, 0)
		Tabby.Size = UDim2.new(0, 319,0, 262)
		Tabby.Draggable = true
		Tabby.Active = true
		
		local TabCorner = Instance.new("UICorner", Tabby)
		TabCorner.CornerRadius = UDim.new(0, 8)

		local TabStroke = Instance.new("UIStroke", Tabby)
		TabStroke.Color = Color3.fromRGB(216, 86, 106)
		TabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		TabStroke.Thickness = 0.55
		TabStroke.Transparency = 0.24

		local TabList = Instance.new("UIListLayout", Tabby)
		TabList.FillDirection = Enum.FillDirection.Vertical
		TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		TabList.VerticalAlignment = Enum.VerticalAlignment.Top
		TabList.SortOrder = Enum.SortOrder.LayoutOrder
		TabList.Padding = UDim.new(0, 7)
		
		local TabInfo = Instance.new("Frame", Tabby)
		TabInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabInfo.BackgroundTransparency = 1
		TabInfo.BorderSizePixel = 0
		TabInfo.Size = UDim2.new(0, 319,0, 46)
		
		local Divider = Instance.new("Frame", TabInfo)
		Divider.Name = "B"
		Divider.BackgroundColor3 = Color3.fromRGB(255, 147, 149)
		Divider.BackgroundTransparency = 0.45
		Divider.Size = UDim2.new(0, 279,0, 1)
		Divider.BorderSizePixel = 0

		local DivGradient = Instance.new("UIGradient", Divider)
		DivGradient.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.919), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 0.919)})
		DivGradient.Enabled = true
		
		local TabInfoList = Instance.new("UIListLayout", TabInfo)
		TabInfoList.FillDirection = Enum.FillDirection.Vertical
		TabInfoList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		TabInfoList.VerticalAlignment = Enum.VerticalAlignment.Bottom
		TabInfoList.SortOrder = Enum.SortOrder.Name
		TabInfoList.Padding = UDim.new(0, 10)
		
		local Information = Instance.new("Frame", TabInfo)
		Information.Name = "A"
		Information.Size = UDim2.new(0, 295,0, 26)
		Information.BackgroundTransparency = 1
		
		local textinfo = Instance.new("TextLabel", Information)
		textinfo.Text = name
		textinfo.BackgroundTransparency = 1
		textinfo.Size = UDim2.new(0, 190,0, 25)
		textinfo.Position = UDim2.new(0.112, 0,0.077, 0)
		textinfo.FontFace = Font.fromId(12187362578)
		textinfo.TextSize = 20
		textinfo.TextTransparency = 0.44
		textinfo.TextXAlignment = Enum.TextXAlignment.Left
		textinfo.TextColor3 = Color3.fromRGB(173, 173, 173)
		
		local iconinfo = Instance.new("ImageLabel", Information)
		iconinfo.Size = UDim2.new(0, 23,0, 23)
		iconinfo.Position = UDim2.new(0, 0,0.058, 0)
		iconinfo.BackgroundTransparency = 1
		iconinfo.BorderSizePixel = 0
		iconinfo.ImageTransparency = 0.44
		iconinfo.Image = "http://www.roblox.com/asset/?id=" .. icon
		
		local Close = Instance.new("TextButton", Information)
		Close.Position = UDim2.new(0.888, 0,0.286, 0)
		Close.Size = UDim2.new(0, 15,0, 15)
		Close.BackgroundTransparency = 0.4
		Close.BackgroundColor3 = Color3.fromRGB(250, 114, 118)
		Close.Text = ""
		
		local CloseCorn = Instance.new("UICorner", Close)
		CloseCorn.CornerRadius = UDim.new(1, 100)
		
		local battens = Instance.new("Frame", Tabby)
		battens.Size = UDim2.new(0, 317,0, 209)
		battens.BackgroundTransparency = 1
		
		local battenslist = Instance.new("UIListLayout", battens)
		battenslist.FillDirection = Enum.FillDirection.Vertical
		battenslist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		battenslist.VerticalAlignment = Enum.VerticalAlignment.Top
		battenslist.SortOrder = Enum.SortOrder.LayoutOrder
		battenslist.Padding = UDim.new(0, 12)
		
		local buttonHeight = 46
		local padding = 5
		
		local function resizeFrame()
			local buttonCount = 1
			for _, child in ipairs(battens:GetChildren()) do
				if child:IsA("TextButton") or child:IsA("Frame") then
					buttonCount += 1
					print(buttonCount)
				end
			end

			local totalHeight = buttonCount * (buttonHeight + padding) - padding
			Tabby.Size = UDim2.new(Tabby.Size.X.Scale, Tabby.Size.X.Offset, 0, totalHeight)
		end

		battens.ChildAdded:Connect(function(child)
			if child:IsA("TextButton") or child:IsA("Frame") then
				resizeFrame()
			end
		end)

		battens.ChildRemoved:Connect(function(child)
			if child:IsA("TextButton") or child:IsA("Frame") then
				resizeFrame()
			end
		end)

		resizeFrame()
		
		
		
		--// Functionality
		
		Close.MouseButton1Down:Connect(function()
			Tabby.Visible = false
			ts:Create(TabButton, TweenInfo.new(.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
		end)
		
		
		TabButton.MouseButton1Down:Connect(function()
			Tabby.Visible = true
		end)

        

		
		TabButton.MouseButton1Down:Connect(function()
			ts:Create(TabButton, TweenInfo.new(.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.33}):Play()
		end)
		
		--// All items in tabs
		
		local intab = {}
		
		function intab:Button(text, callback)
			local Button = Instance.new("TextButton", battens)
			Button.BackgroundColor3 = Color3.fromRGB(222, 121, 123)
			Button.BackgroundTransparency = 1
			Button.Size = UDim2.new(0, 288,0, 38)
			Button.FontFace = Font.fromId(12187362578)
			Button.Text = text
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextSize = 15
			Button.TextTransparency = 0.44
			Button.TextXAlignment = Enum.TextXAlignment.Left
			
			local btstroke = Instance.new("UIStroke", Button)
			btstroke.Color = Color3.fromRGB(216, 86, 106)
			btstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			btstroke.Thickness = 0.53
			btstroke.Transparency = 0.24

			local BtnPadding = Instance.new("UIPadding", Button)
			BtnPadding.PaddingLeft = UDim.new(0, 25)
			
			Button.MouseButton1Down:Connect(function()
				
				pcall(callback)
				ts:Create(Button, TweenInfo.new(.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.67}):Play()
				wait(.10)
				ts:Create(Button, TweenInfo.new(.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
			end)
		end
		
		function intab:Toggle(text, callback)
			
			local Toggle = Instance.new("TextButton", battens)
			Toggle.BackgroundColor3 = Color3.fromRGB(250, 114, 118)
			Toggle.BackgroundTransparency = 1
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(0, 288,0, 38)
			Toggle.FontFace = Font.fromId(12187362578)
			Toggle.Text = text
			Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
			Toggle.TextSize = 15
			Toggle.TextTransparency = 0.44
			Toggle.TextXAlignment = Enum.TextXAlignment.Left
			
			local tgstroke = Instance.new("UIStroke", Toggle)
			tgstroke.Color = Color3.fromRGB(216, 86, 106)
			tgstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			tgstroke.Thickness = 0.53
			tgstroke.Transparency = 0.24

			local ToggPadding = Instance.new("UIPadding", Toggle)
			ToggPadding.PaddingLeft = UDim.new(0, 25)
			
			local IndicateToggle = Instance.new("Frame", Toggle)
			IndicateToggle.Size = UDim2.new(0, 15,0, 15)
			IndicateToggle.Position = UDim2.new(0.888, 0,0.286, 0)
			IndicateToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			IndicateToggle.BackgroundTransparency = 0.2
			
			local indcorner = Instance.new("UICorner", IndicateToggle)
			indcorner.CornerRadius = UDim.new(1, 100)
			
			
			
			local togg = false
			function trigger()
				togg = not togg
				pcall(callback, togg)
				if togg then
					ts:Create(IndicateToggle, TweenInfo.new(.8, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(139, 255, 156)}):Play()
				else
					ts:Create(IndicateToggle, TweenInfo.new(.8, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(255, 255, 241)}):Play()
				end
			end
			Toggle.MouseButton1Click:Connect(trigger)	
		end
		
		function intab:Slider(text, min, max, callback)
			local ms = game.Players.LocalPlayer:GetMouse()
			local Value
			
			local SliderFrame = Instance.new("Frame", battens)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(250, 114, 118)
			SliderFrame.BackgroundTransparency = 1
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Size = UDim2.new(0, 288,0, 38)
			
			local slstroke = Instance.new("UIStroke", SliderFrame)
			slstroke.Color = Color3.fromRGB(216, 86, 106)
			slstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			slstroke.Thickness = 0.53
			slstroke.Transparency = 0.24

			local SlPadding = Instance.new("UIPadding", SliderFrame)
			SlPadding.PaddingLeft = UDim.new(0, 25)
			
			local sltext = Instance.new("TextLabel", SliderFrame)
			sltext.BackgroundTransparency = 1
			sltext.BorderSizePixel = 0
			sltext.Size = UDim2.new(0.888, 0,1, 0)
			sltext.Position = UDim2.new(0.004, 0,-0.026, 0)
			sltext.FontFace = Font.fromId(12187362578)
			sltext.Text = text
			sltext.TextColor3 = Color3.fromRGB(255, 255, 255)
			sltext.TextSize = 15
			sltext.TextTransparency = 0.44
			sltext.TextXAlignment = Enum.TextXAlignment.Left
			
			local slval = Instance.new("TextLabel", SliderFrame)
			slval.BackgroundTransparency = 1
			slval.BorderSizePixel = 0
			slval.Size = UDim2.new(0, 57,0, 25)
			slval.Position = UDim2.new(0.885, 0,0.154, 0)
			slval.FontFace = Font.fromId(12187362578)
			slval.Text = tostring(min)
			slval.TextColor3 = Color3.fromRGB(255, 255, 255)
			slval.TextSize = 15
			slval.TextTransparency = 0.44
			slval.TextXAlignment = Enum.TextXAlignment.Left
			
			local slback = Instance.new("TextButton", SliderFrame)
			slback.BackgroundTransparency = 0.35
			slback.BackgroundColor3 = Color3.fromRGB(188, 123, 124)
			slback.BorderSizePixel = 0
			slback.Size = UDim2.new(0, 142,0, 6)
			slback.Position = UDim2.new(0.320, 0,0.418, 0)
			slback.Text = ""
			
			local slbackcorner = Instance.new("UICorner", slback)
			slbackcorner.CornerRadius = UDim.new(1, 100)
			
			local Slide = Instance.new("Frame", slback)
			Slide.BackgroundTransparency = 0.35
			Slide.BackgroundColor3 = Color3.fromRGB(238, 120, 122)
			Slide.BorderSizePixel = 0
			Slide.Size = UDim2.new(0, 0,0, 6)

			local SlideCorner = Instance.new("UICorner", Slide)
			SlideCorner.CornerRadius = UDim.new(1, 100)
			
			slback.MouseButton1Down:Connect(function()
				Value = math.floor(((tonumber(max) - tonumber(min)) / 142 * Slide.AbsoluteSize.X) + tonumber(min)) or 0
				pcall(function()
					callback(Value)
					slval.Text = Value
				end)
				Slide.Size = UDim2.new(0, math.clamp(ms.X - Slide.AbsoluteSize.X, 0, 142), 0, 6)
				moveconnection = ms.Move:Connect(function()
					Value = math.floor((((tonumber(max) - tonumber(min)) / 142) * Slide.AbsoluteSize.X) + tonumber(min))
					pcall(function()
						callback(Value)
						slval.Text = Value
					end)
					Slide.Size = UDim2.new(0, math.clamp(ms.X - Slide.AbsolutePosition.X, 0, 142), 0, 6)
				end)
				releaseconnection = uis.InputEnded:Connect(function(Mouse)
					if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
						Value = math.floor((((tonumber(max) - tonumber(min)) / 142) * Slide.AbsoluteSize.X) + tonumber(min))
						pcall(function()
							callback(Value)
						end)
						Slide.Size = UDim2.new(0, math.clamp(ms.X - Slide.AbsolutePosition.X, 0, 142), 0, 6)
						moveconnection:Disconnect()
						releaseconnection:Disconnect()
					end
				end)
			end)
		end	
		
		function intab:Seperator(text)
			local Seperator = Instance.new("Frame", battens)
			Seperator.BackgroundTransparency = 1
			Seperator.Size = UDim2.new(0, 282,0, 38)
			
			local septext = Instance.new("TextLabel", Seperator)
			septext.Size = UDim2.new(0, 282,0, 38)          
			septext.BackgroundTransparency = 1
			septext.FontFace = Font.fromId(12187362578)
			septext.Text = text
			septext.TextColor3 = Color3.fromRGB(209, 209, 209)
			septext.TextSize = 17
			septext.TextTransparency = 0.49
			septext.TextXAlignment = Enum.TextXAlignment.Center
		end

        function intab:Dropdown(text, list, callback)
            local BodyYSize = 0
            local IsDropped = false

            local DropdownFrame = Instance.new("Frame", battens)
			DropdownFrame.BackgroundTransparency = 0.33
            DropdownFrame.BackgroundColor3 = Color3.new(0.211765, 0.211765, 0.211765)
			DropdownFrame.Size = UDim2.new(0, 282,0, 38)
            DropdownFrame.BorderSizePixel = 0

            local DropText = Instance.new("TextLabel", DropdownFrame)
			DropText.BackgroundTransparency = 1
			DropText.BorderSizePixel = 0
			DropText.Size = UDim2.new(0.888, 0,1, 0)
			DropText.Position = UDim2.new(0.004, 0,-0.026, 0)
			DropText.FontFace = Font.fromId(12187362578)
			DropText.Text = text
			DropText.TextColor3 = Color3.fromRGB(255, 255, 255)
			DropText.TextSize = 15
			DropText.TextTransparency = 0.44
			DropText.TextXAlignment = Enum.TextXAlignment.Left

            local DdPadding = Instance.new("UIPadding", DropdownFrame)
			DdPadding.PaddingLeft = UDim.new(0, 25)

            local DropButton = Instance.new("TextButton", DropdownFrame)
            DropButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropButton.BackgroundTransparency = 1.000
            DropButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
            DropButton.BorderSizePixel = 0
			DropButton.Size = UDim2.new(0, 57,0, 25)
			DropButton.Position = UDim2.new(0.745, 0,0.154, 0)
            DropButton.ZIndex = 2
            DropButton.FontFace = Font.fromId(12187362578)
            DropButton.Text = "+"
            DropButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropButton.TextSize = 14.000

            local DropdownContainer = Instance.new("Frame", DropButton)
            DropdownContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownContainer.BackgroundTransparency = 1.000
            DropdownContainer.Position = UDim2.new(-3, 0, 0, 0)
            DropdownContainer.Size = UDim2.new(0, 197, 0, BodyYSize)
            DropdownContainer.Visible = false
            DropdownContainer.ZIndex = 3

            local Droplist = Instance.new("UIListLayout", DropdownContainer)
            Droplist.FillDirection = Enum.FillDirection.Vertical
            Droplist.HorizontalAlignment = Enum.HorizontalAlignment.Center
            Droplist.VerticalAlignment = Enum.VerticalAlignment.Top
            Droplist.SortOrder = Enum.SortOrder.LayoutOrder
            Droplist.Padding = UDim.new(0, 3)

            for i,v in pairs(list) do
            BodyYSize = BodyYSize + 27
            local DropBtn2 = Instance.new("TextButton", DropdownContainer)
			DropBtn2.BackgroundTransparency = 0.35
			DropBtn2.BackgroundColor3 = Color3.new(0.266667, 0.266667, 0.266667)
			DropBtn2.BorderSizePixel = 0
			DropBtn2.Size = UDim2.new(0, 142,0, 26)
			DropBtn2.Position = UDim2.new(0.320, 0,0.418, 0)
            DropBtn2.Text = v
            DropBtn2.ZIndex = 10
            DropBtn2.FontFace = Font.fromId(12187362578)
            DropBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropBtn2.TextSize = 14.000
			

            DropButton.MouseButton1Click:Connect(function()
            if not IsDropped then
                IsDropped = true
                DropdownContainer.Visible = true
                else
                IsDropped = false
                DropdownContainer.Visible = false
                end
            end)

            DropBtn2.MouseButton1Click:Connect(function()
                DropButton.Text = v
                callback(v)
                IsDropped = false
                    DropdownContainer.Visible = false
                end)
            end




        end
			
		return intab
		
		
	end
	
	return tabs
	
end

local Ta
