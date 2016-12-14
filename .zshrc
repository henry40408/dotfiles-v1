source ~/.zplug/init.zsh

PLATFORM=`uname`

# plugins {
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
# }

# environment variables {
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

  export PIP_REQUIRE_VIRTUALENV=1
# }

# aliases {
  alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
  alias emacs="emacs -nw"
  alias gfl="git-flow"
  alias ls="ls --color=auto"

  # neovim or vim
  if (type nvim > /dev/null); then
    alias vim="nvim"
  fi

  # pbcopy & pbpaste in Linux
  if [ "$PLATFORM" = "Linux" ] && (type xclip > /dev/null); then
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
  fi
# }

# version managers {
  # gvm
  export GVM_DIR="$HOME/.gvm"
  if [ -s "$GVM_DIR/scripts/gvm" ]; then
    . "$GVM_DIR/scripts/gvm"
  fi

  # nvm
  export NVM_DIR="$HOME/.nvm"
  if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"  # This loads nvm
  fi

  # rbenv
  export RBENV_DIR="$HOME/.rbenv"
  [ -d "$RBENV_DIR" ] && eval "$(rbenv init -)"
# }

# private configuration {
  if [ -f $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
  fi
# }

# theme {
  # bullet train configuration
  BULLETTRAIN_DIR_EXTENDED=0
  BULLETTRAIN_EXEC_TIME_SHOW=true
  BULLETTRAIN_STATUS_EXIT_SHOW=true
  [ -d "$GVM_DIR" ] && BULLETTRAIN_GO_SHOW=true
  [ -d "$NVM_DIR" ] && BULLETTRAIN_NVM_SHOW=true

  setopt prompt_subst
  zplug "caiogondim/bullet-train-oh-my-zsh-theme", as:theme
# }

zplug load

# vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
