require('git-conflict').setup({
  default_mappings = false, -- disable buffer local mapping created by this plugin
  default_commands = true, -- disable commands created by this plugin
  disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
  highlights = { -- They must have background color, otherwise the default color will be used
		incoming = 'visual',
    current = 'visual',

  }
})
local augroup = vim.api.nvim_create_augroup('GitConflictAugroup', { clear = true })
        vim.api.nvim_create_autocmd('User', {
            group = augroup,
            pattern = 'GitConflictResolved',
            callback = function()
                local CURRENT_HL = 'GitConflictCurrent'
                local INCOMING_HL = 'GitConflictIncoming'
                local ANCESTOR_HL = 'GitConflictAncestor'
                local CURRENT_LABEL_HL = 'GitConflictCurrentLabel'
                local INCOMING_LABEL_HL = 'GitConflictIncomingLabel'
                local ANCESTOR_LABEL_HL = 'GitConflictAncestorLabel'
                local visual_hl = vim.api.nvim_get_hl_by_name('Visual', true)

                vim.api.nvim_set_hl(0, CURRENT_HL, { background = visual_hl.background, bold = true })
                vim.api.nvim_set_hl(0, INCOMING_HL, { background = visual_hl.background, bold = true })
                vim.api.nvim_set_hl(0, ANCESTOR_HL, { background = visual_hl.background, bold = true })
                vim.api.nvim_set_hl(0, CURRENT_LABEL_HL, { background = visual_hl.background })
                vim.api.nvim_set_hl(0, INCOMING_LABEL_HL, { background = visual_hl.background })
                vim.api.nvim_set_hl(0, ANCESTOR_LABEL_HL, { background = visual_hl.background })
            end,
        })
