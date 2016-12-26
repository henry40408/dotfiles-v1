source ~/.zplug/init.zsh

PLATFORM=`uname`

# plugins
zplug "robbyrussell/oh-my-zsh"

zplug "plugins/autojump", from:oh-my-zsh
zplug "plugins/common-aliases", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/gem", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/git-flow", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh

zplug "StackExchange/blackbox"
zplug "jreese/zsh-titles"
zplug "rimraf/k"
zplug "zsh-users/zsh-syntax-highlighting"

if [ "$PLATFORM" = "Darwin" ]; then
    zplug "plugins/osx", from:oh-my-zsh
fi

# environment variables
if [ "$PLATFORM" = "Darwin" ]; then
    [ -f "/usr/local/bin/nvim" ] && export EDITOR="/usr/local/bin/nvim"
    [ -f "/usr/local/bin/vim" ] && export EDITOR="/usr/local/bin/vim"

    export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"

    # for `coreutils`
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

if [ "$PLATFORM" = "Linux" ]; then
    [ -f "/usr/bin/nvim" ] && export EDITOR="/usr/bin/nvim"
    [ -f "/usr/bin/vim" ] && export EDITOR="/usr/bin/vim"
fi

# aliases
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias emacs="emacs -nw"
alias gfl="git-flow"
alias ls="ls --color=auto"

# neovim or vim
if command -v nvim > /dev/null; then
    alias vim="nvim"
fi

# pbcopy & pbpaste in Linux
if [ "$PLATFORM" = "Linux" ] && (command -v xclip); then
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
fi

# version managers

## gvm
export GVM_DIR="$HOME/.gvm"
[ -s "$GVM_DIR/scripts/gvm" ] && . "$GVM_DIR/scripts/gvm"

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

## rbenv
export RBENV_DIR="$HOME/.rbenv"
[ -d "$RBENV_DIR" ] && eval "$(rbenv init -)"

# python virtualenv
if command -v virtualenvwrapper.sh > /dev/null; then
    source $(command -v virtualenvwrapper.sh)
    export PIP_REQUIRE_VIRTUALENV=1
fi

# private configuration
[ -f $HOME/.zshrc-local ] && . $HOME/.zshrc-local

# theme
BULLETTRAIN_DIR_EXTENDED=0
BULLETTRAIN_EXEC_TIME_SHOW=true
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_GO_SHOW=true
BULLETTRAIN_NVM_SHOW=true

setopt prompt_subst
zplug "caiogondim/bullet-train-oh-my-zsh-theme", as:theme

# end of .zshrc

if ! zplug check; then
  zplug install
fi

zplug load

# vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
