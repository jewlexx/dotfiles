command! -nargs=0 EditConfig :edit ~/.dotfiles/configs/rc.vim
command! -nargs=0 Reload :source ~/.dotfiles/configs/rc.vim

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'wbthomason/packer.nvim'

"" Completions
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow'
Plug 'junegunn/vim-github-dashboard'

"" Rust Plugins
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'

"" GoLang Plugins
Plug 'fatih/vim-go'

"" UI Plugins
Plug 'RishabhRD/popfix'
Plug 'hood/popui.nvim'

call plug#end()

nnoremap ,d :lua require'popui.diagnostics-navigator'()<CR>

lua << EOF
vim.ui.select = require("popui.ui-overrider")
vim.ui.input = require("popui.input-overrider")

EOF

set completeopt=menu,menuone,noselect

lua <<EOF
require("packer").startup({{
	{ "wbthomason/packer.nvim" },

	{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "hrsh7th/cmp-path" },
	{ "neovim/nvim-lspconfig" },
	{ "L3MON4D3/LuaSnip" },
		{ "saadparwaiz1/cmp_luasnip" },
	{ "simrat39/rust-tools.nvim" },
}, config = {}})

-- Setup cmp
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({ -- Preset: ^n, ^p, ^y, ^e, you know the drill..
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "path" },
	}, {
		{ name = "buffer", keyword_length = 3 },
	}),
})

-- Setup buffer-local keymaps / options for LSP buffers
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_attach = function(client, buf)
	-- Example maps, set your own with vim.api.nvim_buf_set_keymap(buf, "n", <lhs>, <rhs>, { desc = <desc> })
	-- or a plugin like which-key.nvim
	-- <lhs>        <rhs>                        <desc>
	-- "K"          vim.lsp.buf.hover            "Hover Info"
	-- "<leader>qf" vim.diagnostic.setqflist     "Quickfix Diagnostics"
	-- "[d"         vim.diagnostic.goto_prev     "Previous Diagnostic"
	-- "]d"         vim.diagnostic.goto_next     "Next Diagnostic"
	-- "<leader>e"  vim.diagnostic.open_float    "Explain Diagnostic"
	-- "<leader>ca" vim.lsp.buf.code_action      "Code Action"
	-- "<leader>cr" vim.lsp.buf.rename           "Rename Symbol"
	-- "<leader>fs" vim.lsp.buf.document_symbol  "Document Symbols"
	-- "<leader>fS" vim.lsp.buf.workspace_symbol "Workspace Symbols"
	-- "<leader>gq" vim.lsp.buf.formatting_sync  "Format File"

	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
end

-- Setup rust_analyzer via rust-tools.nvim
require("rust-tools").setup({
	server = {
		capabilities = capabilities,
		on_attach = lsp_attach,
	}
})

-- Keymaps for Luasnip
local ls = require("luasnip")
vim.keymap.set({ "i", "s" }, "<C-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
EOF
