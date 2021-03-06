{ config, pkgs, ... }:

let
  base_packages = with pkgs; [
    brave
    xorg.xmodmap
    xorg.xev
#   google-chrome
    gparted
    imagemagick
    inkscape
    unzip
    zola
    libreoffice
  ];

  encryption_packages = with pkgs; [
    keybase-gui
    pass
  ];

  emulator_packages = with pkgs; [
    dosbox
    uae
  ];

  chat_packages = with pkgs; [
    slack
    teams
  ];

  audio_video_packages = with pkgs; [
    pulsemixer
    zoom-us
    vlc
  ];

  container_packages = with pkgs; [
    squashfsTools
  ];

  rust_packages = with pkgs; [
    cargo
    rustc
    rustfmt
    rustPackages.clippy
  ];

  build_packages = with pkgs; [
    binutils
    gfortran  # provides also gcc
    gdb
    gnumake
    cmake
    automake
    autoconf
    libtool
    valgrind
    python39
  ];

  node_packages = with pkgs; [
    nodejs
    nodePackages.npm
    nodePackages.yarn
    nodePackages.webpack
  ];

  cl_packages = with pkgs; [
    pandoc
    exa
    ripgrep
    fd
    bat
    sshuttle
    htop
    tldr
    tree
    neofetch
  ];

in {
  programs.home-manager.enable = true;
  home.username = "bast";
  home.homeDirectory = "/home/bast";
  home.stateVersion = "21.05";

  home.packages =
    base_packages ++
    encryption_packages ++
    emulator_packages ++
    chat_packages ++
    audio_video_packages ++
    container_packages ++
    rust_packages ++
    node_packages ++
    cl_packages ++
    build_packages;

  programs.alacritty.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.fish = {
    enable = true;
    promptInit = ''
      set -x fish_prompt_pwd_dir_length 80
    '';
    shellAliases = {
      vi = "vim";
      ls = "exa";
      ll = "ls -l --sort=modified --reverse";
      cat = "bat --style=plain --paging=never";
    };
  };

  xdg.configFile = {
    fish = {
      source = ./fish;
      target = "fish";
      recursive = true;
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./vimrc;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-fish
      vim-better-whitespace
      vim-commentary
      vim-markdown
      vim-sensible
    ];
  };

  # using custom one because of confusing default matching parentheses setting
  # https://github.com/tomasr/molokai/pull/44
  home.file.".vim/colors/molokai.vim".source = ./vim/colors/molokai.vim;

  home.file.".gitconfig".source = ./gitconfig;
  home.file.".alacritty.yml".source = ./alacritty.yml;

  xsession = {
    enable = true;
    # up-key missing, use pgup
#   initExtra = ''
#     xmodmap -e "keycode 112 = Up"
#   '';

    windowManager.i3 = {
      enable = true;
      config = {
        window.titlebar = false;
        terminal = "alacritty";
        modifier = "Mod4";  # this is the "windows" key
        defaultWorkspace = "workspace number 1";
      };
    };
  };
}
