source "${HOME}/.antigen/antigen.zsh"

PLATFORM=`uname`

antigen use oh-my-zsh

antigen bundle asdf
antigen bundle autojump
antigen bundle docker
antigen bundle gem
antigen bundle git
antigen bundle git-flow
antigen bundle gpg-agent
antigen bundle kubectl
antigen bundle pip
antigen bundle z

antigen bundle StackExchange/blackbox
antigen bundle jreese/zsh-titles
antigen bundle rimraf/k
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

if [[ "${PLATFORM}" = "Darwin" ]]; then
    antigen bundle osx
fi

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

BULLETTRAIN_DIR_EXTENDED=0
BULLETTRAIN_CONTEXT_DEFAULT_USER="$(whoami)"
BULLETTRAIN_EXEC_TIME_SHOW=1
BULLETTRAIN_GO_SHOW=1
BULLETTRAIN_NVM_SHOW=1
BULLETTRAIN_STATUS_EXIT_SHOW=1

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen apply

if [[ -f "${HOME}/.local.zsh" ]]; then
    source "${HOME}/.local.zsh"
fi

# vim: set foldlevel=0 foldmethod=marker:
