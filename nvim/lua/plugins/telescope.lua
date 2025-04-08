return {
	{
    	"nvim-telescope/telescope.nvim",
    	dependencies = {
    		"nvim-lua/plenary.nvim",
        	{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make"
			},
			"nvim-telescope/telescope-file-browser.nvim",
	  	},
		keys = {
			{
				"<space>.",
				function ()
					require "telescope".extensions.file_browser.file_browser()
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
			{
				"<space>pp",
				function ()
					require("telescope").extensions.projects.projects{}
				end,
				mode="n",
				desc="Telescope projects"
			},
		},
	    config = function ()
	      	require("telescope").setup{
	      	  	pickers = {
	      			find_files = { theme = "ivy" },
					live_grep = { theme = "ivy" },
					buffers = { theme = "ivy" }
	      	  	},
	      	  	extensions = {
	      			fzf = {
	      			  	fuzzy = true,                    -- false will only do exact matching
	      			  	override_generic_sorter = true,  -- override the generic sorter
	      			  	override_file_sorter = true,     -- override the file sorter
	      			  	case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
	      											   -- the default case_mode is "smart_case"
	      			},
					file_browser = {
      					theme = "ivy",
      					-- disables netrw and use telescope-file-browser in its place
      					hijack_netrw = true,
    				},
	      	  	}
	      	}
	      	require("telescope").load_extension("fzf")
			require("telescope").load_extension("projects")
	    end
    }
}
