source "${HOME}/.zgen/zgen.zsh"

# start of .zshrc

PLATFORM=`uname`

if ! zgen saved; then
    # plugins {{{
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/common-aliases
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/gem
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/git-flow
    zgen oh-my-zsh plugins/gpg-agent
    zgen oh-my-zsh plugins/kubectl
    zgen oh-my-zsh plugins/nvm
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/pyenv
    zgen oh-my-zsh plugins/rbenv
    zgen oh-my-zsh plugins/virtualenvwrapper
    zgen oh-my-zsh plugins/z

    zgen load Sparragus/zsh-auto-nvm-use
    zgen load StackExchange/blackbox
    zgen load jreese/zsh-titles
    zgen load rimraf/k
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions

    if [[ "${PLATFORM}" = "Darwin" ]]; then
        zgen oh-my-zsh plugins/osx
    fi
    # }}}

    # theme {{{
    BULLETTRAIN_DIR_EXTENDED=0
    BULLETTRAIN_CONTEXT_DEFAULT_USER="$(whoami)"
    BULLETTRAIN_EXEC_TIME_SHOW=1
    BULLETTRAIN_GO_SHOW=1
    BULLETTRAIN_NVM_SHOW=1
    BULLETTRAIN_STATUS_EXIT_SHOW=1
    ZSH_THEME="bullet-train"

    zgen load caiogondim/bullet-train-oh-my-zsh-theme bullet-train
    # }}}

    zgen save
fi

# aliases {{{
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# }}}

# environment variables {{{
if [[ "${PLATFORM}" = "Darwin" ]]; then
    export EDITOR="vim"
    export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
fi
# }}}

# version managers which are not supported by oh-my-zsh {{{
# elixir {{{
export KIEX_DIR="${HOME}/.kiex"
[ -s "${KIEX_DIR}/scripts/kiex" ] && source "${KIEX_DIR}/scripts/kiex"
# }}}

# gvm {{{
export GVM_DIR="${HOME}/.gvm"
[ -s "${GVM_DIR}/scripts/gvm" ] && source "${GVM_DIR}/scripts/gvm"
# }}}
# }}}

# private configuration {{{
if [ -f "${HOME}/.zshrc-local" ]; then
    source "${HOME}/.zshrc-local"
fi
# }}}

# end of .zshrc

# vim: set foldlevel=0 foldmethod=marker:
