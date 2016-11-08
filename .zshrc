source $HOME/.antigen/antigen.zsh

# bullet train configuration
BULLETTRAIN_DIR_EXTENDED=0
BULLETTRAIN_EXEC_TIME_SHOW=true
BULLETTRAIN_NVM_SHOW=true
BULLETTRAIN_STATUS_EXIT_SHOW=true

# plugins
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  MikeDacre/cdbk
  autojump
  common-aliases
  docker
  gem
  git
  git-flow
  jreese/zsh-titles
  pip
  rimraf/k
  vagrant
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

if [ "$OSTYPE"="darwin15.0" ]; then
  antigen bundles <<EOBUNDLES
    brew
    brew-cask
    osx
EOBUNDLES
fi

# theme
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train
antigen apply

# environment variables
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# aliases
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ls='ls --color=auto'

# neovim or vim
if type nvim 2> /dev/null; then
  alias vim='nvim'
fi

# pbcopy & pbpaste in Linux
if type xclip 2> /dev/null; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# rbenv
export RBENV_DIR="$HOME/.rbenv"
export PATH="$RBENV_DIR/bin:$PATH"
[ -s "$RBENV_DIR/scripts/rbenv" ] && eval "$(rbenv init -)"

# private configuration
if [ -f $HOME/.zshrc-local ]; then
  source $HOME/.zshrc-local
fi
