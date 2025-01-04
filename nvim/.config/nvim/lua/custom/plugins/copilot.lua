return {
    {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
	    {
		"github/copilot.vim",
		config = function ()
		    -- disable inline suggestions. we're only interested in chat funciton
		    vim.api.nvim_create_autocmd("VimEnter", {
			command = "Copilot disable",
		    })
		end
	    }, -- or zbirenbaum/copilot.lua
	    { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	},
	build = "make tiktoken", -- Only on MacOS or Linux
	opts = {
	    -- See Configuration section for options
	},
	-- See Commands section for default commands if you want to lazy load on them
    },
} 
