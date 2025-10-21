return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<space>a", nil, desc = "AI/Claude Code" },
			{ "<space>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<space>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<space>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<space>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<space>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<space>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<space>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil" },
			},
			-- Diff management
			{ "<space>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<space>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
}
