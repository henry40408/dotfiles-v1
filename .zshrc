source "${HOME}/.antigen/antigen.zsh"

PLATFORM=`uname`

antigen use oh-my-zsh

antigen bundle ansible
antigen bundle docker
antigen bundle gem
antigen bundle git
antigen bundle git-flow
antigen bundle gpg-agent
antigen bundle kubectl
antigen bundle nvm
antigen bundle pip
antigen bundle rbenv
antigen bundle z

antigen bundle StackExchange/blackbox
antigen bundle jreese/zsh-titles
antigen bundle rimraf/k
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

if [[ "${PLATFORM}" = "Darwin" ]]; then
    antigen bundle osx
fi

# Additional executable files in $HOME/bin
export PATH="${HOME}/bin:$PATH"

# GVM: Go Version Manager
# oh-my-zsh does not support it for now
export GVM_DIR="${HOME}/.gvm"
[[ -d "${GVM_DIR}" ]] && . ${GVM_DIR}/scripts/gvm

# I put everything about Go in ${HOME}/go (a.k.a. $GOPATH),
# so Go executables should be found in ${HOME}/go/bin.
[[ -d "${HOME}/go/bin" ]] && export PATH="${HOME}/go/bin:${PATH}"

# # Aliases
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias git="hub"

# # Themes
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_TIME_SHOW=true

antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

antigen apply

# Enable auto-completion for Google Cloud SDK
GOOGLE_CLOUD_SDK_DIR="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
[[ -d "${GOOGLE_CLOUD_SDK_DIR}" ]] && \
    source "${GOOGLE_CLOUD_SDK_DIR}/path.zsh.inc" && \
    source "${GOOGLE_CLOUD_SDK_DIR}/completion.zsh.inc"

# Private configuration
[[ -f "${HOME}/.local.zsh" ]] && source "${HOME}/.local.zsh"

# vim: set foldlevel=0 foldmethod=marker:
