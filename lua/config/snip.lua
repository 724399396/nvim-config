-- Lazy load snippets
-- Load custom typescript snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/typescript" } })
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/python" } })
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/rust" } })
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/vue" } })
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/flutter" } })
