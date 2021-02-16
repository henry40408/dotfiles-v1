#!/usr/bin/env zsh

_install_asdf() {
    echo "==> install asdf"
    git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.0
    echo "==> asdf installed"
}

_install_tpm() {
    echo "==> install tpm"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm --branch v3.0.0
    echo "==> tpm installed"
}

_install_vim_plug() {
    echo "==> install vim-plug"

    if [[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]]; then
        echo "==> vim-plug installed. remove ${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim to re-install. abort."
        return 1
    fi

    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
      --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "==> vim-plug installed"
}

_install_zinit() {
    echo "==> install zinit"
    git clone https://github.com/zdharma/zinit.git "$HOME/.zinit/bin"
    echo "==> zinit installed"
}

benchmark() {
    for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c "exit"; done
}

decrypt() {
    eval "$(secrets decrypt environment)"
}

reload() {
    exec zsh
}

restore() {
    pushd $HOME/.cfg
    stow $(ls -d */)
    popd
}

setup() {
    _install_zinit
    _install_asdf
    _install_vim_plug
    _install_tpm
}

if [[ -f "$HOME/.zinit/bin/zinit.zsh" ]]; then
    source "$HOME/.zinit/bin/zinit.zsh"

    # [[plugins]]

    # ref: https://github.com/asdf-vm/asdf/issues/692
    autoload -U +X bashcompinit && bashcompinit

    # avoid conflict of "ls" command
    export DISABLE_LS_COLORS=true

    zinit wait lucid for \
      OMZL::functions.zsh \
      OMZL::clipboard.zsh \
      OMZL::compfix.zsh \
      OMZL::completion.zsh \
      OMZL::correction.zsh \
      OMZL::directories.zsh \
      OMZL::git.zsh \
      OMZL::history.zsh \
      OMZL::key-bindings.zsh \
      OMZL::misc.zsh \
      OMZL::prompt_info_functions.zsh \
      OMZL::termsupport.zsh \
      OMZL::theme-and-appearance.zsh \
      OMZP::asdf \
      if"[[ $OSTYPE = *darwin* ]]" OMZP::brew \
      OMZP::command-not-found \
      OMZP::common-aliases \
      OMZP::docker-compose \
      OMZP::fzf \
      OMZP::gem \
      OMZP::git \
      OMZP::gitignore \
      OMZP::gpg-agent \
      OMZP::pip \
      OMZP::ruby

    zinit wait lucid as"completion" for \
      OMZP::docker/_docker

    zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
      zsh-users/zsh-completions

    export YSU_HARDCORE=1

    zinit wait lucid for \
      MichaelAquilina/zsh-auto-notify \
      MichaelAquilina/zsh-you-should-use \
      chuwy/zsh-secrets \
      hlissner/zsh-autopair \
      jreese/zsh-titles \
      zdharma/fast-syntax-highlighting \
      zsh-users/zsh-autosuggestions

    # fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets,
    # such as zsh-autosuggestions or fast-syntax-highlighting!!
    zinit wait lucid for \
      Aloxaf/fzf-tab

    # ref: https://remysharp.com/2018/08/23/cli-improved
    zinit wait lucid as"program" from"gh-r" for \
      ver"0.13.0" BurntSushi/xsv \
      ver"0.19.0" mv"lsd-*/lsd -> lsd" atload"alias ls='lsd'" Peltoche/lsd \
      ver"v0.5.0" mv"zoxide-* -> zoxide" pick"zoxide" atload'eval "$(zoxide init zsh)"' ajeetdsouza/zoxide \
      ver"v0.5.4" mv"dust-*/dust -> dust" atload"alias du='dust'" bootandy/dust

    if [[ "$OSTYPE" = "*darwin*" ]]; then
      declare procs_bpick="*-mac*"
    else
      declare procs_bpick="*-lnx*"
    fi
    zinit ice as"program" from"gh-r" ver"v0.11.3" bpick"$procs_bpick" atload"alias ps='procs'"
    zinit light dalance/procs

    zinit wait lucid as"program" for \
      ver"748a7db" denilsonsa/prettyping

    # [[theme]]
    zinit ice depth"1" atload"source $HOME/.p10k.zsh"
    zinit load romkatv/powerlevel10k
fi

# [zsh] configuration about history
setopt histfindnodups histignorealldups histignorespace histsavenodups

# [homebrew] configuration
export PATH="/usr/local/sbin:$PATH"

# [my] per-user executable
export PATH="$HOME/bin:$PATH"

# [python] no packages should be installed outside pip
export PIP_REQUIRE_VIRTUALENV=1

# [tmuxifier]
export PATH="$HOME/.tmuxifier/bin:$PATH"

# [[aliases]]

# ref: https://remysharp.com/2018/08/23/cli-improved
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[fzf] )) && alias preview="fzf --preview 'bat --color \"always\" {}'"
(( $+commands[prettyping] )) && alias ping="prettyping"
(( $+commands[tmuxifier] )) && eval "$(tmuxifier init -)"

# [my] private configuration
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local" || true

# vim: set foldlevel=0 foldmethod=marker:
