source "${HOME}/.antigen/antigen.zsh"

PLATFORM=`uname`

antigen use oh-my-zsh

antigen bundle ansible
antigen bundle autojump
antigen bundle docker
antigen bundle gem
antigen bundle git
antigen bundle git-flow
antigen bundle gpg-agent
antigen bundle nvm
antigen bundle pip
antigen bundle pyenv
antigen bundle rbenv

antigen bundle djui/alias-tips
antigen bundle jreese/zsh-titles
antigen bundle Cloudstek/zsh-plugin-appup
antigen bundle StackExchange/blackbox
antigen bundle supercrabtree/k
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

if [[ "${PLATFORM}" = "Darwin" ]]; then
    antigen bundle osx
fi

# Additional executable files in $HOME/bin
export PATH="${HOME}/bin:$PATH"

# GVM: Go Version Manager
# oh-my-zsh does not support it for now
GVM_DIR="${HOME}/.gvm"
if [[ -d "${GVM_DIR}" ]]; then
    source ${GVM_DIR}/scripts/gvm;
fi

# I put everything about Go in ${HOME}/go (a.k.a. $GOPATH),
# so Go executables should be found in ${HOME}/go/bin.
if [[ -d "${HOME}/go/bin" ]]; then
    export PATH="${HOME}/go/bin:${PATH}";
fi

# Aliases
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Themes
SPACESHIP_BATTERY_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_KUBECONTEXT_SHOW=false
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_TIME_SHOW=true

antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

# Prevent pip install outside virtualenvs
export PIP_REQUIRE_VIRTUALENV=1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if which pyenv-virtualenv-init > /dev/null; then
    eval "$(pyenv virtualenv-init -)";
fi

antigen apply

# Private configuration
if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local";
fi

# vim: set foldlevel=0 foldmethod=marker:
