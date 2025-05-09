return {
	"ldelossa/gh.nvim",
	dependencies = {
		{
			"ldelossa/litee.nvim",
			config = function()
				require("litee.lib").setup()
			end,
		},
	},
	config = function()
		require("litee.gh").setup()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		-- GitHub Commits
		map("n", "<leader>ghcc", "<cmd>GHCloseCommit<cr>", opts)
		map("n", "<leader>ghce", "<cmd>GHExpandCommit<cr>", opts)
		map("n", "<leader>ghco", "<cmd>GHOpenToCommit<cr>", opts)
		map("n", "<leader>ghcp", "<cmd>GHPopOutCommit<cr>", opts)
		map("n", "<leader>ghcz", "<cmd>GHCollapseCommit<cr>", opts)

		-- GitHub Issues
		map("n", "<leader>ghip", "<cmd>GHPreviewIssue<cr>", opts)

		-- GitHub Litee
		map("n", "<leader>ghlt", "<cmd>LTPanel<cr>", opts)

		-- GitHub Review
		map("n", "<leader>ghrb", "<cmd>GHStartReview<cr>", opts)
		map("n", "<leader>ghrc", "<cmd>GHCloseReview<cr>", opts)
		map("n", "<leader>ghrd", "<cmd>GHDeleteReview<cr>", opts)
		map("n", "<leader>ghre", "<cmd>GHExpandReview<cr>", opts)
		map("n", "<leader>ghrs", "<cmd>GHSubmitReview<cr>", opts)
		map("n", "<leader>ghrz", "<cmd>GHCollapseReview<cr>", opts)

		-- GitHub Pull Request
		map("n", "<leader>ghpc", "<cmd>GHClosePR<cr>", opts)
		map("n", "<leader>ghpd", "<cmd>GHPRDetails<cr>", opts)
		map("n", "<leader>ghpe", "<cmd>GHExpandPR<cr>", opts)
		map("n", "<leader>ghpo", "<cmd>GHOpenPR<cr>", opts)
		map("n", "<leader>ghpp", "<cmd>GHPopOutPR<cr>", opts)
		map("n", "<leader>ghpr", "<cmd>GHRefreshPR<cr>", opts)
		map("n", "<leader>ghpt", "<cmd>GHOpenToPR<cr>", opts)
		map("n", "<leader>ghpz", "<cmd>GHCollapsePR<cr>", opts)

		-- GitHub Threads
		map("n", "<leader>ghtc", "<cmd>GHCreateThread<cr>", opts)
		map("n", "<leader>ghtn", "<cmd>GHNextThread<cr>", opts)
		map("n", "<leader>ghtt", "<cmd>GHToggleThread<cr>", opts)
	end,
}
