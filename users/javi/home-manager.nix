{ config, lib, pkgs, ... }:
let sources = import ../../nix/sources.nix; in {
  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    pkgs.fd
    pkgs.fzf
    pkgs.btop
    pkgs.jq
    pkgs.ripgrep
    pkgs.rofi
    pkgs.firefox
    pkgs.nerdfonts
    pkgs.tree-sitter
    pkgs.gcc
    pkgs.neovim # handle neovim manually
    pkgs.lazygit
    pkgs.tmux   # handle tmux manually
    pkgs.neofetch
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "nb_NO.UTF-8";
    LC_CTYPE = "nb_NO.UTF-8";
    LC_ALL = "nb_NO.UTF-8";
    EDITOR = "nvim";
    # PAGER = "less -FirSwX";
    # MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
  };

  xdg.configFile."i3/config".text = builtins.readFile ./i3;
  xdg.configFile."rofi/config.rasi".text = builtins.readFile ./rofi;

  # neovim
  xdg.configFile.nvim = {
    source = ./nvim;
    recursive = true;
  };

  home.file.".tmux.conf".source = ./tmux.conf;

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  # programs.direnv= {
  #   enable = true;

  #   config = {
  #     whitelist = {
  #       prefix= [
  #         "$HOME/code/go/src/github.com/hashicorp"
  #         "$HOME/code/go/src/github.com/mitchellh"
  #       ];

  #       exact = ["$HOME/.envrc"];
  #     };
  #   };
  # };

  programs.fish = {
    enable = true;
    # interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
    #   "source ${sources.theme-bobthefish}/functions/fish_prompt.fish"
    #   "source ${sources.theme-bobthefish}/functions/fish_right_prompt.fish"
    #   "source ${sources.theme-bobthefish}/functions/fish_title.fish"
    #   (builtins.readFile ./config.fish)
    #   "set -g SHELL ${pkgs.fish}/bin/fish"
    # ]);

    # shellAliases = {
    #   ga = "git add";
    #   gc = "git commit";
    #   gco = "git checkout";
    #   gcp = "git cherry-pick";
    #   gdiff = "git diff";
    #   gl = "git prettylog";
    #   gp = "git push";
    #   gs = "git status";
    #   gt = "git tag";

    #   # Two decades of using a Mac has made this such a strong memory
    #   # that I'm just going to keep it consistent.
    #   pbcopy = "xclip";
    #   pbpaste = "xclip -o";
    # };

    # plugins = map (n: {
    #   name = n;
    #   src  = sources.${n};
    # }) [
    #   "fish-fzf"
    #   "fish-foreign-env"
    #   "theme-bobthefish"
    # ];
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  programs.git = {
    enable = true;
    # userName = "Mitchell Hashimoto";
    # userEmail = "mitchell.hashimoto@gmail.com";
    # signing = {
    #   key = "523D5DC389D273BC";
    #   signByDefault = true;
    # };
    # aliases = {
    #   prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    #   root = "rev-parse --show-toplevel";
    # };
    # extraConfig = {
    #   branch.autosetuprebase = "always";
    #   color.ui = true;
    #   core.askPass = ""; # needs to be empty to use terminal for ask pass
    #   credential.helper = "store"; # want to make this more secure
    #   github.user = "mitchellh";
    #   push.default = "tracking";
    #   init.defaultBranch = "main";
    # };
  };

  programs.kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty;
  };

  programs.i3status = {
    enable = true;

    general = {
      colors = true;
      color_good = "#8C9440";
      color_bad = "#A54242";
      color_degraded = "#DE935F";
    };

    modules = {
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "battery all".enable = false;
    };
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}
