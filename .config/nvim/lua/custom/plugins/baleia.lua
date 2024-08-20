return {
	"m00qek/baleia.nvim",
	version = "*",
	config = function()
		vim.g.baleia = require("baleia").setup({})
		vim.api.nvim_create_user_command("BaleiaColorize", function()
			vim.g.baleia.once(vim.api.nvim_get_current_buf())
		end, { bang = true })
		vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
		vim.api.nvim_create_autocmd("FileType", {
			desc = "Force colorize on dap-repl",
			pattern = "dap-repl",
			group = vim.api.nvim_create_augroup("auto_colorize", { clear = true }),
			callback = function()
				vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
			end,
		})
	end,
}
