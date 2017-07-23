source "${HOME}/.zplug/init.zsh"

# start of .zshrc

PLATFORM=`uname`

# plugins {{{
    zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

    zplug "plugins/autojump", from:oh-my-zsh
    zplug "plugins/common-aliases", from:oh-my-zsh
    zplug "plugins/docker", from:oh-my-zsh
    zplug "plugins/gem", from:oh-my-zsh
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/git-flow", from:oh-my-zsh
    zplug "plugins/gpg-agent", from:oh-my-zsh
    zplug "plugins/kubectl", from:oh-my-zsh
    zplug "plugins/pip", from:oh-my-zsh
    zplug "plugins/virtualenvwrapper", from:oh-my-zsh

    zplug "Sparragus/zsh-auto-nvm-use"
    zplug "StackExchange/blackbox"
    zplug "jreese/zsh-titles"
    zplug "rimraf/k"
    zplug "zsh-users/zsh-syntax-highlighting"
    zplug "zsh-users/zsh-autosuggestions"

    if [ "${PLATFORM}" = "Darwin" ]; then
        zplug "plugins/osx", from:oh-my-zsh
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
    BULLETTRAIN_CONTEXT_DEFAULT_USER="$(whoami)"
    BULLETTRAIN_EXEC_TIME_SHOW=true
    BULLETTRAIN_GO_SHOW=true
    BULLETTRAIN_NVM_SHOW=true
    BULLETTRAIN_STATUS_EXIT_SHOW=true

    zplug "caiogondim/bullet-train-oh-my-zsh-theme", as:theme
# }}}

# private configuration {{{
    if [ -f "${HOME}/.zshrc-local" ]; then
        source "${HOME}/.zshrc-local"
    fi
# }}}

# end of .zshrc

if ! zplug check; then
    zplug install
fi

zplug load

# vim: set foldlevel=0 foldmethod=marker:
