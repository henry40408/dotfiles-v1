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

check() {
    file $(which direnv)
    file $(which xsv)
    file $(which lsd)
    file $(which tokei)
    file $(which zoxide)
    file $(which dust)
    file $(which procs)
    file $(which puma-dev)
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

    # synchronously load the following libraries / plugins
    zinit for \
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
      atload"DISABLE_LS_COLORS=true" OMZL::theme-and-appearance.zsh \
      OMZP::asdf \
      zsh-users/zsh-autosuggestions

    # asynchronously load the following libraries / plugins
    zinit wait lucid for \
      if"[[ $OSTYPE = *darwin* ]]" OMZP::brew \
      OMZP::command-not-found \
      OMZP::common-aliases \
      OMZP::docker-compose \
      OMZP::fzf \
      OMZP::gem \
      OMZP::git \
      OMZP::golang \
      OMZP::gitignore \
      OMZP::gpg-agent \
      OMZP::helm \
      OMZP::kubectl \
      atload"PIP_REQUIRE_VIRTUALENV=1" OMZP::pip \
      OMZP::python \
      OMZP::ruby \
      OMZP::rails \
      OMZP::virtualenvwrapper

    zinit wait lucid as"completion" for \
      OMZP::docker/_docker \
      OMZP::rails/_rails

    zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
      zsh-users/zsh-completions

    zinit wait lucid for \
      if"(( $+commands[notify-send] ))" MichaelAquilina/zsh-auto-notify \
      atload"YSU_HARDCORE=1" MichaelAquilina/zsh-you-should-use \
      chuwy/zsh-secrets \
      hlissner/zsh-autopair \
      jreese/zsh-titles \
      zdharma/fast-syntax-highlighting

    # fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets,
    # such as zsh-autosuggestions or fast-syntax-highlighting!!
    zinit wait lucid for \
      Aloxaf/fzf-tab

    # ref: https://remysharp.com/2018/08/23/cli-improved
    zinit as"program" from"gh-r" for \
      ver"v2.28.0" mv"direnv* -> direnv" atload'eval "$(direnv hook zsh)"' direnv/direnv

    if [[ $OSTYPE = *darwin* ]]; then
        local procs_bpick="*-mac*" \
          tokei_bpick="*-x86_64-apple-darwin*"
    else
        local procs_bpick="*-lnx*" \
          tokei_bpick="*-x86_64-unknown-linux-gnu*"
    fi

    zinit wait"2" lucid as"program" from"gh-r" for \
      ver"0.13.0" BurntSushi/xsv \
      ver"0.20.1" mv"lsd-*/lsd -> lsd" atload"alias ls='lsd'" Peltoche/lsd \
      ver"v12.1.2" bpick"$tokei_bpick" XAMPPRocky/tokei \
      ver"v0.5.0" mv"zoxide-* -> zoxide" pick"zoxide" atload'eval "$(zoxide init zsh)"' ajeetdsouza/zoxide \
      ver"v0.5.4" mv"dust-*/dust -> dust" atload"alias du='dust'" bootandy/dust \
      ver"v0.11.3" bpick"$procs_bpick" atload"alias ps='procs'" dalance/procs \
      ver"v0.16.1" puma/puma-dev

    zinit wait"2" lucid as"program" for \
      ver"748a7db" atload"alias ping='prettyping'" denilsonsa/prettyping

    # [[theme]]
    zinit ice depth"1" atload"source $HOME/.p10k.zsh"
    zinit load romkatv/powerlevel10k
fi

# [zsh] configuration about history
setopt histfindnodups histignorealldups histignorespace histsavenodups

# [tmuxifier]
[[ -d "$HOME/.tmuxifier" ]] && eval "$($HOME/.tmuxifier/bin/tmuxifier init -)"

# [[aliases]]

# ref: https://remysharp.com/2018/08/23/cli-improved
(( $+commands[bat] )) && alias cat="bat"
(( $+commands[fzf] )) && alias preview="fzf --preview 'bat --color \"always\" {}'"

# [my] executables
[[ -d "$HOME/bin" ]] && path+="$HOME/bin"

# [my] private configuration
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local" || true

# vim: set foldlevel=0 foldmethod=marker:
