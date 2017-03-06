-- L3M0N Designed
local credits="L3M0N" -- DO NOT CHANGE THIS AT ALL


-- Chat Command
local chat_enabled = true
local chat_commands = {"!thirdperson","/thirdperson"}


if CLIENT then
  local enabled=false
  local speed = 5
  local lrp_right = 40
  local lrp_forward = 100

local cr = {
	["CHudCrosshair"]=true,
}
hook.Add("HUDShouldDraw", "RemoveCrosshair_", function(name)
	if cr[name] then return false end
end)

function ToggleThirdPerson() enabled=!enabled print("Third Person Made By L3M0N") end
	
local myscrw, myscrh = 1768,992
print("Third Person Created By L3M0N\nhttp://steamcommunity.com/id/wwhitehouse")
function sw(width) local screenwidth = myscrw return width*ScrW()/screenwidth end
function sh(height) local screenheight = myscrh return height*ScrH()/screenheight end
local blur = Material("pp/blurscreen")
local function b(x, y, w, h)
	local X, Y = 0,0
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)
	for i = 1, 5 do
		blur:SetFloat("$blur", (i / 3) * (5))
		blur:Recompute()
render.UpdateScreenEffectTexture()
		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
   draw.RoundedBox(0,x,y,w,h,Color(0,0,0,205))
   surface.SetDrawColor(0,0,0)
   surface.DrawOutlinedRect(x,y,w,h)

end

function CreateThirdPersonAdjuster()
tpa = vgui.Create("DFrame")
tpa:SetTitle("")
tpa:SetSize(sw(350),sh(30))
tpa:SetPos(ScrW()/2-sw(175),sh(5))
tpa.Paint = function(self) b(0,0,self:GetWide(),self:GetTall()) end
tpa:SetDraggable(false)
tpa:ShowCloseButton(false)
local b = vgui.Create("DButton",tpa)
b:SetSize(tpa:GetWide()/2,sh(20))
b:SetPos( (tpa:GetWide()/2)-((tpa:GetWide()/2)/2),sh(5) )
b:SetText("Toggle Thirdperson")
b.DoClick = function() ToggleThirdPerson() end
end
if credits!="L3M0N" then return end
hook.Add("OnContextMenuOpen","tpaopen", CreateThirdPersonAdjuster)
hook.Add("OnContextMenuClose","tpaclose",function() if tpa then tpa:Remove() end end)
hook.Add( "OnPlayerChat", "tpaopen", function( ply, strText )
    if ply == LocalPlayer() and chat_enabled == true then
    strText = string.lower( strText ) 
	if ( table.HasValue(chat_commands,strText) ) then ToggleThirdPerson() return "" end
    end
    end  )




if credits!="L3M0N" then return end
function CalcView(ply, pos, angles, fov)
  if enabled == true and !ply:InVehicle() then
    local view = {}
    lrp_forward = Lerp(speed*FrameTime(),lrp_forward,100)
    if enabled!=true then
      lrp_right = Lerp(speed*FrameTime(),lrp_right,-35)
  else
      lrp_right = Lerp(speed*FrameTime(),lrp_right,-20)
  end
    if ply:KeyDown(IN_SPEED) then
      lrp_forward = Lerp(speed*FrameTime(),lrp_forward,150)
    end
    if ply:KeyDown(IN_DUCK) then
      lrp_forward = Lerp(speed*FrameTime(),lrp_forward,50)
    end
    if ply:KeyDown(IN_WALK) then
      lrp_forward = Lerp(speed*FrameTime(),lrp_forward,50)
    end
    if ply:KeyDown(IN_ATTACK2) then
      lrp_forward = Lerp(speed*FrameTime(),lrp_forward,2)
    end
    if ply:IsOnGround() == false then
      lrp_forward = Lerp(speed*FrameTime(),lrp_forward,200)
    end
    local _p = LocalPlayer()
    local TraceData = { }
    TraceData.start = _p:EyePos()
    TraceData.endpos = _p:EyePos() + ( _p:GetRight() * -lrp_right ) + ( _p:GetForward() * -lrp_forward )
    TraceData.filter = _p
    TraceData.mask = MASK_SOLID_BRUSHONLY

    local Trace = util.TraceLine( TraceData )

    local v = { }
    v.origin = Trace.HitPos + _p:GetForward() *10
    v.angles = _p:GetAngles()
    v.fov = _f

    return v
  end
end

hook.Add("CalcView", "hzn_CalcView", CalcView)

hook.Add("ShouldDrawLocalPlayer", "hzn_ShouldDrawLocalPlayer", function(ply)
        return enabled
end)
local CrosshairS = 5
hook.Add("HUDPaint", "hzn_Crosshair", function()
  -- Credit For Crosshair: termy58 (I COULDNT FUCKING FIGURE IT OUT - l3m0n)
if enabled == true and LocalPlayer():Alive()  then
  local player = LocalPlayer()
  local t = {}
t.start = player:GetShootPos()
t.endpos = t.start + player:GetAimVector() * 9000
t.filter = player
local tr = util.TraceLine(t)
local pos = tr.HitPos:ToScreen()
local fraction = math.min((tr.HitPos - t.start):Length(), 1024) / 1024
local size = 10 + 20 * (1.0 - fraction)
local offset = size * 0.5
local offset2 = offset - (size * 0.1)
t = {}
t.start =   enabled or player:GetPos()
t.endpos = tr.HitPos + tr.HitNormal * 5
t.filter = player
local tr = util.TraceLine(t)
surface.SetDrawColor(255,255,255,255)
CrosshairS = Lerp(speed*FrameTime(),CrosshairS,5)
if LocalPlayer():KeyDown(IN_WALK) or LocalPlayer():KeyDown(IN_DUCK) then
  CrosshairS = Lerp(speed*FrameTime(),CrosshairS,1)
end
if LocalPlayer():KeyDown(IN_FORWARD) then
  CrosshairS = Lerp(speed*FrameTime(),CrosshairS,20)
end
if LocalPlayer():KeyDown(IN_SPEED) then
  CrosshairS = Lerp(speed*FrameTime(),CrosshairS,40)
end
if LocalPlayer():KeyDown(IN_ATTACK2) then
  CrosshairS = Lerp(speed*FrameTime(),CrosshairS,1)
end
if LocalPlayer():KeyDown(IN_ATTACK) then
  CrosshairS = Lerp(speed*FrameTime(),CrosshairS,20)
end
if !LocalPlayer():IsOnGround() then
  CrosshairS = Lerp(speed*FrameTime(),CrosshairS,40)
end
else
 if (LocalPlayer():Alive())  then
  CrosshairS = Lerp(speed*FrameTime(),CrosshairS,5)
  if LocalPlayer():KeyDown(IN_WALK) or LocalPlayer():KeyDown(IN_DUCK) then
    CrosshairS = Lerp(speed*FrameTime(),CrosshairS,1)
  end
  if LocalPlayer():KeyDown(IN_FORWARD) then
    CrosshairS = Lerp(speed*FrameTime(),CrosshairS,20)
  end
  if LocalPlayer():KeyDown(IN_SPEED) then
    CrosshairS = Lerp(speed*FrameTime(),CrosshairS,40)
  end
  if LocalPlayer():KeyDown(IN_ATTACK2) then
    CrosshairS = Lerp(speed*FrameTime(),CrosshairS,1)
  end
  if LocalPlayer():KeyDown(IN_ATTACK) then
    CrosshairS = Lerp(speed*FrameTime(),CrosshairS,20)
  end
  if !LocalPlayer():IsOnGround() then
    CrosshairS = Lerp(speed*FrameTime(),CrosshairS,40)
  end
if !LocalPlayer():InVehicle() and !LocalPlayer():KeyDown(IN_ATTACK2) then
  surface.DrawCircle(ScrW()/2,ScrH()/2,sw(CrosshairS), 255, 255,255, 10)
end
end
end
end)


hook.Add( "PostDrawOpaqueRenderables", "hzn_crosshair_", function()
	local trace = LocalPlayer():GetEyeTrace()
	local angle = trace.HitNormal:Angle()
 if (enabled==true) then
	cam.Start3D2D( trace.HitPos, angle+Angle(90,0,0), 1 )
    surface.DrawCircle(0,0,CrosshairS, 255, 255,255, 10)
	cam.End3D2D()
end
end )
end
