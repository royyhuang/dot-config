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
		keys = {
			{
				"<space>.",
				function ()
					require("telescope.builtin").find_files()
				end,
				mode="n",
				desc="Telescope find files"
			},
			{
				"<space>fj",
				function ()
					require("telescope.builtin").live_grep()
				end,
				mode="n",
				desc="Telescope live grep"
			},
			{
				"<space>bi",
				function ()
					require("telescope.builtin").buffers()
				end,
				mode="n",
				desc="Telescope list buffers"
			},
			{
				"<space>fh",
				function ()
					require("telescope.builtin").help_tags()
				end,
				mode="n",
				desc="Telescope helps"
			},
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
	    end
    }
}
