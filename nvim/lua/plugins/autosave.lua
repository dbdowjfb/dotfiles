return {
  "pocco81/auto-save.nvim",
  init = function()
    require"auto-save".setup({
      execution_message = {
        message = ""
      }
    })
    end 
}




