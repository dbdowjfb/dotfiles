vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
    callback = function()
        function _G.MyStatusLine()
            local rest = " %m %r %w%=%y %l:%c "
            if vim.fn.expand('%:~:.') == '' or vim.bo.buftype ~= '' then
                return '%t' .. rest
            end
                return vim.fn.expand('%:~:.') .. rest
        end
        vim.opt.statusline = '%!v:lua.MyStatusLine()'
    end,
})
