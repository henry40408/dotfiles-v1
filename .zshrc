#!/usr/bin/env zsh

PLATFORM=`uname`

_install_antigen() {
    echo "==> install antigen"

    if [[ -d ".antigen" ]]; then
        echo "==> antigen exists. remove .antigen directory to re-install. abort"
        return 1
    fi

    mkdir -p "${HOME}/.antigen"
    /usr/bin/env curl -L git.io/antigen > .antigen/antigen.zsh
    echo "==> antigen installed"
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
    for i in $(seq 1 10); do time zsh -i -c exit; done
}

setup() {
    _install_antigen || true
    _install_asdf || true
    _install_vim_plug || true
}

if [[ -f "${HOME}/.antigen/antigen.zsh" ]]; then
    source "${HOME}/.antigen/antigen.zsh"

    # [[plugins]]

    antigen use oh-my-zsh

    antigen bundle asdf
    antigen bundle docker

    # disable it since `setup_using_debian_package` slows startup
    #antigen bundle fzf

    antigen bundle gem
    antigen bundle git
    antigen bundle gitignore
    antigen bundle gpg-agent

    # disable until https://github.com/ohmyzsh/ohmyzsh/issues/6843 gets fixed
    #antigen bundle kubectl

    antigen bundle pip
    antigen bundle rails
    antigen bundle ruby

    antigen bundle djui/alias-tips
    antigen bundle jreese/zsh-titles
    antigen bundle zdharma/fast-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions

    if [[ "${PLATFORM}" = "Darwin" ]]; then
        antigen bundle osx
    fi

    # [[theme]]
    antigen theme ys

    antigen apply
fi

# [zsh] configuration about history
setopt histfindnodups
setopt histignorealldups
setopt histsavenodups

# [homebrew] extra PATH
export PATH="/usr/local/sbin:${PATH}"

# [my] per-user executable
export PATH="${HOME}/bin:${PATH}"

# [python] no packages should be installed outside pip
export PIP_REQUIRE_VIRTUALENV=1

# [zoxide]
(hash zoxide 2> /dev/null) && eval "$(zoxide init zsh)"

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

# load starship prompt
(hash starship 2>/dev/null) && eval "$(starship init zsh)"

# [my] private configuration
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

# vim: set foldlevel=0 foldmethod=marker:
