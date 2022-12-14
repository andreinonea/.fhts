-- mod-version:3 -- lite-xl 2.1

local syntax = require "core.syntax"

syntax.add {
  name = "INI",
  files = { "%.ini$", "%.inf$", "%.cfg$", "%.editorconfig$", ".gitconfig" },
  comment = ';',
  patterns = {
    { pattern = ";.-\n", type = "comment" },
    { pattern = "#.-\n", type = "comment" },
    { pattern = { "%[", "%]" }, type = "keyword" },

    { pattern = { '"""', '"""', '\\' }, type = "string" },
    { pattern = { '"', '"', '\\' }, type = "string" },
    { pattern = { "'''", "'''" }, type = "string" },
    { pattern = { "'", "'" }, type = "string" },
    { pattern = "[A-Za-z0-9_%.%-]+%s*%f[=]", type = "function" },
    { pattern = "[%-+]?[0-9_]+%.[0-9_]+", type = "number" },
    { pattern = "[%-+]?[0-9_]+", type = "number" },
    { pattern = "[a-z]+", type = "symbol" },
  },
  symbols = {
    ["true"] = "literal",
    ["false"] = "literal",
  },
}
