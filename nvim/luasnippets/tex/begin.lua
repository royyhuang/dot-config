local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("tex", {
	s("begin", {
		t("\\begin{"),
		i(1, "env"), -- Insert node for the environment name
		t("}"),
		t({ "", "\t" }), -- New line and indentation
		i(0), -- Final insert node for the content inside the environment
		t({ "", "\\end{" }),
		f(function(args)
			return args[1][1] -- Copy the environment name
		end, { 1 }),
		t("}"),
	}),
})
