-- quite buggy 😅
-- Credits: https://github.com/falleco/dotfiles/blob/main/sketchybar
---@diagnostic disable: need-check-nil
local app_icons = require("helpers.spaces_util.app_icons")
local sbar_utils = require("helpers.spaces_util.sbar_util")

local function parse_string_to_table(s)
  local result = {}
  for line in s:gmatch("([^\n]+)") do
    table.insert(result, line)
  end
  return result
end

-- Hardcoded workspaces to display (1-5)
local aerospace_workspaces = { "1", "2", "3", "4", "5" }

local function get_current_workspace()
  local file = io.popen("aerospace list-workspaces --focused")
  local result = file:read("*a")
  file:close()
  return parse_string_to_table(result)[1]
end

local initial_current_workspace = get_current_workspace()

local Window_Manager = {
  events = {
    window_change = "space_windows_change", -- TODO: replace with real event name
    focus_change = "aerospace_workspace_change",
  },
  observer = nil,
}

function Window_Manager:init()
  LOG:info("Creating spaces. Found " .. #aerospace_workspaces .. " workspaces")
  for i, workspace in ipairs(aerospace_workspaces) do
    LOG:info("Creating space item for workspace: " .. workspace .. " (idx: " .. i .. ")")
    local selected = workspace == initial_current_workspace
    local space_item = sbar_utils:add_space_item(workspace, tonumber(workspace) or i)
    sbar_utils:highlight_focused_space(space_item, selected)

    space_item:subscribe("mouse.clicked", function(env)
      LOG:info(env.NAME)
      self:perform_switch_desktop(env.BUTTON, env.SID)
    end)
  end
  -- init app icons for each space
  self:update_space_label()
end

function Window_Manager:start_watcher()
  local watcher = SBAR.add("item", {
    drawing = false,
    updates = true,
    update_freq = 1,
  })

  watcher:subscribe("routine", function(env)
    -- Update space labels
    self:update_space_label()
    -- Update focused workspace highlighting
    self:update_focused_workspace()
  end)
end

function Window_Manager:update_focused_workspace()
  local current = get_current_workspace()
  for _, workspace in ipairs(aerospace_workspaces) do
    local space_item = sbar_utils.created_spaces[workspace]
    if space_item then
      local is_focused = workspace == current
      sbar_utils:highlight_focused_space(space_item, is_focused)
    end
  end
end

--- @param button string the mouse button clicked
--- @param sid string clicked space's id
function Window_Manager:perform_switch_desktop(button, sid)
  if button == "left" then
    SBAR.exec("aerospace workspace " .. sid)
  elseif button == "right" then
    -- not implemented
  elseif button == "other" then -- for eaxmple, middle click
    LOG:info("Middle click on space " .. sid)
  end
end

function Window_Manager:update_space_label()
  for _, workspace in ipairs(aerospace_workspaces) do
    SBAR.exec("aerospace list-windows --workspace " .. workspace .. " --format '%{app-name}' ", function(apps)
      sbar_utils:update_space(workspace, parse_string_to_table(apps))
    end)
  end
end

return Window_Manager
