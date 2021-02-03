#!/usr/bin/env zsh

PLATFORM=`uname`

_install_asdf() {
    echo "==> install asdf"
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.8.0
    echo "==> asdf installed"
}

_install_tpm() {
    echo "==> install tpm"
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm --branch v3.0.0
    echo "==> tpm installed"
}

_install_vim_plug() {
    echo "==> install vim-plug"

    if [[ -f ~/.vim/autoload/plug.vim ]]; then
        echo "==> vim-plug installed. remove ~/.vim/autoload/plug.vim to re-install. abort."
        return 1
    fi

    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "==> vim-plug installed"
}

_install_zplug() {
    echo "==> install zplug"
    git clone https://github.com/zplug/zplug.git "${HOME}/.zplug"
    echo "==> zplug installed"
}

benchmark() {
    echo cached
    for i ({1..3}) time zsh -ilc 'exit'
    echo non-cached
    for i ({1..3}) time zsh -ilc 'zplug clean; exit'
}

reload() {
    zplug clean; exec zsh
}

restore() {
    pushd ${HOME}/.cfg
    stow $(ls -d */)
    popd
}

setup() {
    _install_zplug
    _install_asdf
    _install_vim_plug
    _install_tpm
}

if [[ -f "${HOME}/.zplug/init.zsh" ]]; then
    source "${HOME}/.zplug/init.zsh"

    # load powerlevel10k configuration
    [[ -f "${HOME}/.p10k.zsh" ]] && source "${HOME}/.p10k.zsh"

    # [[plugins]]

    zplug "plugins/asdf", from:oh-my-zsh
    zplug "plugins/command-not-found", from:oh-my-zsh
    zplug "plugins/docker", from:oh-my-zsh
    zplug "plugins/docker-compose", from:oh-my-zsh
    zplug "plugins/fzf", from:oh-my-zsh
    zplug "plugins/gem", from:oh-my-zsh
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/gitignore", from:oh-my-zsh
    zplug "plugins/gpg-agent", from:oh-my-zsh
    zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
    zplug "plugins/pip", from:oh-my-zsh
    zplug "plugins/ruby", from:oh-my-zsh

    zplug "MichaelAquilina/zsh-auto-notify"

    zplug "MichaelAquilina/zsh-you-should-use"
    export YSU_HARDCORE=1

    zplug "hlissner/zsh-autopair"
    zplug "jreese/zsh-titles"
    zplug "zdharma/fast-syntax-highlighting", defer:2
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"

    zplug "BurntSushi/xsv", as:command, from:gh-r, at:0.13.0
    zplug "Peltoche/lsd", as:command, from:gh-r, at:0.19.0
    zplug "ajeetdsouza/zoxide", as:command, from:gh-r, at:v0.5.0
    zplug "bootandy/dust", as:command, from:gh-r, at:v0.5.4
    zplug "dalance/procs", as:command, from:gh-r, at:v0.11.3, use:"*x86_64-mac*"

    # [[theme]]
    zplug "romkatv/powerlevel10k", as:theme

    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    zplug load
fi

# [zsh] configuration about history
setopt histfindnodups histignorealldups histsavenodups

# [homebrew] configuration
export PATH="/usr/local/sbin:${PATH}"

# [my] per-user executable
export PATH="${HOME}/bin:${PATH}"

# [python] no packages should be installed outside pip
export PIP_REQUIRE_VIRTUALENV=1

# [tmuxifier]
export PATH="${HOME}/.tmuxifier/bin:${PATH}"

# [[aliases]]

(type bat > /dev/null) && alias cat="bat"
(type dust > /dev/null) && alias du="dust"
(type fd > /dev/null) && alias find="fd"
(type rg > /dev/null) && alias grep="rg"
(type lsd > /dev/null) && alias ls="lsd"
(type fzf > /dev/null) && alias preview="fzf --preview 'bat --color \"always\" {}'"
(type zoxide > /dev/null) && eval "$(zoxide init zsh)"

# [my] private configuration
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local" || true

# vim: set foldlevel=0 foldmethod=marker:
