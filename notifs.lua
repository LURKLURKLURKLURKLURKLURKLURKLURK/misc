local Camera = workspace.CurrentCamera 
local TextService = game.TextService
local NOTIFICATIONS = {
    accent = Color3.fromRGB(200,0,207),
}
do 
    local piesolutionsNOTIFS = Instance.new("ScreenGui");
    local container = Instance.new("Frame");
    local UIListLayout = Instance.new("UIListLayout");
    
    piesolutionsNOTIFS.Name = "pie.solutions NOTIFS";
    piesolutionsNOTIFS.Parent = game.CoreGui
    syn.protect_gui(piesolutionsNOTIFS);
    container.Name = "container";
    container.Parent = piesolutionsNOTIFS;
    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    container.BackgroundTransparency = 1.000;
    container.Position = UDim2.new(0, 4, 0, 0);
    container.Size = UDim2.new(0, 360, 0, 271);
    
    UIListLayout.Parent = container;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Padding = UDim.new(0, 4);
    
    local function FixTextSize(Object, FixSize)
        
        assert((Object or typeof(Object) == "Instance"));
        assert((FixSize or type(FixSize) == "number"));
    
        local TextSize = TextService.GetTextSize(TextService,
            Object.Text, Object.TextSize, Object.Font, Vector2.new(Camera.ViewportSize.X, Object.AbsoluteSize.Y)
        ).X;
    
        Object.Size = UDim2.new(0, TextSize + FixSize, 0, Object.Size.Y.Offset);
    end;
    
     function NOTIFICATIONS:Notify(text,time)
        text = text or 'Notification';
        time = time or 1;
        local mainNotif = Instance.new("Frame");
        local innerNotif = Instance.new("Frame",mainNotif);
        local notifText = Instance.new("TextLabel",innerNotif);
        local accentNotif = Instance.new("Frame");
    
        mainNotif.Name = "mainNotif";
        mainNotif.Parent = container;
        mainNotif.BackgroundColor3 = Color3.fromRGB(75,75,75);
        mainNotif.BorderColor3 = Color3.fromRGB(0, 0, 0);
        mainNotif.ClipsDescendants = true;
        mainNotif.Position = UDim2.new(0.055555582, 0, 0.405904055, 0);
        mainNotif.Size = UDim2.new(0, 0, 0, 21);
        
        innerNotif.Name = "innerNotif";
        innerNotif.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
        innerNotif.BorderColor3 = Color3.fromRGB(0, 0, 0);
        innerNotif.Size = UDim2.new(0, 337, 0, 17);
        
        
        notifText.Name = "notifText";
        notifText.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        notifText.BackgroundTransparency = 1.000;
        notifText.Size = UDim2.new(0, 331, 0, 17);
        notifText.Font = Enum.Font.Code;
        notifText.Text = ' '..tostring(text);
        notifText.TextColor3 = Color3.fromRGB(255, 255, 255);
        notifText.TextSize = 14.000;
        notifText.TextStrokeTransparency = 0.500;
        notifText.TextXAlignment = Enum.TextXAlignment.Left;
        
        FixTextSize(notifText,0);
        innerNotif.Size = UDim2.new(0,notifText.Size.X.Offset + 6,0,17);
        innerNotif.Position = UDim2.new(0, 0, 0, 0);
        accentNotif.Name = "accentNotif";
        accentNotif.Parent = mainNotif;
        accentNotif.BackgroundColor3 = NOTIFICATIONS.accent;
        accentNotif.BorderColor3 = Color3.fromRGB(0, 0, 0);
        accentNotif.Size = UDim2.new(0, 343, 0, 1);
        
        mainNotif:TweenSize(UDim2.new(0,innerNotif.Size.X.Offset + 4,0,21),'Out','Sine',0.5,true);
        innerNotif.Position = UDim2.new(0, 2, 0, 2);
        accentNotif.Size = UDim2.new(0,innerNotif.Size.X.Offset + 4,0,1);
        accentNotif.Position = UDim2.new(0,0,0,0);
        
        task.spawn(function()
            task.wait(time);
            mainNotif:TweenSize(UDim2.new(0,0,0,21),"In","Sine",0.5,true);
            delay(0.3,function()
                mainNotif:Destroy();
            end);
        end);
    end;
end

NOTIFICATIONS:Notify('Notifications Loaded!',2)
return NOTIFICATIONS
