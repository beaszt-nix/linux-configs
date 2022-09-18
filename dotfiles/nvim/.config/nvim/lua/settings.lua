------------------------------------------------------------------------------------------------------------------------
-- Editor Settings 
------------------------------------------------------------------------------------------------------------------------

local o = vim.o -- Global Options
local wo = vim.wo -- Window Local Options
local bo = vim.bo -- Buffer Local Options

o.bg = light
o.mouse = a
o.hls = false

-- Tab Options
bo.tabstop = 4
bo.softtabstop = 0
bo.expandtab = true
bo.shiftwidth = 4
o.smarttab = true


-- Relative Numbering
wo.rnu = true

-- Commandline Autocompletion
o.wildmenu = true

-- Split window to right by default
o.splitright = true

-- Disabling backup files (some LSP complains)
o.backup = false
o.writebackup = false

-- Give more space for displaying messages
o.cmdheight = 2

-- Updatetime 
o.updatetime = 300

-- Colors
vim.g.colors_name = 'gloombuddy'

-- Leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

------------------------------------------------------------------------------------------------------------------------
-- TreeSitter
------------------------------------------------------------------------------------------------------------------------

local configs = require'nvim-treesitter.configs'
configs.setup { 
    highlight = { 
        enable = true,
    }
}


------------------------------------------------------------------------------------------------------------------------
-- LSP 
------------------------------------------------------------------------------------------------------------------------
-- Mason for LspInstall

local lspServerList = {
	"hls",
	"tsserver",
	"sumneko_lua",
	"jsonls",
	"marksman",
	"bashls",
	"dockerls",
	"yamlls",
	"cssls"
}

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = lspServerList,
	-- Can change this to { exclude: {"list", "of", "servers"} } to remove some servers from autoinstall
	automatic_installation = true

})


local lspconfig = require('lspconfig')
local completion = require('completion')

local function custom_on_attach(client)
	print('Attaching to' .. client.name)
	completion.on_attach(client)
end

local default_config = {
    on_attach = custom_on_attach,
}

-- Diagnostics Defaults Override
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        virtual_text = false,
        signs = true,
        update_in_insert = true
    }
)

for _,lspserver in ipairs(lspServerList) do
	lspconfig[lspserver].setup(default_config)
end

-- Telescope File Browser
local telescope = require('telescope')
telescope.setup()
telescope.load_extension "file_browser"
