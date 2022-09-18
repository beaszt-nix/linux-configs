
local utils = require('utils')

local map = vim.api.nvim_set_keymap


--------------------------------------------------------------------------------------------------------------------------------
-- Common Multi-Pane movement and resizing
--------------------------------------------------------------------------------------------------------------------------------

local supported_modes = {'i', 't', 'n'}

for _, mode in ipairs(supported_modes) do
    local prefix = utils.conditional((mode == 'n'), "<C-w>", "<C-\\><C-N><C-w>h")

    -- Movement
    map(mode, "<C-h>", prefix .. "h", {noremap = true})
    map(mode, "<C-j>", prefix .. "j", {noremap = true})
    map(mode, "<C-k>", prefix .. "k", {noremap = true})
    map(mode, "<C-l>", prefix .. "l", {noremap = true})
    
    -- Resizing and shifting
    map(mode, "<C-R><", prefix .. "<", {noremap = true})
    map(mode, "<C-R>>", prefix .. ">", {noremap = true})
    map(mode, "<C-R>+", prefix .. "+", {noremap = true})
    map(mode, "<C-R>-", prefix .. "-", {noremap = true})
end


--------------------------------------------------------------------------------------------------------------------------------
-- LSP Bindings
--------------------------------------------------------------------------------------------------------------------------------

map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', {noremap = true})
map('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>', {noremap = true})
map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>', {noremap = true})
map('n', 'gw', ':lua vim.lsp.buf.document_symbol()<CR>', {noremap = true})
map('n', 'gW', ':lua vim.lsp.buf.workspace_symbol()<CR>', {noremap = true})
map('n', 'gr', ':lua vim.lsp.buf.references()<CR>', {noremap = true})
map('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>', {noremap = true})
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>', {noremap = true})
map('n', '<c-k>', ':lua vim.lsp.buf.signature_help()<CR>', {noremap = true})
map('n', '<leader>af', ':lua vim.lsp.buf.code_action()<CR>', {noremap = true})
map('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', {noremap = true})


--------------------------------------------------------------------------------------------------------------------------------
-- Fuzzy Finding Plugins
--------------------------------------------------------------------------------------------------------------------------------
map('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>', {noremap = true})
map('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>', {noremap = true})
map('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>', {noremap = true})
map('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>', {noremap = true})
map('n', '<leader>ff', ':Telescope file_browser<CR>', {noremap = true})
