-- debug.lua
--
-- From https://github.com/nvim-lua/kickstart.nvim
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  -- The four above are default, only needed here because we override
  "vue",
}

return {
    {
	-- NOTE: Yes, you can install new plugins here!
	'mfussenegger/nvim-dap',
	-- NOTE: And you can specify dependencies as well
	config = function()
	    local dap = require 'dap'
	    local dapui = require 'dapui'

	    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
	    -- Change breakpoint icons
	    -- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
	    -- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
	    -- local breakpoint_icons = vim.g.have_nerd_font
	    --     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
	    --   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
	    -- for type, icon in pairs(breakpoint_icons) do
	    --   local tp = 'Dap' .. type
	    --   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
	    --   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
	    -- end

	    require('mason-nvim-dap').setup {
		-- Makes a best effort to setup the various debuggers with
		-- reasonable debug configurations
		automatic_installation = false,

		-- You can provide additional configuration to the handlers,
		-- see mason-nvim-dap README for more information
		handlers = {},

		-- You'll need to check that you have the required things installed
		-- online, please don't ask me how to install them :)
		ensure_installed = {
		    -- https://github.com/mxsdev/nvim-dap-vscode-js/issues/58#issuecomment-2213230558 
		    'js-debug-adapter@v1.76.1'
		},
	    }

	    -- Dap UI setup
	    -- For more information, see |:help nvim-dap-ui|
	    ---@diagnostic disable-next-line: missing-fields
	    dapui.setup {
		-- Set icons to characters that are more likely to work in every terminal.
		--    Feel free to remove or use ones that you like more! :)
		--    Don't feel like these are good choices.
		icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
		---@diagnostic disable-next-line: missing-fields
		controls = {
		    icons = {
			pause = '⏸',
			play = '▶',
			step_into = '⏎',
			step_over = '⏭',
			step_out = '⏮',
			step_back = 'b',
			run_last = '▶▶',
			terminate = '⏹',
			disconnect = '⏏',
		    },
		},
	    }
	    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
	    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
	    dap.listeners.before.event_exited['dapui_config'] = dapui.close

	    if not dap.adapters['pwa-node'] then
		dap.adapters['pwa-node'] = {
		    type = 'server',
		    host = 'localhost',
		    port = '${port}',
		    executable = {
			command = 'node',
			args = {
			    vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer"),
			    '${port}',
			},
		    },
		}
	    end

	    if not dap.adapters["pwa-chrome"] then
		dap.adapters["pwa-chrome"] = {
		    type = "server",
		    host = "localhost",
		    port = "${port}",
		    executable = {
			command = "node",
			args = {
			    require("mason-registry").get_package("js-debug-adapter"):get_install_path()
			    .. "/js-debug/src/dapDebugServer.js",
			    "${port}",
			},
		    },
		}
	    end

	    if not dap.adapters['node'] then
		dap.adapters['node'] = function(cb, config)
		    if config.type == 'node' then
			config.type = 'pwa-node'
		    end
		    local nativeAdapter = dap.adapters['pwa-node']
		    if type(nativeAdapter) == 'function' then
			nativeAdapter(cb, config)
		    else
			cb(nativeAdapter)
		    end
		end
	    end

	    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
		dap.configurations[language] = {
		    -- Debug single nodejs files
		    {
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		    },
		    -- Debug nodejs processes (make sure to add --inspect when you run the process)
		    {
			type = "pwa-node",
			request = "attach",
			name = "Attach by process",
			processId = require("dap.utils").pick_process,
			port = 9229,
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
		    },
		    {
			type = "pwa-node",
			request = "attach",
			name = "Attach by port",
			port = 9229,
			cwd = "${workspacefolder}",
		    },
		    -- Debug web applications (client side)
		    -- Got this from https://github.com/nikolovlazar/dotfiles/blob/92c91ed035348c74e387ccd85ca19a376ea2f35e/.config/nvim/lua/plugins/dap.lua
		    -- The 'url' routine is apparently to be able to pick an URL of choice 
		    {
			type = "pwa-chrome",
			request = "attach",
			name = "Attach Chrome",
			url = function()
			    local co = coroutine.running()
			    return coroutine.create(function()
				vim.ui.input({
				    prompt = "Enter URL: ",
				    default = "http://localhost:8080",
				}, function(url)
				    if url == nil or url == "" then
					return
				    else
					coroutine.resume(co, url)
				    end
				end)
			    end)
			end,
			webRoot = "${workspacefolder}",
		    },
		    {
			type = "pwa-chrome",
			request = "launch",
			name = "Launch Chrome",
			url = function()
			    local co = coroutine.running()
			    return coroutine.create(function()
				vim.ui.input({
				    prompt = "Enter URL: ",
				    default = "http://localhost:8080",
				}, function(url)
				    if url == nil or url == "" then
					return
				    else
					coroutine.resume(co, url)
				    end
				end)
			    end)
			end,
			webRoot = vim.fn.getcwd(),
		    },
		    -- Divider for the launch.json derived configs
		    {
			name = "----- ↓ launch.json configs ↓ -----",
			type = "",
			request = "launch",
		    },
		}
	    end

	end,
	keys = {
	    -- per suggestion from Lazar Nikolov 
	    -- https://github.com/nikolovlazar/dotfiles/blob/92c91ed035348c74e387ccd85ca19a376ea2f35e/.config/nvim/lua/plugins/dap.lua
	    {
		"<leader>dO",
		function()
		    require("dap").step_out()
		end,
		desc = "Step Out",
	    },
	    {
		"<leader>do",
		function()
		    require("dap").step_over()
		end,
		desc = "Step Over",
	    },
	    {
		"<leader>da",
		function()
		    if vim.fn.filereadable(".vscode/launch.json") then
			local dap_vscode = require("dap.ext.vscode")
			dap_vscode.load_launchjs(nil, {
			    ["pwa-node"] = js_based_languages,
			    ["chrome"] = js_based_languages,
			    ["pwa-chrome"] = js_based_languages,
			})
		    end
		    require("dap").continue()
		end,
		desc = "Run with Args",
	    },
	    -- Basic debugging keymaps, feel free to change to your liking! 
	    -- (defaults?)
	    {
		'<F5>',
		function()
		    require('dap').continue()
		end,
		desc = 'Debug: Start/Continue',
	    },
	    {
		'<F1>',
		function()
		    require('dap').step_into()
		end,
		desc = 'Debug: Step Into',
	    },
	    {
		'<F2>',
		function()
		    require('dap').step_over()
		end,
		desc = 'Debug: Step Over',
	    },
	    {
		'<F3>',
		function()
		    require('dap').step_out()
		end,
		desc = 'Debug: Step Out',
	    },
	    {
		'<leader>b',
		function()
		    require('dap').toggle_breakpoint()
		end,
		desc = 'Debug: Toggle Breakpoint',
	    },
	    {
		'<leader>B',
		function()
		    require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
		end,
		desc = 'Debug: Set Breakpoint',
	    },
	    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
	    {
		'<F7>',
		function()
		    require('dapui').toggle()
		end,
		desc = 'Debug: See last session result.',
	    },
	},
	dependencies = {
	    -- Creates a beautiful debugger UI
	    'rcarriga/nvim-dap-ui',
	    -- Required dependency for nvim-dap-ui
	    'nvim-neotest/nvim-nio',
	    -- Installs the debug adapters for you
	    'williamboman/mason.nvim',
	    'jay-babu/mason-nvim-dap.nvim',
	    -- Highlighting
	    'theHamsta/nvim-dap-virtual-text',
	    -- Used to load .vscode/launch.json files
	    {
		"Joakker/lua-json5",
		build = "./install.sh",
	    },
	    -- Add your own debuggers here
	    -- e.g. 'leoluz/nvim-dap-go',
	    --    {
		-- "mxsdev/nvim-dap-vscode-js",
		-- config = function()
		    --     ---@diagnostic disable-next-line: missing-fields
		    --     require("dap-vscode-js").setup({
			-- 	-- Path of node executable. Defaults to $NODE_PATH, and then "node"
			-- 	-- node_path = "node",
			--
			--
			-- 	-- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path"
			-- 	    -- Deactivated per this issue
			-- 	    -- https://github.com/mxsdev/nvim-dap-vscode-js/issues/58
			-- 	-- debugger_cmd = { "js-debug-adapter" },
			--
			-- 	-- Path to vscode-js-debug installation.
			-- 	debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter"),
			--
			-- 	-- which adapters to register in nvim-dap
			-- 	adapters = {
			    -- 	    "chrome",
			    -- 	    "pwa-node",
			    -- 	    "pwa-chrome",
			    -- 	    "pwa-msedge",
			    -- 	    "pwa-extensionHost",
			    -- 	    "node-terminal",
			    -- 	},
			    --
			    -- 	-- Path for file logging
			    -- 	-- log_file_path = "(stdpath cache)/dap_vscode_js.log",
			    --
			    -- 	-- Logging level for output to file. Set to false to disable logging.
			    -- 	-- log_file_level = false,
			    --
			    -- 	-- Logging level for output to console. Set to false to disable console output.
			    -- 	-- log_console_level = vim.log.levels.ERROR,
			    --     })
			    -- end,
			    --    },
			},
		    }
		}
