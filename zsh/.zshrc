# shellcheck shell=bash

crate_root=$HOME/.local

# If you come from bash you might have to change your $PATH.
# ref: https://unix.stackexchange.com/a/62581
export -U PATH=/opt/homebrew/bin:$HOME/bin:$PATH:$crate_root/bin

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# commits
ASDF_TAG=v0.9.0
ASDF_PLUGINS_COMMIT=5655827e9396b941a2e8dd9a167bd44b57fc2c2c
OMZ_COMMIT=4dce175e0e4a678b7f93be80c64247c8f5fbab3e
VIM_PLUGIN_COMMIT=e300178a0e2fb04b56de8957281837f13ecf0b27

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# shellcheck disable=SC2034
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
# shellcheck disable=SC2034
PIP_REQUIRE_VIRTUALENV=1

# tmux plugins
#
# format:
#     owner/repo:commit
#
# example #1:
#     tmux-plugins/tmux-sensible:5d089e4
#
# 1. git clone https://github.com/tmux-plugins/tmux-sensible tmux-sensible
# 2. git checkout 5d089e4 in tmux-sensible
tmux_plugins=(
    tmux-plugins/tmux-battery:5c52d4f
    tmux-plugins/tmux-continuum:9121498
    tmux-plugins/tmux-pain-control:32b760f
    tmux-plugins/tmux-prefix-highlight:15acc61
    tmux-plugins/tmux-resurrect:027960a
    tmux-plugins/tmux-sensible:5d089e4
    tmux-plugins/tmux-yank:1b1a436
    Morantron/tmux-fingers:dbbf9b9
)

# external plugins and themes
#
# format:
#     (plugins|themes):owner/repo[:commit][:alternative_basename]
#
# example #1:
#     themes:romkatv/powerlevel10k:e1c52e0
#
# 1. "themes" or "plugins"
# 2. git clone https://github.com/romkatv/powerlevel10k.git to themes/powerlevel10k
# 3. git checkout e1c52e0 in themes/powerlevel10k
#
# example #2:
#     plugins:MichaelAquilina/zsh-you-should-use:773ae5f:you-should-use
#
# 1. "themes" or "plugins"
# 2. git clone https://github.com/MichaelAquilina/zsh-you-should-use.git to plugins/you-should-use
# 3. git checkout e1c52e0 in plugins/you-should-use
# 4. add alias "you-should-use" to plugins list instead
zsh_plugins=(
    plugins:Aloxaf/fzf-tab:e85f76a
    plugins:MichaelAquilina/zsh-auto-notify:fb38802:auto-notify
    plugins:MichaelAquilina/zsh-you-should-use:773ae5f:you-should-use
    plugins:chuwy/zsh-secrets:1d01c9d
    plugins:hlissner/zsh-autopair:9d003fc
    plugins:jreese/zsh-titles:b7d46d7:titles
    plugins:zsh-users/zsh-autosuggestions:a411ef3
    plugins:zsh-users/zsh-completions:20f3cd5
    plugins:zsh-users/zsh-syntax-highlighting:c7caf57
    themes:romkatv/powerlevel10k:e1c52e0
)

crates=(
    cross:0.2.1
    du-dust:0.6.2
    git-delta:0.12.0
    hyperfine:1.13.0
    license-generator:0.8.1
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
    local category
    local basename
    local alt_basename

    for p in "${zsh_plugins[@]}"; do
        category="$(echo "$p" | awk -F: '{print $1}')"
        [[ "$category" != "plugins" ]] && continue
        basename="$(echo "$p" | awk -F: '{print $2}' | awk -F/ '{print $2}')"
        alt_basename="$(echo "$p" | awk -F: '{print $4}')"
        if [[ -z "$alt_basename" ]]; then
            plugins+=("$basename")
        else
            plugins+=("$alt_basename")
        fi
    done
}

# Instant Prompt of powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    # shellcheck source=/dev/null
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# powerlevel10k configuration must be loaded before oh my zsh
# shellcheck source=/dev/null
source "$HOME/.p10k.zsh"

# shellcheck source=/dev/null
source "$ZSH/oh-my-zsh.sh"

# User configuration

benchmark() {
    if (which hyperfine > /dev/null); then
        /usr/bin/env hyperfine '/usr/bin/env zsh -i -c exit'
    else
        repeat 10 time /usr/bin/env zsh -i -c "exit"
    fi
}

decrypt() {
    eval "$(secrets decrypt environment)"
}

install-asdf() {
    echo "==> install asdf"

    [[ ! -d "$HOME/.asdf" ]] && git clone https://github.com/asdf-vm/asdf.git "$HOME/.asdf"

    pushd -q "$HOME/.asdf" || return
    git fetch
    git checkout "$ASDF_TAG"
    popd -q || return

    echo "==> asdf installed"
}

install-asdf-plugins() {
    echo "==> install asdf-plugins"
    [[ ! -d "$HOME/.asdf/plugins" ]] && git clone https://github.com/henry40408/asdf-plugins.git "$HOME/.asdf/plugins"

    pushd -q "$HOME/.asdf/plugins" || return
    git fetch
    git checkout "$ASDF_PLUGINS_COMMIT"
    git submodule init
    git submodule update
    popd -q || return

    echo "==> asdf-plugins installed"
}

install-crates() {
    local name
    local version

    for c in "${crates[@]}"; do
        name="$(echo "$c" | awk -F: '{print $1}')"
        version="$(echo "$c" | awk -F: '{print $2}')"
        cargo install --root "$crate_root" "$name" --version "$version"
    done
}

install-plugins() {
    install-zsh-plugins
    install-tmux-plugins
}

install-oh-my-zsh() {
    echo "==> install oh my zsh"

    [[ ! -d "$ZSH" ]] && git clone https://github.com/ohmyzsh/ohmyzsh "$HOME/.oh-my-zsh"

    pushd -q "$ZSH" || return
    git fetch
    git checkout "$OMZ_COMMIT"
    popd -q || return

    echo "==> oh my zsh installed"
}

install-tmux-plugins() {
    local plugins_dir
    local repo
    local commit
    local basename
    local dest

    plugins_dir="$HOME/.tmux/plugins"

    pushd "$HOME/.tmux/plugins" || return

    for p in "${tmux_plugins[@]}"; do
        repo="$(echo "$p" | awk -F: '{print $1}')"
        commit="$(echo "$p" | awk -F: '{print $2}')"

        basename="$(echo "$repo" | awk -F/ '{print $2}')"
        echo "==> install $basename"

        dest="$plugins_dir/$basename"

        [[ ! -d "$dest" ]] && git clone --recursive https://github.com/"$repo".git "$dest"

        pushd -q "$dest" || return
        git checkout "$commit"
        popd -q || return
    done

    popd -q || return
}

install-vim-plug() {
    echo "==> install vim-plug"

    [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]] && \
        curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
            --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/$VIM_PLUGIN_COMMIT/plug.vim

    echo "==> vim-plug installed"
}

install-zsh-plugins() {
    local category
    local repo
    local ref
    local alt_basename
    local basename
    local dest

    [[ -z "$ZSH_CUSTOM" ]] && echo "\$ZSH_CUSTOM is not set. abort" && return

    pushd -q "$ZSH_CUSTOM" || return

    for p in "${zsh_plugins[@]}"; do

        category="$(echo "$p" | awk -F: '{print $1}')"
        repo="$(echo "$p" | awk -F: '{print $2}')"
        ref="$(echo "$p" | awk -F: '{print $3}')"
        alt_basename="$(echo "$p" | awk -F: '{print $4}')"

        # use alternative basename instead of basename if alternative basename is given
        if [[ -z "$alt_basename" ]]; then
            basename="$(echo "$repo" | awk -F/ '{print $2}')"
        else
            basename="$alt_basename"
        fi

        dest="$category/$basename"

        if [[ -d "$dest" ]]; then
            echo "==> $basename installed"
        else
            git clone https://github.com/"$repo".git "$dest"
        fi

        pushd -q "$dest" || return
        [[ -n "$ref" ]] && git checkout "$ref"
        popd -q || return
    done

    popd -q || return
}

reload() {
    exec /usr/bin/env zsh
}

restore() {
    pushd "$HOME/.cfg" || return

    # 1. quoting ls command leads unexpected behavior
    # 2. do not prefix subdirectory with dash
    # shellcheck disable=SC2046,SC2035
    stow $(ls -d */)

    popd || return
}

setup() {
    install-asdf
    install-asdf-plugins
    install-oh-my-zsh
    install-vim-plug
}

function() {
    # [[aliases]] https://remysharp.com/2018/08/23/cli-improved
    (which bat &> /dev/null) && alias cat="bat"
    (which fzf &> /dev/null) && alias preview="fzf --preview 'bat --color \"always\" {}'"
    (which lsd &> /dev/null) && alias ls="lsd"
    (which procs &> /dev/null) && alias ps="procs"
    (which zoxide &> /dev/null) && eval "$(zoxide init zsh)"

    # [my] private configuration
    # shellcheck source=/dev/null
    [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

    true # prevent result of shorthand expression from being exit status
}

# vim: set foldlevel=0 foldmethod=marker:
