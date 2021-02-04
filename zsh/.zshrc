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

_install_zinit() {
    echo "==> install zinit"
    git clone https://github.com/zdharma/zinit.git "${HOME}/.zinit/bin"
    echo "==> zinit installed"
}

benchmark() {
    for i ({1..3}) time zsh -ilc "exit"
}

reload() {
    exec zsh
}

restore() {
    pushd ${HOME}/.cfg
    stow $(ls -d */)
    popd
}

setup() {
    _install_zinit
    _install_asdf
    _install_vim_plug
    _install_tpm
}

if [[ -f "${HOME}/.zinit/bin/zinit.zsh" ]]; then
    source "${HOME}/.zinit/bin/zinit.zsh"

    # [[plugins]]

    # ref: https://github.com/asdf-vm/asdf/issues/692
    autoload -U +X bashcompinit && bashcompinit

    zinit for \
      OMZL::functions.zsh \
      OMZL::clipboard.zsh \
      OMZL::compfix.zsh \
      OMZL::completion.zsh \
      OMZL::correction.zsh \
      OMZL::directories.zsh \
      OMZL::git.zsh \
      OMZL::history.zsh \
      OMZL::key-bindings.zsh \
      OMZL::misc.zsh \
      OMZL::prompt_info_functions.zsh \
      OMZL::termsupport.zsh \
      OMZL::theme-and-appearance.zsh

    zinit for \
      OMZP::asdf \
      OMZP::command-not-found \
      OMZP::docker-compose \
      OMZP::fzf \
      OMZP::gem \
      OMZP::git \
      OMZP::gitignore \
      OMZP::gpg-agent \
      OMZP::pip \
      OMZP::ruby

    zinit as"completion" for \
      OMZP::docker/_docker \
      zsh-users/zsh-completions

    export YSU_HARDCORE=1

    zinit for \
      MichaelAquilina/zsh-auto-notify \
      MichaelAquilina/zsh-you-should-use \
      hlissner/zsh-autopair \
      jreese/zsh-titles \
      zdharma/fast-syntax-highlighting \
      zsh-users/zsh-autosuggestions

    zinit as"program" from"gh-r" for \
      ver"0.13.0" BurntSushi/xsv \
      ver"0.19.0" Peltoche/lsd \
      ver"v0.5.0" ajeetdsouza/zoxide \
      ver"v0.5.4" bootandy/dust \
      ver"v0.11.3" dalance/procs

    # [[theme]]
    if [[ -f "${HOME}/.p10k.zsh" ]]; then
        source "${HOME}/.p10k.zsh"
        zinit load romkatv/powerlevel10k
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
