return {
	{
    	'nvim-telescope/telescope.nvim',
    	dependencies = {
    		'nvim-lua/plenary.nvim',
        	{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release " ..
						"&& cmake --build build --config Release " ..
						"&& cmake --install build --prefix build"
			}
	  	},

	    config = function ()
	      	require('telescope').setup{
	      	  	pickers = {
	      			find_files = { theme = "dropdown" }
	      	  	},
	      	  	extensions = {
	      			fzf = {
	      			  	fuzzy = true,                    -- false will only do exact matching
	      			  	override_generic_sorter = true,  -- override the generic sorter
	      			  	override_file_sorter = true,     -- override the file sorter
	      			  	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
	      											   -- the default case_mode is "smart_case"
	      			}
	      	  	}
	      	}
	      	require('telescope').load_extension('fzf')
	      	-- telescope keybindings
	      	local builtin = require('telescope.builtin')
			local keyset = vim.keymap.set
	      	keyset("n", "<space>.", builtin.find_files, {})
	      	keyset("n", "<space>fj", builtin.live_grep, {})
	      	keyset("n", "<space>bi", builtin.buffers, {})
	      	keyset("n", "<space>fh", builtin.help_tags, {})
	    end
    }
}
