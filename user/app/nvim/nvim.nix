{ pkgs, ... }:

{
  programs.neovim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  vimdiffAlias = true;
  plugins = with pkgs.vimPlugins; [
    nvim-lspconfig
    nvim-treesitter.withAllGrammars
    plenary-nvim
    gruvbox-material
    mini-nvim
    presence-nvim
  ];
  extraConfig = ''
    lua << EOF
    -- Set up presence-nvim
    require("presence"):setup({
      auto_update         = true,
      neovim_image_text   = "The One True Text Editor",
      main_image          = "neovim",
      client_id           = "793271441293967371",
      log_level           = nil,
      debounce_timeout    = 10,
      enable_line_number  = false,
      blacklist           = {},
      buttons             = true,
      file_assets         = {},
      show_time           = true,
      editing_text        = "Editing %s",
      file_explorer_text  = "Browsing %s",
      git_commit_text     = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text        = "Reading %s",
      workspace_text      = "Working on %s",
      line_number_text    = "Line %s out of %s",
    })

    -- Set up transparency
    vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
    vim.cmd('hi NormalNC guibg=NONE ctermbg=NONE')
    vim.cmd('hi EndOfBuffer guibg=NONE ctermbg=NONE')
    vim.cmd('hi SignColumn guibg=NONE ctermbg=NONE')

    -- Optional: Adjust gruvbox-material settings for better transparency
    vim.g.gruvbox_material_transparent_background = 1
    vim.g.gruvbox_material_background = 'medium'
    vim.cmd('colorscheme gruvbox-material')
    EOF
  '';
};


}