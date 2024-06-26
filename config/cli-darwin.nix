{ config, pkgs, lib, inputs, ... }:
{

  environment.variables = {
    EDITOR = "vim";
    LC_ALL = "en_US.UTF-8";
    TERM = "xterm-256color";
    NIX_CONFIG = "/Users/luc/Documents/nix_config";
  };

  users.defaultUserShell = lib.getExe pkgs.zsh;

  programs.zsh = {
    enableBashCompletion = true;
    enable = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    # shellInit = ''
    #   source ${pkgs.zsh-forgit}/share/zsh-forgit/forgit.plugin.zsh
    # '';
    # promptInit = ''
    #   ${builtins.readFile (pkgs.shell-config.override { dockerAliasEnabled = config.virtualisation.docker.enable; })}
    #   autoload -U promptinit && promptinit && prompt pure
    # '';

  };

  environment.shellAliases = {
    ga = "git add";
    gc = "git commit";
    gcm = "git commit -m";
    gs = "git status";
    gsb = "git status -sb";

    grep = "grep --color=auto";
    diff = "diff --color=auto";
    #nixos-rebuild = "nixos-rebuild switch --use-remote-sudo --flake .#";
    auto-nix-rebuild = "ls /etc/nixos/**/*.nix | entr sudo bash -c 'nixos-rebuild switch && printf \"DONE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n\n\"'";
    personal = "sudo $EDITOR /etc/nixos/personal.nix";
    opt = "manix '' | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --ansi --preview=\"manix '{}' | sed 's/type: /> type: /g' | bat -l Markdown --color=always --plain\"";

    burn = "pkill -9";
    external-ip = "dig +short myip.opendns.com @resolver1.opendns.com";
    v = "$EDITOR $(fzf)";
    sv = "sudo $EDITOR $(fzf)";
    killall = "pkill";
    q = "exit";
    sc = "sudo systemctl";
    scu = "systemctl --user ";
    svi = "sudo $EDITOR";
    net = "ip -c -br addr";

    mkdir = "mkdir -p";
    rm = "rm -Iv --preserve-root";
    wget = "wget -c";

    c = "xclip -selection clipboard";
    cm = "xclip"; # Copy to middle click clipboard
    l = "ls -lF --time-style=long-iso";
    la = "l -a";
    ls = "exa -h --git --color=auto --group-directories-first -s extension";
    lstree = "ls --tree";
    tree = "lstree";

    ".." = "cd ..";
    "..." = "cd ../../";
    "...." = "cd ../../../";
    "....." = "cd ../../../../";
    "......" = "cd ../../../../../";
  };

  environment.systemPackages = with pkgs; [
    bat
    tmux
    curl
    entr
    exa
    fd
    file
    fzf
    gcc
    git
    git-lfs
    htop
    inetutils
    iotop
    lm_sensors
    lshw
    lsof
    man
    nettools
    nix-tree
    nixpkgs-fmt
    nushell
    p7zip
    parted
    pciutils
    psmisc
    pure-prompt
    ranger
    ripgrep
    rustup
    unzip
    wget
    which
    zip
    vim
    neovim
    yubikey-agent
    yubikey-manager
    yubikey-personalization
    efibootmgr
    nix-index
  ];
}
