local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("tex", {
	s("fig", {
		t({ "\\begin{figure}[h]", "\t\\centering", "\t\\includegraphics[width=\\textwidth]{" }),
		i(1, "path/to/image"), -- Insert node for the image path
		t({ "}", "\t\\mycaption{" }),
		i(2, "Short caption"), -- Insert node for the short caption
		t("}{"),
		i(3, "Long caption"), -- Insert node for the long caption
		t({ "}", "\\end{figure}" }),
	}),
})
