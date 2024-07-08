if test -e $HOME/.config/fish/init.fish
    source $HOME/.config/fish/init.fish
end

set fish_greeting Hello, anhoder!

set -gx CLICOLOR Yes
set -gx LS_OPTIONS '--color=auto'
set -gx XDG_CONFIG_HOME "$HOME/.config"

# Git
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias ga="git add"
alias gm="git merge"
alias gc="git commit"


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

# PATH
set -gx PATH "$HOMEBREW_PREFIX/opt/openssl@1.1/bin:$HOMEBREW_PREFIX/opt/libiconv/bin:$HOMEBREW_PREFIX/opt/curl/bin:$HOMEBREW_PREFIX/opt/bison/bin:$GOPATH/bin:$PATH"

# LDFLAGS
set -gx LDFLAGS "$LDFLAGS -L$HOMEBREW_PREFIX/lib -L$HOMEBREW_PREFIX/opt/openssl@1.1/lib -L$HOMEBREW_PREFIX/opt/libiconv/lib -L$HOMEBREW_PREFIX/opt/curl/lib -L$HOMEBREW_PREFIX/opt/bison/lib -L$HOMEBREW_PREFIX/opt/cairo/lib"

# DYLD_LIBRARY_PATH
set -gx DYLD_FALLBACK_LIBRARY_PATH "$DYLD_FALLBACK_LIBRARY_PATH:$HOMEBREW_PREFIX/lib:$HOMEBREW_PREFIX/opt/openssl@1.1/lib:$HOMEBREW_PREFIX/opt/libiconv/lib:$HOMEBREW_PREFIX/opt/curl/lib:$HOMEBREW_PREFIX/opt/bison/lib:$HOMEBREW_PREFIX/opt/cairo/lib"

# LIBS
set -gx LIBS "$LIBS -lssl -lcrypto"

# CFLAGS
set -gx CFLAGS "$CFLAGS -I$HOMEBREW_PREFIX/opt/openssl@1.1/include -I$HOMEBREW_PREFIX/opt/libiconv/include -I$HOMEBREW_PREFIX/opt/curl/include -I$HOMEBREW_PREFIX/opt/php/include"

# CPPFLAGS
set -gx CPPFLAGS "$CPPFLAGS -I$HOMEBREW_PREFIX/opt/openssl@1.1/include -I$HOMEBREW_PREFIX/opt/libiconv/include -I$HOMEBREW_PREFIX/opt/curl/include -I$HOMEBREW_PREFIX/opt/php/include"

# PKG_COFNIG_PATH
set -gx PKG_COFNIG_PATH "$HOMEBREW_PREFIX/opt/openssl@1.1/lib/pkgconfig:$HOMEBREW_PREFIX/opt/curl/lib/pkgconfig:$PKG_COFNIG_PATH"

# OpenSSL
set -gx OPENSSL_ROOT_DIR "$HOMEBREW_PREFIX/opt/openssl@1.1"
set -gx OPENSSL_LIBS "-L$HOMEBREW_PREFIX/opt/openssl@1.1/lib"
set -gx OPENSSL_CFLAGS "-I$HOMEBREW_PREFIX/opt/openssl@1.1/include"

# starship
set -gx STARSHIP_CONFIG $HOME/.config/starship/starship.toml
set -gx command_timeout 200
set -gx STARSHIP_LOG error
starship init fish | source

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
if command -v g >/dev/null 2>&1
    functions -e ll
    functions -e l
    functions -e la
    functions -e ls
    alias ls 'g --hyperlink=always'
    alias la 'g --show-hidden --hyperlink=always'
    alias ll 'g --perm --icons --time --group --owner --size --title --lh --hyperlink=always --time-style=long-iso'
    alias ll 'g --perm --icons --time --group --owner --size --title --lh --hyperlink=always --time-style=long-iso'
    alias l 'g --perm --icons --time --group --owner --size --title --show-hidden --lh --hyperlink=always --time-style=long-iso'
end

bind -M insert \ca beginning-of-line
bind -M insert \ce end-of-line

fish_vi_key_bindings
