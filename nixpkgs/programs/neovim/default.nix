{ pkgs, ... }:

let
  plugins = pkgs.vimPlugins // pkgs.callPackage ./custom-plugins.nix {};
in {
  enable = true;
  viAlias = true;
  vimAlias = true;
  configure = {
    customRC = builtins.readFile ./init.vim;
    plug.plugins = with plugins; [
      # theme
      nnn
      vim-sensible # no need to configure this
      vim-easy-align
      vim-slash
      vim-devicons
      vim-startify
      vim-nix
      vim-toml
      ultisnips
      vim-snippets
      vim-fugitive
      vim-surround
      nerdtree
      vim-commentary
      goyo
      fzfWrapper
      fzf-vim
      coc-nvim
      vimtex
      coc-vimtex
      direnv-vim
      gruvbox
      vim-pencil # I still need to incorporate this into my config
    ];
  };
}
