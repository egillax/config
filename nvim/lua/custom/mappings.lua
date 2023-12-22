local M = {}

M.general = {
  n = {
    ["<C-h>"] = {"<cmd> TmuxNavigateLeft<CR>", "window left"},
    ["<C-l>"] = {"<cmd> TmuxNavigateRight<CR>", "window right"},
    ["<C-j>"] = {"<cmd> TmuxNavigateDown<CR>", "window down"},
    ["<C-k>"] = {"<cmd> TmuxNavigateUp<CR>", "window up"},
    ["<C-u>"] = {"<C-u>zz", "move up", noremap=true},
    ["<C-d>"] = {"<C-d>zz", "move down", noremap=true},
    ["n"] = {"nzzzv", "next search", noremap=true},
    ["N"] = {"Nzzzv", "previous search", noremap=true},
  }
}

M.crates = {
  n = {
    ["<leader>rcu"] = {
      function()
        require("crates").upgrade_all_crates()
      end,
      "update crates"
    }
  }
}


return M
