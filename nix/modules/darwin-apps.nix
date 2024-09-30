{ pkgs, ... }: {
  ##########################################################################
  #
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  # TODO Fell free to modify this file to fit your needs.
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [
    # git
  ];
  environment.variables.EDITOR = "nvim";

  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      # cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 

    masApps = {
      # Wechat = 836500024;
    };

    taps = [
      "homebrew/services"
      "homebrew/bundle"
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/command-not-found"
      "anhoder/repo"
      "go-musicfox/go-musicfox"
      "shivammathur/php"
      "git-chglog/git-chglog"
    ];

    # `brew install`
    brews = [
      "openssl@3"
      "automake"
      "bat"
      "protobuf"
      "grpc"
      "bear"
      "openjdk"
      "boost"
      "pcre2"
      "glib"
      "cmake"
      "curl"
      "composer"
      "delve"
      "docker"
      "flac"
      "ffmpeg"
      "fish"
      "fzf"
      "git"
      "git-delta"
      "anhoder/repo/git-open"
      "gnu-sed"
      "go"
      "pkg-config"
      "jq"
      "k9s"
      "lazygit"
      "openssl@1.1"
      "libiconv"
      "llvm"
      "protobuf"
      "lua"
      "mpv"
      "trash-cli"
      "mysql-client"
      "nginx"
      "node"
      "redis"
      "php@8.0"
      "ripgrep"
      "rust"
      "starship"
      "telnet"
      "tldr"
      "trash"
      "tree"
      "typescript"
      "ttyd"
      "vim"
      "watch"
      "wget"
      "yarn"
      "g-ls"
      "coreutils"
      "vegeta"
      "imagemagick"
      "luarocks" # for `luarocks --lua-version=5.1 --lua-dir=$HOMEBREW/opt/lua@5.1/bin --local install magick`
      "anhoder/repo/neovim"
      "anhoder/repo/lua@5.1"
      "git-chglog/git-chglog/git-chglog"
      "anhoder/repo/neovim-nightly"
      "go-musicfox/go-musicfox/go-musicfox"
      "go-musicfox/go-musicfox/spotifox"
      "shivammathur/php/php@8.0"
    ];

    # `brew install --cask`
    casks = [
      "jordanbaird-ice"
      "font-fira-code-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-meslo-lg-nerd-font"
      "font-symbols-only-nerd-font"
      "font-comic-mono"
      "kitty@nightly"
      "brave-browser"
      "neovide"
      "redisinsight"
      "opencore-configurator"
    ];
  };
}
