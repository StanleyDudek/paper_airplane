-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

-- Dudekahedron, 2023

local M = {}

local resetTimer = 0
local cooldown = 5

local lastCheckedLaunchValue

local function onReset()
  electrics.values['launch'] = 0
  electrics.values['pitch'] = 0
  electrics.values['ppower'] = 0
  electrics.values['roll'] = 0
  lastCheckedLaunchValue = 0
end

local function updateGFX(dt)
  if electrics.values['launch'] == 1 then
    if resetTimer > cooldown then
      resetTimer = 0
      electrics.values['launch'] = 0
    end
    resetTimer = resetTimer + dt
  end
end

local function ppower(VALUE)
	electrics.values['ppower'] = VALUE
end


local function pitch(VALUE)
	electrics.values['pitch'] = VALUE
end

local function roll(VALUE)
	electrics.values['roll'] = VALUE
end

local function launch(VALUE)
  if lastCheckedLaunchValue == 1 then
    guihooks.message("Plane was already launched")
    return
  end
  lastCheckedLaunchValue = VALUE
  electrics.values['launch'] = 1
end

-- public interface
M.onInit    = onReset
M.onReset   = onReset
M.updateGFX = updateGFX

M.ppower = ppower
M.pitchUp = pitch
M.pitchDown = pitch
M.pitch = pitch
M.roll = roll
M.rollLeft = roll
M.rollRight = roll
M.launch = launch

return M
