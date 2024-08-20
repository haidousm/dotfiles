return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap = require("dap")
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
		dap.listeners.after["event_terminated"]["nvim-metals"] = function()
			dap.repl.open()
		end
	end,
}
