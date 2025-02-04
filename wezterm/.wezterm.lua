local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- WSL2 configuration
config.default_domain = 'WSL:Debian' -- Change Ubuntu to your distro name if different

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.95

-- Font configuration
config.font = wezterm.font('JetBrains Mono')
config.font_size = 11.0

-- Window configuration
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- Status bar configuration (AI-generated)
wezterm.on("update-status", function(window, pane)
  -- Get the current working directory
  local basename = function(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
  end
  local cwd = basename(pane:get_current_working_directory())

  -- Get current process
  local process = basename(pane:get_foreground_process_name())

  -- Get current time
  local time = wezterm.strftime("%H:%M")

  -- Create left and right status elements
  local left_status = string.format(" %s  %s ", process, cwd)
  local right_status = string.format(" %s ", time)

  -- Calculate remaining space
  local width = window:get_dimensions().pixel_width
  local char_width = window:get_dimensions().cell_width
  local spaces = math.floor(width/char_width - #left_status - #right_status - 2)
  local spacer = string.rep(" ", spaces)

  -- Set the status bar text
  window:set_left_status(wezterm.format({
      {Background={Color="#333333"}},
      {Foreground={Color="#ffffff"}},
      {Text=left_status},
  }))
  window:set_right_status(wezterm.format({
      {Background={Color="#333333"}},
      {Foreground={Color="#ffffff"}},
      {Text=right_status},
  }))
end)

-- Enable status bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

config.leader = {
    key = 'Space',
    mods = 'CTRL',
    timeout_milliseconds = 1000
}

-- Key bindings for multiplexing
config.keys = {
    -- Open tab in new Window
    {
	key = '!',
	mods = 'CTRL|SHIFT',
	---@diagnostic disable-next-line: unused-local
	action = wezterm.action_callback(function(_win, pane)
	    ---@diagnostic disable-next-line: unused-local
	    local tab, window = pane:move_to_new_window()
	end),
    },
    -- New tab (from CWD)
    {
	key = 'c',
	mods = 'LEADER',
	action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    -- Close current tab
    {
	key = 'w',
	mods = 'LEADER',
	action = wezterm.action.CloseCurrentTab { confirm = true },
    },
    -- Split panes horizontally using Ctrl-Alt-Left/Right
    {
	key = 'LeftArrow',
	mods = 'CTRL|ALT',
	action = wezterm.action.SplitPane {
	    direction = 'Left',
	    size = { Percent = 50 },
	},
    },
    {
	key = 'RightArrow',
	mods = 'CTRL|ALT',
	action = wezterm.action.SplitPane {
	    direction = 'Right',
	    size = { Percent = 50 },
	},
    },
    {
	key = 'UpArrow',
	mods = 'CTRL|ALT',
	action = wezterm.action.SplitPane {
	    direction = 'Up',
	    size = { Percent = 50 },
	},
    },
    {
	key = 'DownArrow',
	mods = 'CTRL|ALT',
	action = wezterm.action.SplitPane {
	    direction = 'Down',
	    size = { Percent = 50 },
	},
    },
    -- Close current pane
    {
	key = 'w',
	mods = 'CTRL|SHIFT',
	action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    -- Navigate between panes
    {
	key = 'h',
	mods = 'ALT',
	action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
	key = 'j',
	mods = 'ALT',
	action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
	key = 'k',
	mods = 'ALT',
	action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
	key = 'l',
	mods = 'ALT',
	action = wezterm.action.ActivatePaneDirection 'Right',
    },
    -- Resize panes
    {
	key = 'LeftArrow',
	mods = 'CTRL|SHIFT',
	action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
	key = 'RightArrow',
	mods = 'CTRL|SHIFT',
	action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
	key = 'UpArrow',
	mods = 'CTRL|SHIFT',
	action = wezterm.action.AdjustPaneSize { 'Up', 5 },
    },
    {
	key = 'DownArrow',
	mods = 'CTRL|SHIFT',
	action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
}
--
-- Add bindings for tabs 1 through 9
for i = 1, 9 do
    table.insert(config.keys, {
	key = tostring(i),
	mods = 'LEADER',
	action = wezterm.action.ActivateTab(i - 1),  -- WezTerm tabs are 0-based
    })
end

return config
