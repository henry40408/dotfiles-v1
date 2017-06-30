source "${HOME}/.antigen/antigen.zsh"

# start of .zshrc

PLATFORM=`uname`

# plugins {{{
    antigen use oh-my-zsh

    antigen bundle autojump
    antigen bundle common-aliases
    antigen bundle docker
    antigen bundle gem
    antigen bundle git
    antigen bundle git-flow
    antigen bundle gpg-agent
    antigen bundle pip
    antigen bundle virtualenvwrapper

    antigen bundle StackExchange/blackbox
    antigen bundle jreese/zsh-titles
    antigen bundle rimraf/k
    antigen bundle zsh-users/zsh-syntax-highlighting

    if [ "${PLATFORM}" = "Darwin" ]; then
        antigen bundle osx
    fi
# }}}

# aliases {{{
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    alias gprd="git log HEAD...develop --pretty='format:- %h **%s**'"
    alias gprm="git log HEAD...master --pretty='format:- %h **%s**'"
# }}}

# environment variables {{{
    if [ "${PLATFORM}" = "Darwin" ]; then
        export EDITOR="vim"
        export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:${PATH}"
    fi
# }}}

# version managers and virtual environment {{{
    # elixir {{{
        export KIEX_DIR="${HOME}/.kiex"
        if [ -s "${KIEX_DIR}/scripts/kiex" ]; then
            source "${KIEX_DIR}/scripts/kiex"
        fi
    # }}}

    # gvm {{{
        export GVM_DIR="${HOME}/.gvm"
        if [ -s "${GVM_DIR}/scripts/gvm" ]; then
            source "${GVM_DIR}/scripts/gvm"
        fi
    # }}}

    # nvm {{{
        export NVM_DIR="${HOME}/.nvm"
        if [ -s "${NVM_DIR}/nvm.sh" ]; then
            source "${NVM_DIR}/nvm.sh"
            antigen bundle henry40408/zsh-auto-nvm-use
        fi
    # }}}

    # rbenv {{{
        export RBENV_DIR="${HOME}/.rbenv"
        export PATH="${RBENV_DIR}/bin:$PATH"
        if [ -d "${RBENV_DIR}" ]; then
            eval "$(rbenv init -)"
        fi
    # }}}
# }}}

# theme {{{
    BULLETTRAIN_DIR_EXTENDED=0
    BULLETTRAIN_CONTEXT_DEFAULT_USER=$(whoami)
    BULLETTRAIN_EXEC_TIME_SHOW=true
    BULLETTRAIN_GO_SHOW=true
    BULLETTRAIN_NVM_SHOW=true
    BULLETTRAIN_STATUS_EXIT_SHOW=true

    antigen theme caiogondim/bullet-train-oh-my-zsh-theme
# }}}

# private configuration {{{
    if [ -f $HOME/.zshrc-local ]; then
        source $HOME/.zshrc-local
    fi
# }}}

# end of .zshrc

antigen apply

# vim: set foldlevel=0 foldmethod=marker:
