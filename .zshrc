source "${HOME}/.zplug/init.zsh"

PLATFORM=`uname`

# plugins
zplug "robbyrussell/oh-my-zsh", use:"lib/clipboard.zsh;lib/completion.zsh;lib/git.zsh;lib/grep.zsh;lib/history.zsh;lib/key-bindings.zsh;lib/nvm.sh"

zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-flow", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh

zplug "Sparragus/zsh-auto-nvm-use"
zplug "StackExchange/blackbox"
zplug "jreese/zsh-titles"
zplug "rimraf/k"
zplug "zsh-users/zsh-syntax-highlighting"

if [ "$PLATFORM" = "Darwin" ]; then
    zplug "plugins/osx", from:oh-my-zsh
fi

# environment variables
if [ "$PLATFORM" = "Darwin" ]; then
    if [ -f "/usr/local/bin/nvim" ]; then
        export EDITOR="/usr/local/bin/nvim"
    fi

    if [ -f "/usr/local/bin/vim" ]; then
        export EDITOR="/usr/local/bin/vim"
    fi

    export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

    # for `coreutils`
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

if [ "$PLATFORM" = "Linux" ]; then
    if [ -f "/usr/bin/nvim" ]; then
        export EDITOR="/usr/bin/nvim"
    fi

    if [ -f "/usr/bin/vim" ]; then
        export EDITOR="/usr/bin/vim"
    fi
fi

# aliases
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias gfl="git-flow"
alias ls="ls --color=auto"
alias mux="tmuxinator"

# neovim or vim
if (command -v nvim > /dev/null); then
    alias vim="nvim"
fi

# version managers

## gvm
export GVM_DIR="$HOME/.gvm"
if [ -s "$GVM_DIR/scripts/gvm" ]; then
    . "$GVM_DIR/scripts/gvm"
fi

## rbenv
export RBENV_DIR="$HOME/.rbenv"
if [ -d "$RBENV_DIR" ]; then
    eval "$(rbenv init -)"
fi

# python virtualenv
if (command -v virtualenvwrapper.sh > /dev/null); then
    source $(command -v virtualenvwrapper.sh)
    export PIP_REQUIRE_VIRTUALENV=1
fi

if [ -f $HOME/.tmuxinator/tmuxinator.zsh ]; then
    source $HOME/.tmuxinator/tmuxinator.zsh
fi

# private configuration
if [ -f $HOME/.zshrc-local ]; then
    . $HOME/.zshrc-local
fi

# theme
BULLETTRAIN_DIR_EXTENDED=0
BULLETTRAIN_EXEC_TIME_SHOW=true
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_GO_SHOW=true
BULLETTRAIN_NVM_SHOW=true

zplug "caiogondim/bullet-train-oh-my-zsh-theme", as:theme

# end of .zshrc

if ! zplug check; then
  zplug install
fi

zplug load

# vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
