source $HOME/.antigen/antigen.zsh

PLATFORM=`uname`

# plugins {
  antigen use oh-my-zsh

  antigen bundles <<EOBUNDLES
    autojump
    common-aliases
    docker
    gem
    git
    git-flow
    kubectl
    pip
    vagrant

    StackExchange/blackbox
    jreese/zsh-titles
    rimraf/k
    voronkovich/gitignore.plugin.zsh
    zsh-users/zsh-completions
    zsh-users/zsh-syntax-highlighting
EOBUNDLES

  if [ "$PLATFORM" = "Darwin" ]; then
    antigen bundles <<EOBUNDLES
      brew
      brew-cask
      osx
EOBUNDLES
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
  export PATH="$RBENV_DIR/bin:$PATH"
  if [ -s "$RBENV_DIR/scripts/rbenv" ]; then
    eval "$(rbenv init -)"
  fi
# }

# theme {
  THEME="https://github.com/caiogondim/bullet-train-oh-my-zsh-theme"

  # bullet train configuration
  BULLETTRAIN_DIR_EXTENDED=0
  BULLETTRAIN_EXEC_TIME_SHOW=true
  BULLETTRAIN_STATUS_EXIT_SHOW=true
  [ -d "$GVM_DIR" ] && BULLETTRAIN_GO_SHOW=true
  [ -d "$NVM_DIR" ] && BULLETTRAIN_NVM_SHOW=true

  antigen theme $THEME bullet-train
  antigen apply
# }

# private configuration {
  if [ -f $HOME/.zshrc-local ]; then
    source $HOME/.zshrc-local
  fi
# }

# vim: set foldmarker={,} foldlevel=0 foldmethod=marker:
