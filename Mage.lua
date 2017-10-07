--[[
  
--]]
local addonName, rh = ...

--local spec = "Frost"

local mage = {}

mage["Frost"] = {
  ["Frostbolt"] = 1, -- 1: Downtime
  ["Frozen Orb"] = 0, -- 2 on CD, 0 during CD
  ["Icy Veins"] = 0, -- 7 on CD, 0 during CD
  ["Ice Lance"] = 0, --  4 on Fingers of Frost, 3 on 5 Icicles, 0 otherwise
  ["Flurry"] = 0, -- 5 on Brain Freeze, 0 otherwise
  ["Ebonbolt"] = 0, -- 5 on CD + !Brain Freeze
  ["Ice Nova"] = 0 -- 6 on CD
}

function rh.MageRotationStateCheck(spec)
  if spec == "Frost" then
    mage[spec]["Ice Lance"] = math.max(rh.BuffTest("Icicles", 3, 0, 5), rh.BuffTest("Fingers of Frost", 4, 0))
    -- etc
  elseif spec == "Fire" then

  elseif spec == "Arcane" then

  end

  rh.getHighest(mage[spec])
end

