return {
  'jakobkhansen/journal.nvim',
  opts = {
    filetype = 'md', -- Filetype to use for new journal entries
    root = '~/journal', -- Root directory for journal entries
    date_format = '%d/%m/%Y', -- Date format for `:Journal <date-modifier>`
    autocomplete_date_modifier = 'end', -- "always"|"never"|"end". Enable date modifier autocompletion

    -- Configuration for journal entries
    journal = {
      -- Default configuration for `:Journal <date-modifier>`
      format = '%Y/%m-%B/daily/%Y-%m-%d',
      template = '# %A - %B %d %Y\n',
      frequency = { day = 1 },
    },
  },
}
