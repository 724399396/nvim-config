return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "java" })
			end
		end,
	},

	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "google-java-format" })
		end,
	},

	{
		"stevearc/conform.nvim",
		opts = function(_, opts)
			if type(opts.formatters_by_ft) == "table" then
				opts.formatters_by_ft["java"] = { "google-java-format" }
			end
		end,
	},

	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jdtls = {},
			},
			setup = {
				["jdtls"] = function(_)
					return true
				end,
			},
		},
	},

	{
		"jay-babu/mason-nvim-dap.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, { "javadbg", "javatest" })
		end,
	},

	{
		"mfussenegger/nvim-jdtls",
		dependencies = "nvim-lspconfig",
		ft = { "java" },
		config = function()
			local function attach_jdtls()
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
					vim.fn.glob(
						DEBUGGER_LOCATION
							.. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
					),
				}
				vim.list_extend(
					bundles,
					vim.split(vim.fn.glob(DEBUGGER_LOCATION .. "/java-test/extension/server/*.jar"), "\n")
				)

				local config = {
					cmd = {
						"java",
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-Xmx4g",
						"-XX:+UseParallelGC",
						"-XX:GCTimeRatio=4",
						"-XX:AdaptiveSizePolicyWeight=90",
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
								filteredTypes = {
									"com.sun.*",
									"io.micrometer.shaded.*",
									"java.awt.*",
									"jdk.*",
									"sun.*",
								},
							},
							sources = {
								organizeImports = {
									starThreshold = 9999,
									staticStarThreshold = 9999,
								},
							},
							codeGeneration = {},
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
						extendedClientCapabilities = extendedClientCapabilities,
					},
					language = {
						status = function() end,
					},
				}
				-- This starts a new client & server,
				-- or attaches to an existing client & server depending on the `root_dir`.
				jdtls.start_or_attach(config)
			end
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "java" },
				callback = attach_jdtls,
			})
			attach_jdtls()
		end,
	},
}
