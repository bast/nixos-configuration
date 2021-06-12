{ config, pkgs, ... }:

let
  base_packages = with pkgs; [
    firefox
    xorg.xmodmap
    xorg.xev
#   google-chrome
    gparted
    gnupg
    keybase
    keybase-gui
    pass
    imagemagick
    inkscape
    meld
    git
  ];

  audio_video_packages = with pkgs; [
    pulsemixer
    zoom-us
    vlc
  ];

  container_packages = with pkgs; [
    singularity
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
    gcc
    gdb
    gnumake
    cmake
    automake
    autoconf
    libtool
    valgrind
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
    wget
    curl
  ];

in {
  programs.home-manager.enable = true;

  home.username = "bast";
  home.homeDirectory = "/home/bast";

  home.stateVersion = "21.05";

  home.packages =
    base_packages ++
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
    shellAliases = {
      vi = "vim";
      ls = "exa";
      ll = "ls -l --sort=modified --reverse";
      cat = "bat";
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

  home.file.".gitconfig".source = ./gitconfig;

  xsession = {
    enable = true;
    # up-key missing, use pgup
    initExtra = ''
      xmodmap -e "keycode 112 = Up"
    '';

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
