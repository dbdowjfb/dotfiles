return {
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/syncthing/DOC/**/*',
      org_default_notes_file = '~/syncthing/DOC/todo.org',
      org_capture_templates = {
    --     { t = { description = 'Task', template = '* TODO %?\n  %u' } },
          n = { description = 'Note', template = '%T \n %?', target = '~/syncthing/DOC/notes.org'}
    },
    mappings = {
      org_return_uses_meta_return = true
    }
  })
    
    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
}
