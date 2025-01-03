return {
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
		"cpp",
		"clojure",
		"bash",
	      	"lua",
	      	"typescript",
		"tsx",
	      	"javascript",
		"scss",
		"rust",
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
  },
}
