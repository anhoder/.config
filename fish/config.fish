if test -e $HOME/.config/fish/init.fish
    source $HOME/.config/fish/init.fish
end

set fish_greeting Hello, anhoder!

set -gx CLICOLOR Yes
set -gx LS_OPTIONS '--color=auto'
set -gx XDG_CONFIG_HOME "$HOME/.config"

set -gx NIX_CONF_DIR "$XDG_CONFIG_HOME/nix"

# php
alias dphp="XDEBUG_SESSION=1 php"
alias xphp="XDEBUG_SESSION=1 php"

# Git
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias ga="git add"
alias gm="git merge"
alias gc="git commit"
alias gop="git open"
## git lost found
alias glf="git fsck --unreachable | grep commit | awk '{print \$3}' | xargs git show"
function gba
    if test -z "$argv[1]"
        echo "Usage: gba [<branch>] <to-alias>"
        return -1
    end
    if test -z "$argv[2]"
        set argv[2] $argv[1]
        set argv[1] $(git symbolic-ref --short HEAD 2>/dev/null)
    end
    git symbolic-ref "refs/heads/$argv[2]" "refs/heads/$argv[1]"
end

# alilang
alias alilang="~/Library/Android/sdk/emulator/emulator -avd alilang"


alias kssh="kitten ssh"

# VSCode-Insider
alias code="code-insiders"

# set -gx TERM tmux-256color

# Homebrew
# set -gx HOMEBREW_API_DOMAIN https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api
# set -gx HOMEBREW_BREW_GIT_REMOTE https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
# set -gx HOMEBREW_CORE_GIT_REMOTE https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
# set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
set -gx HOMEBREW_AUTO_UPDATE_SECS 86400
set -gx HOMEBREW_BUNDLE_FILE "$HOME/.config/homebrew/brewfile"
if test -z "$HOMEBREW_PREFIX"
    # 默认/usr/local，需要变更，在init.fish中设置
    set -gx HOMEBREW_PREFIX /usr/local
end
set -gx PATH "$HOME/.cargo/bin:$PATH"
set -gx PATH "$HOMEBREW_PREFIX/bin:$PATH"
alias ibrew="/usr/local/bin/brew"

# GOPATH
set -gx GOPATH "$HOME/go"
set -gx PATH "$GOPATH/bin:$PATH"

# composer
set -gx PATH "$HOME/.composer/vendor/bin:$PATH"

# openjdk
set -gx PATH "$HOMEBREW_PREFIX/opt/openjdk/bin:$PATH"
set -gx JAVA_HOME "$HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
set -gx GRADLE_USER_HOME "$HOME/.gradle"

# openssl
set -gx OPENSSL_PREFIX "$HOMEBREW_PREFIX/opt/openssl@1.1"
set -gx OPENSSL_CFLAGS "-I$OPENSSL_PREFIX}/include"
set -gx OPENSSL_LIBS "-L$OPENSSL_PREFIX/lib -lcrypto -lssl"
set -gx OPENSSL_ROOT_DIR "$OPENSSL_PREFIX"
set -gx OPENSSL_LIBS "-L$OPENSSL_PREFIX/lib"
set -gx OPENSSL_CFLAGS "-I$OPENSSL_PREFIX/include"

# rust
set -gx RUSTUP_HOME "$HOMEBREW_PREFIX/opt/rustup"
set -gx PATH "$RUSTUP_HOME/bin:$PATH"

# PATH
set -gx PATH "$OPENSSL_PREFIX/bin:$HOMEBREW_PREFIX/opt/libiconv/bin:$HOMEBREW_PREFIX/opt/curl/bin:$HOMEBREW_PREFIX/opt/bison/bin:$GOPATH/bin:$PATH"

# LDFLAGS
set -gx LDFLAGS "$LDFLAGS -L$HOMEBREW_PREFIX/lib -L$OPENSSL_PREFIX/lib -L$HOMEBREW_PREFIX/opt/libiconv/lib -L$HOMEBREW_PREFIX/opt/curl/lib -L$HOMEBREW_PREFIX/opt/bison/lib -L$HOMEBREW_PREFIX/opt/cairo/lib"

# DYLD_LIBRARY_PATH
set -gx DYLD_FALLBACK_LIBRARY_PATH "$DYLD_FALLBACK_LIBRARY_PATH:$HOMEBREW_PREFIX/lib:$OPENSSL_PREFIX/lib:$HOMEBREW_PREFIX/opt/libiconv/lib:$HOMEBREW_PREFIX/opt/curl/lib:$HOMEBREW_PREFIX/opt/bison/lib:$HOMEBREW_PREFIX/opt/cairo/lib"

# LIBS
set -gx LIBS "$LIBS -lssl -lcrypto"

# CFLAGS
set -gx CFLAGS "$CFLAGS -I$OPENSSL_PREFIX/include -I$HOMEBREW_PREFIX/opt/libiconv/include -I$HOMEBREW_PREFIX/opt/curl/include -I$HOMEBREW_PREFIX/include"

# CPPFLAGS
set -gx CPPFLAGS "$CPPFLAGS -I$OPENSSL_PREFIX/include -I$HOMEBREW_PREFIX/opt/libiconv/include -I$HOMEBREW_PREFIX/opt/curl/include -I$HOMEBREW_PREFIX/include"

# PKG_COFNIG_PATH
set -gx PKG_COFNIG_PATH "$OPENSSL_PREFIX/lib/pkgconfig:$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig:$HOMEBREW_PREFIX/lib/pkgconfig:$PKG_COFNIG_PATH"

# starship
if command -v starship >/dev/null 2>&1
    set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
    set -gx command_timeout 200
    set -gx STARSHIP_LOG error
    starship init fish | source
end

set -gx EDITOR vim
if command -v nvim >/dev/null 2>&1
    set -gx EDITOR nvim
end

# neovide
set -gx NEOVIDE_FRAME full
set -gx NEOVIDE_MAXIMIZED 1
set -gx NEOVIDE_MULTIGRID 1
set -gx NEOVIDE_IDLE 1
set -gx NEOVIDE_SRGB 0
set -gx NEOVIDE_VSYNC 1

if command -v nvim >/dev/null 2>&1
    alias vim="nvim"
end

if command -v neovide >/dev/null 2>&1
    # alias vd=fn_neovide
    function vd
        neovide $argv --fork
        if uname -s | grep -i darwin >/dev/null
            sleep 1.5
            killall Dock
        end
    end
end

if command -v trash >/dev/null 2>&1
    alias rm="trash"
end

if command -v kitten >/dev/null 2>&1
    alias icat="kitten icat"
    alias k="kitten"
end

if command -v aerospace >/dev/null 2>&1
    alias aerospace-next="aerospace list-workspaces --monitor focused --empty no | aerospace workspace next"
    alias aerospace-prev="aerospace list-workspaces --monitor focused --empty no | aerospace workspace prev"
end

# ls
if command -v lsd >/dev/null 2>&1
    functions -e ll
    functions -e l
    functions -e la
    functions -e ls
    alias ls 'lsd --icon=never --group-dirs=first --hyperlink=auto'
    alias la 'ls -A'
    alias ll "lsd -l --date='+%Y-%m-%d %H:%M:%S' --group-dirs=first --hyperlink=auto"
    alias l "ll -A"
    alias lt "la --tree --depth=1"
end

bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line

fish_vi_key_bindings
