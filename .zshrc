#!/usr/bin/env zsh

PLATFORM=`uname`

_install_zgen() {
    echo "==> install zgen"
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
    echo "==> zgen installed"
}

_install_asdf() {
    echo "==> install asdf"
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.7.8
    echo "==> asdf installed"
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

benchmark() {
    for i ({1..10}) time zsh -ilc exit
}

setup() {
    _install_zgen || true
    _install_asdf || true
    _install_vim_plug || true
}

if [[ -f "${HOME}/.zgen/zgen.zsh" ]]; then
    source "${HOME}/.zgen/zgen.zsh"
    
    # load powerlevel10k configuration
    [[ -f "${HOME}/.p10k.zsh" ]] && source "${HOME}/.p10k.zsh"

    if ! zgen saved; then
        # [[plugins]]

        zgen oh-my-zsh

        zgen oh-my-zsh plugins/asdf
        zgen oh-my-zsh plugins/docker
        zgen oh-my-zsh plugins/fzf
        zgen oh-my-zsh plugins/gem
        zgen oh-my-zsh plugins/git
        zgen oh-my-zsh plugins/gitignore
        zgen oh-my-zsh plugins/gpg-agent
        zgen oh-my-zsh plugins/pip
        zgen oh-my-zsh plugins/ruby
        zgen oh-my-zsh plugins/z

        zgen load djui/alias-tips
        zgen load jreese/zsh-titles
        zgen load zdharma/fast-syntax-highlighting
        zgen load zsh-users/zsh-autosuggestions

        [[ "${PLATFORM}" = "Darwin" ]] && zgen oh-my-zsh plugins/osx

        # [[theme]]
        zgen load romkatv/powerlevel10k powerlevel10k

        zgen save
    fi
fi

# [zsh] configuration about history
setopt histfindnodups histignorealldups histsavenodups

# [homebrew] extra PATH
export PATH="/usr/local/sbin:${PATH}"

# [my] per-user executable
export PATH="${HOME}/bin:${PATH}"

# [python] no packages should be installed outside pip
export PIP_REQUIRE_VIRTUALENV=1

# [[aliases]]

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"

# https://remysharp.com/2018/08/23/cli-improved
(hash bar 2> /dev/null) && alias cat="bat"
(hash dust 2> /dev/null) && alias du="dust"
(hash fd 2> /dev/null) && alias find="fd"
(hash rg 2> /dev/null) && alias grep="rg"
(hash exa 2> /dev/null) && alias ls="exa"
(hash prettyping 2> /dev/null) && alias ping="prettyping"
(hash fzf 2> /dev/null) && alias preview="fzf --preview 'bat --color \"always\" {}'"
(hash htop 2> /dev/null) && alias top="sudo htop"

# [my] private configuration
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

# vim: set foldlevel=0 foldmethod=marker:
