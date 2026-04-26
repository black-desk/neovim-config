-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

-- https://github.com/black-desk/rsime

-- Description:
-- RIME in neovim, build with rust.

return {
  "black-desk/rsime",
  cond = function()
    return vim.fn.executable("rsime") == 1
  end,
  keys = {
    {
      "<M-i>",
      function()
        require("rsime").toggle()
        if vim.fn.mode() == "n" then
          vim.cmd("startinsert")
        end
      end,
      mode = { "n", "i" },
      desc = "Toggle rsime",
    },
  },
  opts = {},
}
