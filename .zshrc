#!/usr/bin/env zsh

if [[ ! -f "${HOME}/.antigen/antigen.zsh" ]]; then
    # I am tired of manually install antigen
    # before everytime I recover my environment
    echo "No antigen detected. Install now..."
    mkdir -p "${HOME}/.antigen"
    curl -L git.io/antigen > .antigen/antigen.zsh
    echo "Done."
fi

if [[ ! -d "${HOME}/.tmux" ]]; then
    echo "No tmux configuration is install. Install now..."
    git clone https://github.com/gpakosz/.tmux .tmux
    ln -s -f .tmux/.tmux.conf
    echo "Done."
fi

if [[ -f "${HOME}/.antigen/antigen.zsh" ]]; then
    source "${HOME}/.antigen/antigen.zsh"

    PLATFORM=`uname`

    # plugins

    antigen use oh-my-zsh

    antigen bundle ansible
    antigen bundle autojump
    antigen bundle docker
    antigen bundle gem
    antigen bundle git
    antigen bundle git-flow
    antigen bundle gpg-agent
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

    # theme

    POWERLEVEL9K_INSTALLATION_PATH=${ANTIGEN_BUNDLES}/bhilburn/powerlevel9k

    POWERLEVEL9K_MODE="nerdfont-complete"

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time nvm pyenv rbenv time)
    POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
    POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last

    antigen theme bhilburn/powerlevel9k powerlevel9k

    antigen apply
fi

# shell configuration

HISTCONTROL=ignorespace:erasedups

# directory for user-wide executable files

export PATH="${HOME}/bin:$PATH"

# python - no packages should be installed outside pip

export PIP_REQUIRE_VIRTUALENV=1

# gvm - Go version manager

export GVM_DIR="${HOME}/.gvm"
if [[ -d "${GVM_DIR}" ]]; then
    source ${GVM_DIR}/scripts/gvm
fi
if [[ -d "${HOME}/go/bin" ]]; then
    # ${HOME}/go is the default value for GOPATH,
    # so Go executables should be found in ${HOME}/go/bin.
    export PATH="${HOME}/go/bin:${PATH}"
fi

# nvm - Node.js version manager

if [[ -d "${HOME}/.nvm" ]]; then
    export NVM_DIR="${HOME}/.nvm"
    source "${HOME}/.nvm/nvm.sh" --no-use
fi

# tmuxifier

if [[ -d "${HOME}/.tmuxifier" ]]; then
    export PATH="${HOME}/.tmuxifier/bin:${PATH}"
    eval "$(tmuxifier init -)"
fi

# aliases

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# https://gist.github.com/bbengfort/246bc820e76b48f71df7
alias workon="source venv/bin/activate"

# fzf - fuzzy finder

if [[ -f "${HOME}/.fzf.zsh" ]]; then
    source "${HOME}/.fzf.zsh"
fi

# private configuration

if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi

# vim: set foldlevel=0 foldmethod=marker:
