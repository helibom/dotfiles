local wezterm = require('wezterm')
local config = wezterm.config_builder()
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

-- WSL2 configuration
config.default_domain = 'local' -- Change Ubuntu to your distro name if different

-- Color scheme
config.color_scheme = 'Catppuccin Mocha'
config.window_background_opacity = 0.95

-- Font configuration
config.font_size = 11.0
config.font = wezterm.font_with_fallback {
  'Fira Code',
  'JetBrains Mono',
}
config.warn_about_missing_glyphs = false

-- Window configuration
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

-- Enable status bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.enable_scroll_bar = true

tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'Catppuccin Mocha',
    tabs_enabled = true,
    theme_overrides = {
    -- Default colors from Catppuccin Mocha
      normal_mode = {
        a = { fg = '#181825', bg = '#cba6f7' },
        b = { fg = '#181825', bg = '#f5c2e7' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      copy_mode = {
        a = { fg = '#181825', bg = '#f9e2af' },
        b = { fg = '#f9e2af', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      search_mode = {
        a = { fg = '#181825', bg = '#a6e3a1' },
        b = { fg = '#a6e3a1', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      -- Defining colors for a new key table
      window_mode = {
        a = { fg = '#181825', bg = '#cba6f7' },
        b = { fg = '#cba6f7', bg = '#313244' },
        c = { fg = '#cdd6f4', bg = '#181825' },
      },
      -- Default tab colors
      tab = {
        active = { fg = '#c6a0f6', bg = '#313244' },
        inactive = { fg = '#c6a0f6', bg = '#181825' },
        inactive_hover = { fg = '#f5c2e7', bg = '#313244' },
      }
  },
  section_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
  },
  component_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thin,
      right = wezterm.nerdfonts.ple_left_half_circle_thin,
  },
  tab_separators = {
      left = wezterm.nerdfonts.ple_right_half_circle_thick,
      right = wezterm.nerdfonts.ple_left_half_circle_thick,
  },  },
  sections = {
      tabline_a = { 'mode' },
      tabline_b = { 'workspace' },
      tabline_c = { ' ' },
      tab_active = {
	  'index',
	  { 'cwd', padding = { left = 0, right = 1 } },
	  { 'zoomed', padding = 0 },
      },
      tab_inactive = { 'index', { 'cwd', padding = { left = 0, right = 1 } } },
      tabline_x = { 'ram', 'cpu' },
      tabline_y = { 'datetime', 'battery' },
      tabline_z = { 'domain' },
  },
  extensions = {},
})

config.leader = {
    key = 'Space',
    mods = 'CTRL',
    timeout_milliseconds = 1000
}

-- Key bindings for multiplexing
config.keys = {
    -- Disable default "Alt+Q" assignment
    {
	key = 'q',
	mods = 'ALT',
	action = wezterm.action.DisableDefaultAssignment,
    },
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
    -- Page Up
    {
	key = 'PageUp',
	mods = 'CTRL|ALT',
	action = wezterm.action.ScrollByPage(-0.5),
    },
    {
	key = 'PageDown',
	mods = 'CTRL|ALT',
	action = wezterm.action.ScrollByPage(0.5),
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
