-- Functional wrapper for mapping custom keybindings
-- local function map(mode, lhs, rhs, opts)
--     if type(mode) == 'table' then
--         for i = 1, #mode do
--             map(mode[i], lhs, rhs, opts)
--         end
--         return
--     end
--     local options = { noremap = true }
--     if opts then
--         options = vim.tbl_extend("force", options, opts)
--     end
--     vim.api.nvim_set_keymap(mode, lhs, rhs, options)
-- end

local function is_quickfix_open()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'buftype') == 'quickfix' then
      return true
    end
  end
  return false
end

local function get_current_quickfix_entry()
  local qflist = vim.fn.getqflist({ idx = 0 })
  local current_idx = qflist.idx
  local entry = vim.fn.getqflist({ id = qflist.id, items = 0 }).items[current_idx]
  return entry
end

vim.keymap.set({"v", "n"}, "_", "+", { noremap = true })
vim.keymap.set({"v", "n"}, "gh", "(v:count == 0 || v:count == 1 ? '^^' : '^^' . (v:count - 1) . 'l')", { silent = true, expr = true })
vim.keymap.set({"v", "n"}, "gl", "(v:count == 0 || v:count == 1 ? '^$' : '^$' . (v:count - 1) . 'h')", { silent = true, expr = true })
vim.keymap.set({"v", "n"}, "gm", "gM", { noremap = true })
vim.keymap.set({"v", "n"}, "gM", "gm", { noremap = true })
vim.keymap.set({"v", "n", "i"}, "<F4>", "<cmd>wa<CR>")
vim.keymap.set({"v", "n", "i"}, "<F6>", function ()
    if is_quickfix_open() then
        if get_current_quickfix_entry() then
            return "<cmd>cn<CR>"
        else
            return "<cmd>cc<CR>"
        end
    else
        return "<cmd>copen<CR>"
    end
end, { noremap = true, expr = true })
vim.keymap.set({"v", "n", "i"}, "<F18>", function ()
    if is_quickfix_open() then
        if get_current_quickfix_entry() then
            return "<cmd>cp<CR>"
        else
            return "<cmd>cc<CR>"
        end
    else
        return "<cmd>copen<CR>"
    end
end, { noremap = true, expr = true })
vim.keymap.set({"v", "n", "i", "t"}, "<F7>", "<cmd>NvimTreeFindFileToggle<CR>", { silent = true })
vim.keymap.set({"v", "n", "i", "t"}, "<F9>", "<cmd>Trouble diagnostics toggle focus=false filter.buf=0<CR>", { silent = true })
vim.keymap.set({"v", "n", "i", "t"}, "<F21>", "<cmd>Trouble diagnostics toggle focus=false<CR>", { silent = true })
if pcall(require, "cmake-tools") then
    vim.keymap.set({"v", "n", "i", "t"}, "<F5>", "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeRun')|else|call execute('TermExec cmd=./run.sh')|endif<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i", "t"}, "<F17>", "<cmd>wa<CR><cmd>if luaeval('require\"cmake-tools\".is_cmake_project()')|call execute('CMakeStopRunner')|call execute('CMakeStopExecutor')|else|call execute('TermExec cmd=\\<C-c>')|endif<CR>", { silent = true })
else
    vim.keymap.set({"v", "n", "i", "t"}, "<F5>", "<cmd>wa<CR><cmd>call execute('TermExec cmd=./run.sh')<CR>", { silent = true })
    vim.keymap.set({"v", "n", "i", "t"}, "<F17>", "<cmd>wa<CR><cmd>call execute('TermExec cmd=\\<C-c>')<CR>", { silent = true })
end
vim.keymap.set({"v", "n", "i", "t"}, "<F10>", "<cmd>Neogit<CR><cmd>set foldtext='+'<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i", "t"}, "<F12>", "<cmd>NoiceAll<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i", "t"}, "<F10>", "<cmd>DapToggleBreakpoint<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i", "t"}, "<F22>", "<cmd>DapToggleRepl<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i", "t"}, "<F12>", "<cmd>DapStepOver<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i", "t"}, "<F24>", "<cmd>DapStepInto<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i", "t"}, "<C-F12>", "<cmd>DapStepOut<CR>", { silent = true })
-- if found_cmake then
--     vim.keymap.set({"v", "n", "i", "t"}, "<F9>", "<cmd>if luaeval('require\"cmake-tools\".is_cmake_project() and require\"dap\".session()==nil')|call execute('CMakeDebug')|else|call execute('DapContinue')|endif<CR>", { silent = true })
--     vim.keymap.set({"v", "n", "i", "t"}, "<F21>", "<cmd>if luaeval('require\"cmake-tools\".is_cmake_project() and require\"dap\".session()==nil')|call execute('CMakeStop')|else|call execute('DapTerminate')|endif<CR>", { silent = true })
-- else
--     vim.keymap.set({"v", "n", "i", "t"}, "<F9>", "<cmd>DapContinue<CR>", { silent = true })
--     vim.keymap.set({"v", "n", "i", "t"}, "<F21>", "<cmd>DapTerminate<CR>", { silent = true })
-- end
vim.keymap.set({'v', 'n', 'i', 't'}, '<Ins>', [[<Cmd>ZenMode<CR>]])
-- vim.keymap.set({"v", "n"}, "<CR>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("i", "jk", "<Esc>", { silent = true })
vim.keymap.set("i", "kj", "<Esc>", { silent = true })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { silent = true })
vim.keymap.set("t", "kj", "<C-\\><C-n>", { silent = true })
vim.keymap.set("v", "q", "<Esc>", { silent = true })
vim.keymap.set("n", "Q", "q", { silent = true, noremap = true })
vim.keymap.set({"v", "n"}, "g=", "<cmd>Neoformat<CR>", { silent = true })
-- vim.keymap.set({"v", "n", "i"}, "<F10>", "<cmd>Neoformat<CR>", { silent = true })
-- vim.keymap.set("n", "Q", "<cmd>wa<CR><cmd>qa!<CR>", { silent = true })

-- vim.cmd [[
-- command! -nargs=0 A :ClangdSwitchSourceHeader
-- command! -nargs=? F :Neoformat <f-args>
-- ]]

-- vim.api.nvim_create_autocmd({"VimEnter"}, {
--     -- disable_n_more_files_to_edit
--     callback = function (data)
--         local no_name = data.file == "" and vim.bo[data.buf].buftype == ""
--         if not no_name then
--             -- vim.cmd [[ args % ]]
--         end
--     end,
-- })

vim.api.nvim_create_user_command("Q", function ()
    vim.cmd [[ wall | if &buftype == 'quickfix' | cclose | elseif &buftype == 'prompt' | quit! | else | quit | endif ]]
end, {desc = 'Quit current window'})
vim.keymap.set("n", "q", "<cmd>Q<CR>", { silent = true })

vim.keymap.set({'v', 'n', 'i', 't'}, '<C-h>', [[<Cmd>wincmd h<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-j>', [[<Cmd>wincmd j<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-k>', [[<Cmd>wincmd k<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-l>', [[<Cmd>wincmd l<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-h>', [[<Cmd>wincmd H<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-j>', [[<Cmd>wincmd J<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-k>', [[<Cmd>wincmd K<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-l>', [[<Cmd>wincmd L<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-w>', [[<Cmd>wincmd w<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-r>', [[<Cmd>wincmd r<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-x>', [[<Cmd>wincmd x<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-s>', [[<Cmd>wincmd s<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-v>', [[<Cmd>wincmd v<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-=>', [[<Cmd>wincmd +<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-->', [[<Cmd>wincmd -<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-,>', [[<Cmd>wincmd <Lt><CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-.>', [[<Cmd>wincmd ><CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<C-q>', [[<Cmd>wincmd q<CR>]])
vim.keymap.set({'v', 'n', 'i', 't'}, '<M-q>', [[<Cmd>wincmd q<CR>]])
vim.keymap.set('n', '<Esc>', [[<Cmd>nohls<CR><Esc>]], { noremap = true })
-- vim.keymap.set('t', '<C-\\>', [[<C-\><C-n>]], { noremap = true })
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
-- vim.keymap.set('t', [[<Esc>]], [[<Esc>]], { noremap = true })
-- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)

-- vim.keymap.set('i', '<M-]>', [[<Plug>(copilot-next)]])
-- vim.keymap.set('i', '<M-[>', [[<Plug>(copilot-previous)]])
-- vim.keymap.set('i', '<M-/>', [[<Plug>(copilot-suggest)]])

-- local _gpt_add_key_map_timer = vim.loop.new_timer()
-- _gpt_add_key_map_timer:start(100, 100, vim.schedule_wrap(function ()
--     if _gpt_add_key_map_timer and pcall(function () vim.cmd [[GPTSuggestedKeymaps]] end) then
--         _gpt_add_key_map_timer:stop()
--         _gpt_add_key_map_timer = nil
--     end
-- end))

-- vim.keymap.set('i', '<CR>', 'copilot#Accept("\\<CR>")', {
--     silent = true,
--     expr = true,
--     replace_keycodes = false,
-- })
-- vim.keymap.set('i', '<M-BS>', '<Plug>(copilot-dismiss)')
-- vim.keymap.set('i', '<M-\\>', '<Plug>(copilot-suggest)')
-- vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
-- vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
-- vim.keymap.set('i', '<M-CR>', '<Plug>(copilot-accept-word)')
-- vim.g.copilot_no_tab_map = true

-- fetch
-- vim.keymap.set('i', '<F23>', '<Esc>vH0o"+y:let b:_f23="v"<CR>gi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F23>', '<C-\\><C-n>H"+yL:let b:_f23="v"<CR>i', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F23>', 'mYH"+yL`Y:let b:_f23="V"<CR>', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F23>', 'mY"+y`Y:let b:_f23=getregtype("+")<CR>gv', { silent = true, nowait = true, noremap = true })
--
-- -- append
-- vim.keymap.set('i', '<F24>', '<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F24>', '<C-e><C-\\><C-n>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F24>', ':cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+p', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F24>', '<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+p', { silent = true, nowait = true, noremap = true })
--
-- -- prepend
-- vim.keymap.set('i', '<F47>', '<Esc>go:cal setreg("+",getreg("+"),"V")|let b:_f23=""<CR>"+Pgi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F47>', '<C-a><C-\\><C-n>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pi<C-e>', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F47>', 'mYgo:cal setreg("+",getreg("+"),"V")|let b:_f23=""<CR>"+P`Y', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F47>', 'mYo<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+P`Y', { silent = true, nowait = true, noremap = true })
--
-- -- overwrite
-- vim.keymap.set('i', '<F48>', '<Esc>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|if get(b:,"_f23","")!=""|cal execute("norm!gv")|en|let b:_f23=""<CR>"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F48>', '<C-u><C-\\><C-n>:cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+pi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F48>', ':cal setreg("+",getreg("+"),get(b:,"_f23","v"))|if get(b:,"_f23","")!=""|cal execute("norm!HVL")|en|let b:_f23=""<CR>"+pM', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F48>', ':cal setreg("+",getreg("+"),get(b:,"_f23","v"))|let b:_f23=""<CR>"+p', { silent = true, nowait = true, noremap = true })
--
-- -- insert
-- vim.keymap.set('i', '<F46>', '<Esc>"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('t', '<F46>', '<C-\\><C-n>"+pi', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('n', '<F46>', '"+pa', { silent = true, nowait = true, noremap = true })
-- vim.keymap.set('v', '<F46>', '<Esc>"+pa', { silent = true, nowait = true, noremap = true })

-- vim.cmd [[
-- iabbr `` ``!cursor!<CR>```<Esc>:call search('!cursor!', 'b')<CR>cf!
-- ]]

vim.keymap.set({'v', 'n'}, 'K', function ()
    vim.lsp.buf.hover()
end)

vim.keymap.set({'v', 'n'}, 'gK', function ()
    vim.lsp.buf.signature_help()
end)

vim.keymap.set({'v', 'n'}, 'gw', function ()
    vim.lsp.buf.code_action({
        -- context = {
        --     only = {
        --         "source",
        --     },
        --     diagnostics = {},
        -- },
        apply = true,
    })
end)
vim.keymap.set({'v', 'n'}, 'gn', function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
vim.keymap.set({'n'}, '<S-Tab>', '<C-o>')
vim.keymap.set({'i'}, '<C-Space>', '<Space>')

-- vim.cmd [[
-- autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
-- autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
-- autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
-- ]]

vim.cmd [[au! BufRead,BufNewFile *.cppm,*.ixx setfiletype cpp]]
vim.cmd [[au! BufRead,BufNewFile *.vert,*.frag,*.comp,*.geom,*.tess setfiletype glsl]]

vim.keymap.set({'v', 'n'}, 'gp', ':GPT<Space>')
vim.keymap.set({'v', 'n'}, 'gP', ':GPT!<Space>')
vim.keymap.set({'i'}, '<C-Space>', '<Cmd>GPT<CR>')
vim.keymap.set({'i', 'n'}, '<C-t>', '<Cmd>-8,+8GPT refactor this code<CR>')
vim.keymap.set({'v'}, '<C-t>', '<Cmd>GPT refactor this code<CR>')

return vim.keymap.set
