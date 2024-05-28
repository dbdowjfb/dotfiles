function get_visual_selection()
    local mode = vim.fn.mode()
    if mode ~= 'v' and mode ~= 'V' and mode ~= '' then
        return nil
    end

    -- Save the current register value
    local reg_save = vim.fn.getreg('v')
    local reg_type_save = vim.fn.getregtype('v')

    -- Select the text and save it to the register
    vim.cmd('silent! normal! "vy')

    -- Get the content of the register
    local selection = vim.fn.getreg('v')

    -- Restore the original register value
    vim.fn.setreg('v', reg_save, reg_type_save)

    return selection
end

function send_to_shell(cmd)
    local selection = get_visual_selection()
    if not selection then
        print("No visual selection")
        return
    end

    -- You can change this to whatever shell command you need
    local shell_command = cmd .. " " .. vim.fn.shellescape(selection)

    -- Execute the shell command
    local result = vim.fn.system(shell_command)

    -- Print the result (optional, you can handle the result differently)
    print(result)
end

-- Keybinding in visual mode
vim.api.nvim_set_keymap('v', '<leader>s', [[<cmd>lua send_to_shell('toot post')<CR>]], { noremap = true, silent = true })

