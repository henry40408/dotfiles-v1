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
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf --branch v0.7.7
fi

if [[ -f "${HOME}/.antigen/antigen.zsh" ]]; then
    source "${HOME}/.antigen/antigen.zsh"

    # [[plugins]]

    antigen use oh-my-zsh

    antigen bundle ansible
    antigen bundle asdf
    antigen bundle docker
    antigen bundle fzf
    antigen bundle gem
    antigen bundle git
    antigen bundle gitignore
    antigen bundle gpg-agent
    antigen bundle kubectl
    antigen bundle pip
    antigen bundle rails
    antigen bundle ruby

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

# [zoxide]
if (hash zoxide 2> /dev/null); then
    eval "$(zoxide init zsh)"
fi

# [[aliases]]

# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config="/usr/bin/git --git-dir=${HOME}/.cfg --work-tree=${HOME}"

# https://gist.github.com/bbengfort/246bc820e76b48f71df7
alias workon="source venv/bin/activate"

# https://remysharp.com/2018/08/23/cli-improved
alias cat="bat"
alias du="dust"
alias find="fd"
alias grep="rg"
alias ls="exa"
alias ping="prettyping"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias top="sudo htop"

# load starship prompt
if (hash starship 2>/dev/null); then
    eval "$(starship init zsh)"
fi

# [my] private configuration
if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi

# vim: set foldlevel=0 foldmethod=marker:
