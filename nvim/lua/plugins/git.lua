return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitFilter", "LazyGitFilterCurrentFile" },
  },
  {
    "linrongbin16/gitlinker.nvim",
    opts = {},
  },
  {
    "sindrets/diffview.nvim",
    opts = { use_icons = false },
  },
}
