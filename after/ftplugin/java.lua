vim.bo.shiftwidth = 2
vim.bo.tabstop = 2

local jdtls = require("jdtls")

-- Debugger installation location
local DEBUGGER_LOCATION = vim.fn.stdpath("data") .. "/mason/packages"
-- Installation location of jdtls by nvim-lsp-installer
local JDTLS_LOCATION = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
-- Data directory - change it to your liking
local HOME = os.getenv("HOME")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = HOME .. "/workspace/java/" .. project_name

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Debugging
local bundles = {
	vim.fn.glob(DEBUGGER_LOCATION .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(DEBUGGER_LOCATION .. "/java-test/extension/server/*.jar"), "\n"))

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"-javaagent:" .. JDTLS_LOCATION .. "/lombok.jar",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(JDTLS_LOCATION .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		JDTLS_LOCATION .. "/config_linux",
		"-data",
		workspace_dir,
	},
	on_attach = require("config.lsp").on_attach,
	capabilities = require("config.lsp").capabilities,
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
			eclipse = {
				downloadSources = true,
			},
			maven = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-1.8",
						path = "/usr/lib/jvm/java-8-openjdk/",
					},
					{
						name = "JavaSE-11",
						path = "/usr/lib/jvm/java-11-openjdk/",
					},
					{
						name = "JavaSE-17",
						path = "/usr/lib/jvm/java-17-openjdk/",
					},
				},
			},
			implementationsCodeLens = {
				enabled = false,
			},
			referencesCodeLens = {
				enabled = false,
			},
			references = {
				includeDecompiledSources = true,
			},
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
			},
			extendedClientCapabilities = extendedClientCapabilities,
			sources = {
				organizeImports = {
					starThreshold = 9999,
					staticStarThreshold = 9999,
				},
			},
			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
			},
		},
	},
	flags = {
		allow_incremental_sync = true,
	},
	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles,
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- Add the commands
require("jdtls.setup").add_commands()
vim.api.nvim_exec(
	[[
	command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
	command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
	command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
	command! -buffer JdtJol lua require('jdtls').jol()
	command! -buffer JdtBytecode lua require('jdtls').javap()
	command! -buffer JdtJshell lua require('jdtls').jshell()
	  ]],
	false
)
