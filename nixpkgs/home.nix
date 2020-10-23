{ config, pkgs, ... }:

{


  nixpkgs.config = {
    allowUnfree = true;
  }; # software doesn't grow on tree


  home.sessionVariables = {
    # use emacs as my default editor
    EDITOR = "${config.programs.neovim.package}/bin/nvim";
    # read man pages in neovim (hot!)
    MANPAGER = "${config.programs.neovim.package}/bin/nvim -c 'set ft=man' -";
    WEECHAT_HOME = ''${config.xdg.configHome}/weechat'';
  };

  home.packages = with pkgs; [

    ###############
    # build tools #
    ###############
    gcc
    poetry
    python3
    rustup
    nodejs
    racket


    #############
    # cli tools #
    #############

    stow # symlink manager
    gitAndTools.git-hub # github cli. 
    gitAndTools.git-ignore # auto fetch language template
    exa # improved ls in rust
    ripgrep # grep with batteries
    prettyping # prettier ping
    age # pgp, but good
    weechat # irc client
    trash-cli # for the rm-happy among us; used by nnn
    nnn # file manager
    unzip # unzipping
    zip
    aspell
    aspellDicts.en # cli spellcheck; used by emacs
    gtypist
    rclone
    rsync
    magic-wormhole
    # ssb-patchwork # FIXME
    bc # cli calc
    figlet
    neofetch
    file # need this for the nnn plugin nuke
    fd # supercharged find
    cmus
    asciinema
    graphviz
    imagemagick
  ];

  ###########
  # editors #
  ###########

  programs.neovim = ( import programs/neovim/default.nix { inherit pkgs; });	

  programs.emacs.enable = true;
	programs.emacs = {
	  package = pkgs.emacs26-nox;
	};



  #################
  # shell and cli #
  #################

  programs.bat.enable = true; # a purrfect replacement for cat

  programs.direnv.enable = true;

  # junegunn's fuzzy finder
  programs.fzf = {
    enable = true;
    defaultCommand = "${pkgs.fd}/bin/fd --type f --hidden --follow --exclude .git --exclude .cache/";
    fileWidgetCommand = "${config.programs.fzf.defaultCommand}";
    defaultOptions = [
      "--color=bg+:#44475a,bg:#282a36,spinner:#50fa7b,hl:#44475a"
      "--color=fg:#f8f8f2,header:#ff5555,info:#ff5555,pointer:#50fa7b"
      "--color=marker:#ff5555,fg+:#f8f8f2,prompt:#50fa7b,hl+:#44475a"
    ];
  };

  programs.git = {
    enable = true;
    userName = "Andrew T. Curtis";
    userEmail = "andrew.curtis@gmail.com";
  };

  programs.htop.enable = true; # check whether your laptop is melting

  # a spicy hot file manager
  programs.broot.enable = true;

  # ze best shell
  programs.zsh = ( import programs/zsh/default.nix { inherit pkgs; });

  programs.starship.enable = true;

  programs.starship.settings = {
    character.symbol = "λ";
    add_newline = "false";
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "wandr";
  home.homeDirectory = "/home/wandr";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}
