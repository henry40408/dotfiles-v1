source "${HOME}/.antigen/antigen.zsh"

PLATFORM=`uname`

antigen use oh-my-zsh

antigen bundle brew
antigen bundle docker
antigen bundle gem
antigen bundle git
antigen bundle git-flow
antigen bundle gpg-agent
antigen bundle kubectl
antigen bundle nvm
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

export PATH="${HOME}/bin:$PATH"

if [[ -d "/usr/local/opt/python/libexec/bin" ]]; then
    export PATH="/usr/local/opt/python/libexec/bin:${PATH}"
fi

if [[ -d "${HOME}/go/bin" ]]; then
    export PATH="${HOME}/go/bin:${PATH}"
fi

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias git='hub'

BULLETTRAIN_DIR_EXTENDED=0
BULLETTRAIN_CONTEXT_DEFAULT_USER="$(whoami)"
BULLETTRAIN_EXEC_TIME_SHOW=1
BULLETTRAIN_GO_SHOW=1
BULLETTRAIN_NVM_SHOW=1
BULLETTRAIN_STATUS_EXIT_SHOW=1

antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

antigen apply

GOOGLE_CLOUD_SDK_DIR="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
if [[ -d "${GOOGLE_CLOUD_SDK_DIR}" ]]; then
    source "${GOOGLE_CLOUD_SDK_DIR}/path.zsh.inc"
    source "${GOOGLE_CLOUD_SDK_DIR}/completion.zsh.inc"
fi


if [[ -f "${HOME}/.local.zsh" ]]; then
    source "${HOME}/.local.zsh"
fi

# vim: set foldlevel=0 foldmethod=marker:
