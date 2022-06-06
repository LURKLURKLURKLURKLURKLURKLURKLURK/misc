--not mine,came from octohook which is made by liam

local settings = {
    speed = 65;
    radius = 3;
    length = 5;
    width = 2;
    zindex = 100;
    dotsize = 1;
    enabled = true;
    spin = true;
    dot = false;
    border = true;
    color = Color3.fromRGB(255,255,255);
    transparency = 1;
}

local rs = game:GetService('RunService')
local mouse = game:GetService('Players').LocalPlayer:GetMouse()
local drawings = {}

for i = 1,4 do
    local d = Drawing.new('Line')
    local d2 = Drawing.new('Line')
    drawings[#drawings+1] = {d,d2}
end

local function newcircle(p)
    local d = Drawing.new('Circle')
    local d2 = Drawing.new('Circle')
    for i,v in next, p or {} do
        d[i]=v
        d2[i]= i == 'Radius' and v*1.75 or v
    end
    return {d,d2}
end

local dot = newcircle({Radius = 1, NumSides = 25, Filled = true})

local ang = 0

rs.RenderStepped:Connect(function()
    ang += (1 / settings.speed)
    local pos = Vector2.new(mouse.X,mouse.Y+36)
    local ang = settings.spin and ang or 0

    dot[1].Position = pos
    dot[1].Color = settings.color
    dot[1].ZIndex = settings.zindex+1
    dot[1].Visible = settings.enabled and settings.dot
    dot[1].Radius = settings.dotsize
    dot[1].Transparency = settings.transparency

    dot[2].Position = pos
    dot[2].ZIndex = settings.zindex
    dot[2].Visible = settings.enabled and settings.dot
    dot[2].Radius = settings.dotsize + 1.25
    dot[2].Transparency = settings.transparency

    for i,v in next, drawings do

        v[1].Visible = settings.enabled
        v[2].Visible = settings.enabled and settings.border

        if settings.enabled then

            local function solvex1(off)
                return (math.cos(ang + (i * (math.pi/2))) * ((settings.radius + (off or 0)) + ((settings.radius * math.sin(ang)) / 9)))
            end

            local function solvey1(off)
                return (math.sin(ang + (i * (math.pi/2))) * ((settings.radius + (off or 0)) + ((settings.radius * math.sin(ang)) / 9)))
            end

            local function solvex2(off)
                return (math.cos(ang + (i * (math.pi/2))) * ((settings.radius + (off or 0)) + ((settings.radius * math.sin(ang)) / 9)))
            end

            local function solvey2(off)
                return (math.sin(ang + (i * (math.pi/2))) * ((settings.radius + (off or 0)) + ((settings.radius * math.sin(ang)) / 9)))
            end

            local x1,x2,x3,x4,y1,y2,y3,y4
            x1 = solvex1()
            x2 = solvex2(settings.length)
            x3 = solvex1(-1)
            x4 = solvex2(settings.length+1)

            y1 = solvey1()
            y2 = solvey2(settings.length)
            y3 = solvey1(-1)
            y4 = solvey2(settings.length+1)

            v[1].Transparency = settings.transparency
            v[1].ZIndex = settings.zindex+1
            v[1].Color = settings.color
            v[1].Thickness = settings.width
            v[1].From = pos + Vector2.new(x1,y1)
            v[1].To = pos + Vector2.new(x2,y2)

            v[2].Transparency = settings.transparency
            v[2].ZIndex = settings.zindex
            v[2].Color = Color3.new(0,0,0)
            v[2].Thickness = settings.width + 2
            v[2].From = pos + Vector2.new(x3,y3)
            v[2].To = pos + Vector2.new(x4,y4)
        end

    end
end)

return settings
