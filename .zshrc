#!/usr/bin/env zsh

if (hash curl 2>/dev/null) && [[ ! -f "${HOME}/.antigen/antigen.zsh" ]]; then
    # I am tired of manually install antigen
    # before everytime I recover my environment
    echo "No antigen detected. Install now..."
    mkdir -p "${HOME}/.antigen"
    /usr/bin/env curl -L git.io/antigen > .antigen/antigen.zsh
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
    antigen bundle fzf
    antigen bundle gem
    antigen bundle git
    antigen bundle gitignore
    antigen bundle gpg-agent
    antigen bundle pip

    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    antigen bundle davidparsson/zsh-pyenv-lazy

    antigen bundle djui/alias-tips
    antigen bundle jreese/zsh-titles
    antigen bundle Cloudstek/zsh-plugin-appup
    antigen bundle StackExchange/blackbox
    antigen bundle zdharma/fast-syntax-highlighting
    antigen bundle zsh-users/zsh-autosuggestions

    if [[ "${PLATFORM}" = "Darwin" ]]; then
        antigen bundle osx
    fi

    # theme
    antigen theme ys

    antigen apply
fi

# shell configuration about history
setopt histfindnodups
setopt histignorealldups
setopt histsavenodups

# directory for user-wide executable files
export PATH="${HOME}/bin:${PATH}"

# suggestion from homebrew
export PATH="/usr/local/sbin:${PATH}"

# python - no packages should be installed outside pip
export PIP_REQUIRE_VIRTUALENV=1

# gvm - Go version manager
export GVM_DIR="${HOME}/.gvm"
if [[ -d "${GVM_DIR}" ]]; then
    source ${GVM_DIR}/scripts/gvm
fi

# aliases

alias ls="exa"

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"

# https://gist.github.com/bbengfort/246bc820e76b48f71df7
alias workon="source venv/bin/activate"

# https://remysharp.com/2018/08/23/cli-improved
alias cat="bat"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help="tldr"
alias ping="prettyping"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias top="sudo htop"

# since nvm plugin in oh-my-zsh does not accept arguments
# initialize nvm manually to apply --no-use
# reference: https://git.io/fhH7l
[[ -z "$NVM_DIR" ]] && export NVM_DIR="$HOME/.nvm"
[[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use

# https://carlosbecker.com/posts/speeding-up-zsh/
rbenv() {
  eval "$(command rbenv init -)"
  rbenv "$@"
}

# https://git.io/fhH7R
function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi

    command kubectl "$@"
}

# private configuration
if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi

# vim: set foldlevel=0 foldmethod=marker:
