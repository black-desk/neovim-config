-- SPDX-FileCopyrightText: 2025 Chen Linxuan <me@black-desk.cn>
--
-- SPDX-License-Identifier: MIT

-- https://github.com/windwp/nvim-autopairs

-- Description:
-- Insert or delete brackets, parens, quotes in pair.

return {
        'windwp/nvim-autopairs',
        config = function ()
                require("nvim-autopairs").setup({});
        end
}
