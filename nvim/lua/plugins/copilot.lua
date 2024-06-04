return {
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot.lua",
				config = function ()
					require("copilot").setup({
						suggestion = {enabled = false},
						pandel = {enabled = false},
					})
				end
			}
		},
		config = function()
			require("copilot_cmp").setup()
		end

	},
	{ 'AndreM222/copilot-lualine' }
}
