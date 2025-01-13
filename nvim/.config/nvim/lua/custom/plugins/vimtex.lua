return {
    {
	"lervag/vimtex",
	lazy = false,     -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	config = function ()
	    -- VimTeX configuration goes here, e.g.
	    vim.g.vimtex_view_method = "zathura"
	    vim.g.vimtex_compiler_method = "tectonic"

	    local error_callback = function ()
		-- TODO: Implement something that notifies me in Neovim
		-- when the make command fails, without having to check 
		-- the compile logs with <lo> everytime.
	    end

	    -- Autocommand to determine VimTex main document based on working directory
	    vim.api.nvim_create_autocmd("BufReadPre", {
		callback = function ()
		    local cwd = vim.fn.getcwd()
		    local first, last = string.find(cwd, "resume")
		    if first and last then
			-- TODO: Fix a more flexible, dynamic way of determining main vimtex document (see vimtex-multi-file)
			vim.b.vimtex_main = cwd .. "/main.tex"
			vim.g.vimtex_compiler_method = "generic"
			vim.g.vimtex_compiler_generic = {
			    command = "make",
			}
		   end
		end
	    })
	end
    }
}
