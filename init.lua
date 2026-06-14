-- ============================================================
--  init.lua — Neovim LENGKAP untuk Termux Android (versi Sauna)
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = "a"                 -- tap & scroll layar sentuh
opt.clipboard = "unnamedplus"   -- nyambung clipboard Android
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.breakindent = true
opt.wrap = true                 -- teks panjang turun ke bawah (gak perlu geser ke kanan)
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 15              -- sisain 15 baris di bawah biar gak mentok keyboard
opt.sidescrolloff = 8
opt.splitright = true
opt.splitbelow = true
opt.undofile = true
opt.swapfile = false
opt.updatetime = 200
opt.timeoutlen = 350
opt.completeopt = "menu,menuone,noselect"
opt.laststatus = 3
opt.showmode = false
opt.fillchars = { eob = " " }
opt.confirm = true
opt.showtabline = 2             -- paksa bar tab selalu muncul

local map = vim.keymap.set
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Simpan" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Keluar" })
map("n", "<leader>x", "<cmd>x<cr>", { desc = "Simpan & keluar" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>")

map("n", "<leader>h", "<C-w>h", { desc = "Window kiri" })
map("n", "<leader>j", "<C-w>j", { desc = "Window bawah" })
map("n", "<leader>k", "<C-w>k", { desc = "Window atas" })
map("n", "<leader>l", "<C-w>l", { desc = "Window kanan" })
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertikal" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })

map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Buffer berikut" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Buffer sebelumnya" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Tutup buffer" })

map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Geser bawah" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Geser atas" })
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

function _G.sauna_toggle_tree()
  pcall(function() require("lazy").load({ plugins = { "neo-tree.nvim" } }) end)
  vim.cmd("Neotree toggle")
end
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufEnter", "WinEnter", "FileType" }, {
  group = vim.api.nvim_create_augroup("SaunaWinbar", { clear = true }),
  callback = function()
    local skip = { "neo-tree", "dashboard", "TelescopePrompt", "lazy", "mason", "notify", "toggleterm", "help", "qf" }
    if vim.bo.buftype ~= "" or vim.tbl_contains(skip, vim.bo.filetype) then
      vim.wo.winbar = nil
    else
      vim.wo.winbar = "%@v:lua.sauna_toggle_tree@  ☰  %X%f"
    end
  end,
})

require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          telescope = true, neotree = true, cmp = true,
          gitsigns = true, treesitter = true, which_key = true,
          notify = true, indent_blankline = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      return {
        theme = "doom",
        config = {
          header = {
            "", "",
            "   ███████╗ █████╗ ██╗   ██╗███╗   ██╗ █████╗ ",
            "   ██╔════╝██╔══██╗██║   ██║████╗  ██║██╔══██╗",
            "   ███████╗███████║██║   ██║██╔██╗ ██║███████║",
            "   ╚════██║██╔══██║██║   ██║██║╚██╗██║██╔══██║",
            "   ███████║██║  ██║╚██████╔╝██║ ╚████║██║  ██║",
            "   ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝",
            "            n e o v i m   ·   t e r m u x", "", "",
          },
          center = {
            { icon = "  ", desc = "Cari file        ", key = "f", action = "Telescope find_files" },
            { icon = "  ", desc = "Cari teks        ", key = "g", action = "Telescope live_grep" },
            { icon = "  ", desc = "File baru        ", key = "n", action = "enew" },
            { icon = "  ", desc = "File explorer    ", key = "e", action = "Neotree toggle" },
            { icon = "  ", desc = "File terakhir    ", key = "r", action = "Telescope oldfiles" },
            { icon = "  ", desc = "Update plugin    ", key = "u", action = "Lazy update" },
            { icon = "  ", desc = "Keluar           ", key = "q", action = "qa" },
          },
          footer = { "", "Tahan <Spasi> buat lihat semua perintah" },
        },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",
        component_separators = "|",
        disabled_filetypes = { statusline = { "dashboard", "neo-tree" } },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = { options = {
      mode = "buffers",
      diagnostics = "nvim_lsp",
      separator_style = "thin",
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = false,
      left_mouse_command = "buffer %d",      -- tap tab = pindah file
      middle_mouse_command = "bdelete! %d",  -- klik tengah = tutup
    } },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    keys = { { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "File explorer" } },
    cmd = { "Neotree" },
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
        filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false },
      },
      window = {
        width = 28,
        mappings = {
          ["<2-LeftMouse>"] = "open",
          ["<LeftRelease>"] = "open",
        },
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Cari file" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Cari teks" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffer" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "File terakhir" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Bantuan" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymap" },
      { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Cari di file ini" },
    },
    opts = { defaults = { layout_config = { prompt_position = "top" }, sorting_strategy = "ascending" } },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "python", "javascript", "typescript", "json", "html", "css", "markdown", "markdown_inline" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", event = "BufReadPost", opts = { scope = { enabled = true } } },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = { add = { text = "▎" }, change = { text = "▎" }, delete = { text = "" } },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set
        map("n", "<leader>gb", gs.blame_line, { buffer = bufnr, desc = "Git blame baris" })
        map("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview perubahan" })
        map("n", "]c", gs.next_hunk, { buffer = bufnr, desc = "Perubahan berikut" })
        map("n", "[c", gs.prev_hunk, { buffer = bufnr, desc = "Perubahan sebelum" })
      end,
    },
  },

  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]], { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal" } },
    opts = { open_mapping = [[<C-\>]], direction = "float", float_opts = { border = "curved" } },
  },

  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({ background_colour = "#000000", render = "minimal", timeout = 2000 })
      vim.notify = require("notify")
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>f", group = "Cari" },
        { "<leader>g", group = "Git" },
        { "<leader>s", group = "Split" },
        { "<leader>t", group = "Terminal" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Code" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = { { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format file" } },
    opts = {
      format_on_save = { timeout_ms = 800, lsp_fallback = true },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" }, { name = "luasnip" },
          { name = "buffer" }, { name = "path" },
        },
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()

      local map = vim.keymap.set
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local b = { buffer = ev.buf }
          map("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", b, { desc = "Ke definisi" }))
          map("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", b, { desc = "Referensi" }))
          map("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", b, { desc = "Dokumentasi" }))
          map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", b, { desc = "Rename" }))
          map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", b, { desc = "Code action" }))
          map("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", b, { desc = "Lihat error" }))
        end,
      })

    end,
  },

}, {
  ui = { border = "rounded" },
  install = { colorscheme = { "catppuccin" } },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "zipPlugin", "netrwPlugin", "matchit" } },
  },
})
