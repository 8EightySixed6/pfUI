if GetBuildInfo() ~= "2.4.3" then return end

message("TBC compat module loaded. Good Luck!")

-- load pfUI environment
setfenv(1, pfUI:GetEnvironment())

-- the "MiniMapTrackingFrame" is called "MiniMapTracking"
pfUI.api.MiniMapTrackingFrame = _G.MiniMapTracking
pfUI.api.UIOptionsFrame = _G.InterfaceOptionsFrame

-- tbc name of the friendlist button has changed
for i=1, FRIENDS_TO_DISPLAY do
  _G["FriendsFrameFriendButton"..i.."ButtonTextNameLocation"] = _G["FriendsFrameFriendButton"..i.."ButtonTextLocation"]
end

-- gfind got replaced by gmatch
pfUI.api.gfind = string.gmatch

-- blacklist pfUI functions
pfUI.api.hooksecurefunc = _G.hooksecurefunc

-- tbc removed the offset of -1
function pfUI.api.GetPlayerBuff(id, btype)
  return _G.GetPlayerBuff(id+1, btype)
end

-- tbc uses a "Cooldown" frametype
function pfUI.api.CreateFrame(f, n, p, t)
  if f == "Model" and t == "CooldownFrameTemplate" then
    return _G.CreateFrame("Cooldown", n, p, t)
  else
    return _G.CreateFrame(f, n, p, t)
  end
end

-- tbc changed the return values
function pfUI.api.UnitBuff(unitstr, i)
  local name, rank, icon, count = _G.UnitBuff(unitstr, i)
  return icon, count
end

-- blacklist unrequired modules
pfUI.module.autoshift = true
pfUI.module.itemclick = true

-- the function GetContainerNumSlots returns numbers for keyrings in tbc
function pfUI.api.GetContainerNumSlots(bag)
  if bag == -2 and pfUI.bag and not pfUI.bag.showKeyring then
    return 0
  else
    return _G.GetContainerNumSlots(bag)
  end
end