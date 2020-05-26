#!/usr/bin/env zsh

PLATFORM=`uname`

_install_zinit() {
    echo "==> install zinit"

    if [[ -d ".zinit" ]]; then
        echo "==> zinit exists. remove ~/.zinit directory to re-install. abort"
        return 1
    fi

    mkdir -p ${HOME}/.zinit
    git clone --depth 1 https://github.com/zdharma/zinit.git ${HOME}/.zinit/bin
}

_install_asdf() {
    echo "==> install asdf"
    git clone --depth 1 https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.7.8
    echo "==> asdf installed"
}

_install_vim_plug() {
    echo "==> install vim-plug"

    if [[ -f ${HOME}/.vim/autoload/plug.vim ]]; then
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
    _install_zinit || true
    _install_asdf || true
    _install_vim_plug || true
}

if [[ -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
    source "${HOME}/.zinit/bin/zinit.zsh"

    # [[plugins]]

    zinit wait lucid for \
      OMZ::lib/clipboard.zsh \
      OMZ::lib/completion.zsh \
      OMZ::lib/history.zsh \
      OMZ::lib/key-bindings.zsh \
      OMZ::lib/git.zsh \
      OMZ::lib/theme-and-appearance.zsh

    zinit wait lucid for \
      OMZP::git \
      OMZP::gitignore \
      OMZP::gpg-agent \
      OMZP::kubectl \
      OMZP::pip \
      OMZP::ruby

    if [[ "${PLATFORM}" = "Darwin" ]]; then
        zinit wait lucid for OMZP::osx
    fi

    zinit wait lucid for \
      djui/alias-tips \
      hlissner/zsh-autopair \
      jreese/zsh-titles \
      atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
        zdharma/fast-syntax-highlighting \
      atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
      blockf \
        zsh-users/zsh-completions

    # [[theme]]
    zinit ice depth=1
    zinit light romkatv/powerlevel10k
fi

# [zsh] configuration about history
setopt histfindnodups histignorealldups histsavenodups

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
(hash bat 2> /dev/null) && alias cat="bat"
(hash dust 2> /dev/null) && alias du="dust"
(hash fd 2> /dev/null) && alias find="fd"
(hash rg 2> /dev/null) && alias grep="rg"
(hash exa 2> /dev/null) && alias ls="exa"
(hash prettyping 2> /dev/null) && alias ping="prettyping"
(hash fzf 2> /dev/null) && alias preview="fzf --preview 'bat --color \"always\" {}'"
(hash htop 2> /dev/null) && alias top="sudo htop"

# load starship prompt
# disable for now since it increase about 400ms to startup time
#(hash starship 2>/dev/null) && eval "$(starship init zsh)"

# [my] private configuration
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

# vim: set foldlevel=0 foldmethod=marker:
