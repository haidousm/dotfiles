return {
	-- NOTE: Yes, you can install new plugins here!
	"mfussenegger/nvim-dap",
	-- NOTE: And you can specify dependencies as well
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			handlers = {},
			ensure_installed = {
				"delve",
			},
		})

		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Breakpoint" })
		vim.keymap.set("n", "<leader>dr", function()
			dap.repl.toggle()
		end, { desc = "Debug: Toggle REPL" })

		-- Dap UI setup
		-- For more information, see |:help nvim-dap-ui|
		-- dapui.setup({
		-- 	-- Set icons to characters that are more likely to work in every terminal.
		-- 	--    Feel free to remove or use ones that you like more! :)
		-- 	--    Don't feel like these are good choices.
		-- 	icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
		-- 	controls = {
		-- 		icons = {
		-- 			pause = "⏸",
		-- 			play = "▶",
		-- 			step_into = "⏎",
		-- 			step_over = "⏭",
		-- 			step_out = "⏮",
		-- 			step_back = "b",
		-- 			run_last = "▶▶",
		-- 			terminate = "⏹",
		-- 			disconnect = "⏏",
		-- 		},
		-- 	},
		-- })
		--
		-- -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
		-- vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
		--
		-- dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		-- dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		-- dap.listeners.before.event_exited["dapui_config"] = dapui.close
		dap.listeners.after["event_terminated"]["nvim-metals"] = function()
			dap.repl.open()
		end
		-- Dap / Metals integration
		dap.configurations.scala = {
			{
				type = "scala",
				request = "launch",
				name = "RunOrTest",
				metals = {
					runType = "runOrTestFile",
				},
			},
			{
				type = "scala",
				request = "launch",
				name = "Test Target",
				metals = {
					runType = "testTarget",
				},
			},
		}
	end,
}
