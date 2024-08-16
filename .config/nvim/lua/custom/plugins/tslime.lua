return {
	"jgdavey/tslime.vim",
	config = function()
		vim.g.tslime_always_current_session = 1
		vim.g.tslime_always_current_window = 1
		vim.keymap.set("v", "<leader>t", "<Plug>SendSelectionToTmux", { desc = "Send selection to [T]mux" })
		vim.keymap.set("n", "<leader>t", "<Plug>NormalModeSendToTmux", { desc = "Send selection to [T]mux" })
	end,
}
