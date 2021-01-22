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

_install_zgen() {
    echo "==> install zgen"
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
    echo "==> zgen installed"
}

benchmark() {
    for i ({1..10}) time zsh -ilc 'zgen reset; exit'
}

reload() {
    zgen reset; exec zsh
}

restore() {
    pushd ${HOME}/.cfg
    stow $(ls -d */)
    popd
}

setup() {
    _install_zgen
    _install_asdf
    _install_vim_plug
    _install_tpm
}

if [[ -f "${HOME}/.zgen/zgen.zsh" ]]; then
    source "${HOME}/.zgen/zgen.zsh"

    # load powerlevel10k configuration
    [[ -f "${HOME}/.p10k.zsh" ]] && source "${HOME}/.p10k.zsh"

    if ! zgen saved; then
        # [[plugins]]

        zgen oh-my-zsh

        zgen oh-my-zsh plugins/asdf
        zgen oh-my-zsh plugins/command-not-found
        zgen oh-my-zsh plugins/docker
        zgen oh-my-zsh plugins/docker-compose
        zgen oh-my-zsh plugins/fzf
        zgen oh-my-zsh plugins/gem
        zgen oh-my-zsh plugins/git
        zgen oh-my-zsh plugins/gitignore
        zgen oh-my-zsh plugins/gpg-agent
        [[ "${PLATFORM}" = "Darwin" ]] && zgen oh-my-zsh plugins/osx
        zgen oh-my-zsh plugins/pip
        zgen oh-my-zsh plugins/ruby

        zgen load MichaelAquilina/zsh-auto-notify

        zgen load MichaelAquilina/zsh-you-should-use
        export YSU_HARDCORE=1

        zgen load hlissner/zsh-autopair
        zgen load jreese/zsh-titles
        zgen load zdharma/fast-syntax-highlighting
        zgen load zsh-users/zsh-autosuggestions
        zgen load zsh-users/zsh-completions

        # [[theme]]
        zgen load romkatv/powerlevel10k powerlevel10k

        zgen save
    fi
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
