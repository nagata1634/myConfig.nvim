vim.opt.number = true
vim.opt.iskeyword = vim.opt.iskeyword
vim.opt.clipboard:append("unnamedplus")

-- clipboard for windows
vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
    },
    paste = {
        ["+"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
        ["*"] = "powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace(\"`r\", \"\"))",
    },
    cache_enabled = 0,
}
-- config the VScode 
-- change the cursor color 
if vim.env.VSCode ~= nil then
    vim.api.nvim_exec([[
        " THEME CHANGER
        function! SetCursorLineNrColorInsert(mode)
            " Insert mode: blue
i           if a:mode == "i"
                call VSCodeNotify('nvim-theme.insert')

            " Replace mode: red
            elseif a:mode == "r"
                call VSCodeNotify('nvim-theme.replace')
            endif
        endfunction

        augroup CursorLineNrColorSwap
            autocmd!
            autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
            autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
            autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
            autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
            autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
            autocmd ModeChanged [vV\x16]*:* call VSCodeNotify('nvim-theme.normal')
        augroup END
    ]], false)
else
	require("config.lazy")
end
