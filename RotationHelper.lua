--[[

--]]

local addonName, rh = ...

local EventFrame = CreateFrame("FRAME", "ROTH_Events")
EventFrame:RegisterEvent("UNIT_AURA")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

local PlayerClass = "none"
local PlayerSpec = "none"

function rh.msg(text)
 DEFAULT_CHAT_FRAME:AddMessage(text);
end

function EventFrame_OnEvent(self, event, name, ...)
  if event == "PLAYER_ENTERING_WORLD" then
    PlayerClass = UnitClass("player")
    PlayerSpec = GetSpec()
  elseif event == "UNIT_AURA" and name == "player" then
    CallRotationStateCheck(PlayerClass, PlayerSpec)  -- the magic
  elseif event == "PLAYER_SPECIALIZATION_CHANGED" and name == "player" then
    rh.msg(name)
    PlayerSpec = GetSpec()
  end
end

function CallRotationStateCheck(class, spec)
  if class == "Mage" then rh.MageRotationStateCheck(spec)
  end
end

function GetSpec()
  local specID = GetSpecialization()
  local id, name = GetSpecializationInfo(specID)
  return name
end

-- Loop through the spec table and pick the highest priority one
function rh.getHighest(table)
  local highestPriority = -1
  local highestName = "x"
  for name, priority in pairs(table) do
    if (priority > highestPriority) then 
      highestPriority = priority 
      highestName = name
    end
  end
  if highestPriority > -1 then
    rh.msg(highestName..": "..highestPriority)
  else
    rh.msg("Priority error")
  end
end

--[[
@name string Buff name
@activeValue integer Return priority if player has buff @name
@inactiveValue integer Return prioriy if player does not have buff @name
@activeCount [integer] Consider activeValue only if buff has @activeCount stack of buff @name
--]]
function rh.BuffTest(name, activeValue, inactiveValue, activeCount)
  activeCount = activeCount or false
  local name, rank, icon, count = UnitAura("player", name)
  if name then
    if activeCount then
      if activeCount == count then
        return activeValue
      else
        return inactiveValue
      end
    end
    return activeValue
  end
  return inactiveValue
end

EventFrame:SetScript("OnEvent", EventFrame_OnEvent)