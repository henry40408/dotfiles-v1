#!/usr/bin/env zsh

PLATFORM=`uname`

if (hash curl 2>/dev/null) && [[ ! -f "${HOME}/.antigen/antigen.zsh" ]]; then
    # automatically install antigen if not exists
    echo "No antigen detected. Install now..."
    mkdir -p "${HOME}/.antigen"
    /usr/bin/env curl -L git.io/antigen > .antigen/antigen.zsh
    echo "Done."
fi

if [[ ! -d "${HOME}/.asdf" ]]; then
    # automatically install asdf if not exists
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.7.3
fi

if [[ -f "${HOME}/.antigen/antigen.zsh" ]]; then
    source "${HOME}/.antigen/antigen.zsh"

    # [[plugins]]

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
    antigen bundle rails
    antigen bundle ruby

    # faster alternative to pyenv plugin in oh-my-zsh
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

    # [[theme]]
    # POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
    # POWERLEVEL9K_MODE="nerdfont-complete"
    # POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
    # POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    # POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time nvm pyenv rbenv time)
    # POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
    # POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
    # antigen theme bhilburn/powerlevel9k powerlevel9k
    antigen theme ys

    antigen apply
fi

# [zsh] configuration about history
setopt histfindnodups
setopt histignorealldups
setopt histsavenodups

# [homebrew] extra PATH
export PATH="/usr/local/sbin:${PATH}"

# [my] per-user executable
export PATH="${HOME}/bin:${PATH}"

# [python] no packages should be installed outside pip
export PIP_REQUIRE_VIRTUALENV=1

# [golang] golang executables
export PATH="${HOME}/go/bin:${PATH}"

# [[aliases]]

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"

# https://gist.github.com/bbengfort/246bc820e76b48f71df7
alias workon="source venv/bin/activate"

# https://remysharp.com/2018/08/23/cli-improved
alias cat="bat"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help="tldr"
alias ls="exa"
alias ping="prettyping"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias top="sudo htop"

# [nvm]
# since nvm plugin in oh-my-zsh does not accept arguments
# initialize nvm manually to apply --no-use
# reference: https://git.io/fhH7l
[[ -z "$NVM_DIR" ]] && export NVM_DIR="$HOME/.nvm"
[[ -f "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use

# [asdf] https://asdf-vm.com/#/core-manage-asdf-vm
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# [my] private configuration
if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi

# vim: set foldlevel=0 foldmethod=marker:
