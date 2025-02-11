return {
    {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = {
	    "nvim-treesitter/nvim-treesitter"
	},
	config = function ()
	    ---@diagnostic disable-next-line: missing-fields
	    require'treesitter-context'.setup {
		enable = false, -- Enable this plugin (Can be enabled/disabled later via commands)
		multiwindow = false, -- Enable multiwindow support.
		max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
		min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
		line_numbers = true,
		multiline_threshold = 20, -- Maximum number of lines to show for a single context
		trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
		mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
		-- Separator between context and content. Should be a single character string, like '-'.
		-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
		separator = nil,
		zindex = 20, -- The Z-index of the context window
		on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
	    }
	end
    },
    {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
	    require'nvim-treesitter.configs'.setup {
	      -- ta bort?
	      modules = {},
	      -- A list of parser names, or "all" (the listed parsers MUST always be installed)
	      ensure_installed = {
	      	"c",
		"c_sharp",
		"cpp",
		"clojure",
		"bash",
	      	"lua",
	      	"typescript",
		"tsx",
	      	"javascript",
		"scss",
		"rust",
		"http",
		"regex",
		"r",
		"python",
		"perl",
		"php",
		"objdump",
		"nix",
		"nasm",
		"mermaid",
		"make",
	      	"vim",
	      	"vimdoc",
		"latex",
		"bibtex",
		"json",
		"jsdoc",
		"graphql",
	      	"query",
		"yaml",
		"toml",
		"git_rebase",
		"git_config",
		"dockerfile",
		"diff",
		"csv",
		"zig",
		"ssh_config",
		"sql",
	      	"markdown",
	      	"markdown_inline"
	      },
	      sync_install = false,
	      ignore_install = {},
	      -- Automatically install missing parsers when entering buffer
	      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	      auto_install = false,

	      highlight = {
		  enable = true,
		  disable = function(lang, buf)

		      if lang == 'latex' then
			  return true
		      end

		      local max_filesize = 100 * 1024 -- 100 KB
		      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		      if ok and stats and stats.size > max_filesize then
			  return true
		      end
		  end,

		  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		  -- Using this option may slow down your editor, and you may see some duplicate highlights.
		  -- Instead of true it can also be a list of languages
		  additional_vim_regex_highlighting = false,
	      },
	  }
      end
  }
}
