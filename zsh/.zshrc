crate_root=$HOME/.local

# If you come from bash you might have to change your $PATH.
# ref: https://unix.stackexchange.com/a/62581
export -U PATH=/opt/homebrew/bin:$HOME/bin:$PATH:$crate_root/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Checkout after oh-my-zsh is cloned
OMZ_COMMIT=ef3f7c43

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    asdf
    command-not-found
    common-aliases
    direnv
    docker-compose
    fzf
    gem
    git
    git-extras
    gitignore
    golang
    gpg-agent
    helm
    kubectl
    pip
    python
    rails
    ruby
    virtualenvwrapper
)

# pip plugin
PIP_REQUIRE_VIRTUALENV=1

# tmux plugins
#
# format:
#     owner/repo@commit
#
# example #1:
#     tmux-plugins/tmux-sensible@5d089e4
#
# 1. git clone https://github.com/tmux-plugins/tmux-sensible tmux-sensible
# 2. git checkout 5d089e4 in tmux-sensible
tmux_plugins=(
    tmux-plugins/tmux-battery@5c52d4f
    tmux-plugins/tmux-continuum@9121498
    tmux-plugins/tmux-pain-control@32b760f
    tmux-plugins/tmux-prefix-highlight@15acc61
    tmux-plugins/tmux-resurrect@027960a
    tmux-plugins/tmux-sensible@5d089e4
    tmux-plugins/tmux-yank@1b1a436
    Morantron/tmux-fingers@dbbf9b9
)

# external plugins and themes
#
# format:
#     (plugins|themes):owner/repo[@commit][:alternative_basename]
#
# example #1:
#     themes:romkatv/powerlevel10k@e1c52e0
#
# 1. "themes" or "plugins"
# 2. git clone https://github.com/romkatv/powerlevel10k.git to themes/powerlevel10k
# 3. git checkout e1c52e0 in themes/powerlevel10k
#
# example #2:
#     plugins:MichaelAquilina/zsh-you-should-use@773ae5f:you-should-use
#
# 1. "themes" or "plugins"
# 2. git clone https://github.com/MichaelAquilina/zsh-you-should-use.git to plugins/you-should-use
# 3. git checkout e1c52e0 in plugins/you-should-use
# 4. add alias "you-should-use" to plugins list instead
zsh_plugins=(
    plugins:Aloxaf/fzf-tab@e85f76a
    plugins:MichaelAquilina/zsh-auto-notify@fb38802:auto-notify
    plugins:MichaelAquilina/zsh-you-should-use@773ae5f:you-should-use
    plugins:chuwy/zsh-secrets@1d01c9d
    plugins:hlissner/zsh-autopair@9d003fc
    plugins:jreese/zsh-titles@b7d46d7:titles
    plugins:zsh-users/zsh-autosuggestions@a411ef3
    plugins:zsh-users/zsh-completions@20f3cd5
    plugins:zsh-users/zsh-syntax-highlighting@c7caf57
    themes:romkatv/powerlevel10k@e1c52e0
)

crates=(
    cross:0.2.1
    du-dust:0.6.2
    git-delta:0.12.0
    lsd:0.20.1
    procs:0.11.10
    tokei:12.1.2
    xsv:0.13.0
    zoxide:0.7.9
)

# platform-specific plugins
function() {
    [[ "$OSTYPE" = "darwin" || "$OSTYPE" = "darwin21.0" ]] && plugins+=(brew)
}

# add external plugins to oh-my-zsh plugin list
function() {
    for p in $zsh_plugins; do
        local category="$(echo $p | awk -F: '{print $1}')"
        if [[ "$category" != "plugins" ]]; then
            continue
        fi
        local basename="$(echo $p | awk -F: '{print $2}' | awk -F@ '{print $1}' | awk -F/ '{print $2}')"
        local alt_basename="$(echo $p | awk -F: '{print $3}')"
        if [[ -z "$alt_basename" ]]; then
            plugins+=($basename)
        else
            plugins+=($alt_basename)
        fi
    done
}

# Instant Prompt of powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# powerlevel10k configuration must be loaded before oh my zsh
source $HOME/.p10k.zsh

source $ZSH/oh-my-zsh.sh

# User configuration

benchmark() {
    if (( $+commands[hyperfine] )); then
        /usr/bin/env hyperfine '/usr/bin/env zsh -i -c exit'
    else
        for i in $(seq 1 10); do time /usr/bin/env zsh -i -c "exit"; done
    fi
}

decrypt() {
    eval "$(secrets decrypt environment)"
}

install-asdf() {
    echo "==> install asdf"
    [[ ! -d "$HOME/.asdf" ]] && git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.9.0
    echo "==> asdf installed"
}

install-asdf-plugins() {
    local commit=6c8da3196f79fd3fd232029db3958edee287be0f

    echo "==> install asdf-plugins"
    if [[ ! -d "$HOME/.asdf/plugins" ]]; then
        git clone https://github.com/henry40408/asdf-plugins.git $HOME/.asdf/plugins
    fi

    pushd $HOME/.asdf/plugins > /dev/null
    git checkout $commit
    git submodule init
    git submodule update
    popd > /dev/null

    echo "==> asdf-plugins installed"
}

install-plugins() {
    install-zsh-plugins
    install-tmux-plugins
}

install-crates() {
    for c in $crates; do
        local name="$(echo $c | awk -F: '{print $1}')"
        local version="$(echo $c | awk -F: '{print $2}')"
        cargo install --root $crate_root $name --version $version
    done
}

install-oh-my-zsh() {
    echo "==> install oh my zsh"

    [[ ! -d "$ZSH" ]] && git clone https://github.com/ohmyzsh/ohmyzsh $HOME/.oh-my-zsh

    pushd $ZSH > /dev/null
    [[ ! -z "$OMZ_COMMIT" ]] && git checkout $OMZ_COMMIT
    popd > /dev/null

    echo "==> oh my zsh installed"
}

install-tmux-plugins() {
    local plugins_dir=$HOME/.tmux/plugins

    pushd $HOME/.tmux/plugins > /dev/null

    for p in $tmux_plugins; do
        local repo="$(echo $p | awk -F@ '{print $1}')"
        local commit="$(echo $p | awk -F@ '{print $2}')"

        local basename="$(echo $repo | awk -F/ '{print $2}')"
        echo "==> install $basename"

        local dest="$plugins_dir/$basename"

        if [[ ! -d "$dest" ]]; then
            git clone --recursive https://github.com/$repo.git $dest
        fi

        pushd $dest > /dev/null
        git checkout $commit
        popd
    done

    popd > /dev/null
}

install-vim-plug() {
    local commit=e300178a0e2fb04b56de8957281837f13ecf0b27
    echo "==> install vim-plug"
    if [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]]; then
        curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
            --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/$commit/plug.vim
    fi
    echo "==> vim-plug installed"
}

install-zsh-plugins() {
    if [[ -z "$ZSH_CUSTOM" ]]; then
        echo "\$ZSH_CUSTOM is not set. abort"
        return
    fi

    pushd $ZSH_CUSTOM > /dev/null

    for p in $zsh_plugins; do
        local category="$(echo $p | awk -F: '{print $1}')"
        local repo="$(echo $p | awk -F: '{print $2}' | awk -F@ '{print $1}')"
        local alt_basename="$(echo $p | awk -F: '{print $3}')"

        # use alternative basename instead of basename if alternative basename is given
        if [[ -z "$alt_basename" ]]; then
            local basename="$(echo $repo | awk -F/ '{print $2}')"
        else
            local basename="$alt_basename"
        fi
        local dest="$category/$basename"

        if [[ -d "$dest" ]]; then
            echo "==> $basename installed"
        else
            git clone https://github.com/$repo.git $dest
        fi

        pushd $dest > /dev/null
        local ref="$(echo $p | awk -F: '{print $2}' | awk -F@ '{print $2}')"
        [[ ! -z "$ref" ]] && git checkout $ref
        popd > /dev/null
    done

    popd > /dev/null
}

reload() {
    exec /usr/bin/env zsh
}

restore() {
    pushd $HOME/.cfg
    stow $(ls -d */)
    popd
}

setup() {
    install-asdf
    install-asdf-plugins
    install-oh-my-zsh
    install-vim-plug
}

function() {
    # [[aliases]] https://remysharp.com/2018/08/23/cli-improved
    (( $+commands[bat] )) && alias cat="bat"
    (( $+commands[fzf] )) && alias preview="fzf --preview 'bat --color \"always\" {}'"
    (( $+commands[lsd] )) && alias ls="lsd"
    (( $+commands[procs] )) && alias ps="procs"
    (( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

    # [my] private configuration
    [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

    true # prevent result of shorthand expression from being exit status
}

# vim: set foldlevel=0 foldmethod=marker:
