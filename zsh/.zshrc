#!/usr/bin/env zsh

if [[ -z $HOME ]]; then
    echo "\$HOME is not set. abort."
    exit 1
fi

DOTFILES="$HOME/.local/share/dotfiles"

benchmark() {
    if (( $+commands[hyperfine] )); then
        /usr/bin/env hyperfine '/usr/bin/env zsh -i -c exit'
    else
        for i in $(seq 1 10); do time /usr/bin/env zsh -i -c "exit"; done
    fi
}

check() {
    local binaries
    binaries=(
        direnv
        xsv
        lsd
        tokei
        zoxide
        dust
        procs
        puma-dev
    )

    for binary in $binaries; do
        if (( $+commands[$binary] )); then
            file "$(which $binary)"
        else
            echo "[x] $binary not found"
        fi
    done
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

_install_asdf() {
    echo "==> install asdf"
    [[ ! -d "$HOME/.asdf" ]] && git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.9.0
    echo "==> asdf installed"
}

_install_crates() {
    local crates

    crates=(
        du-dust:0.6.2
        lsd:0.20.1
        procs:0.11.10
        tokei:12.1.2
        xsv:0.13.0
        zoxide:0.7.9
    )

    if (( $+commands[cargo] )); then
        local name
        local version

        for line in $crates; do
            name="$(echo $line | awk -F: '{print $1}')"
            version="$(echo $line | awk -F: '{print $2}')"
            cargo install $name --version $version
        done
    fi
}

_install_plugins() {
    local plugins

    plugins=(
        ohmyzsh/ohmyzsh
        romkatv/zsh-defer
        zsh-users/zsh-autosuggestions
        zsh-users/zsh-completions
        zsh-users/zsh-syntax-highlighting
        MichaelAquilina/zsh-auto-notify
        MichaelAquilina/zsh-you-should-use
        chuwy/zsh-secrets
        hlissner/zsh-autopair
        jreese/zsh-titles
        Aloxaf/fzf-tab
        romkatv/powerlevel10k
    )

    mkdir -p $DOTFILES

    pushd $DOTFILES > /dev/null

    local basename
    for plugin in $plugins; do
        basename="$(echo $plugin | awk -F/ '{print $2}')"
        [[ ! -d "$DOTFILES/$basename" ]] && git clone --depth 1 "https://github.com/$plugin.git" $DOTFILES/$basename
    done

    popd > /dev/null
}

_install_tpm() {
    echo "==> install tpm"
    [[ ! -d "$HOME/.tmux/plugins/tpm" ]] && git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm --branch v3.0.0
    echo "==> tpm installed"
}

_install_vim_plug() {
    echo "==> install vim-plug"
    if [[ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]]; then
        curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" \
            --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
    echo "==> vim-plug installed"
}

setup() {
    _install_asdf
    _install_vim_plug
    _install_tpm
    _install_plugins
    _install_crates
}

update-plugins() {
    pushd $DOTFILES > /dev/null
    for d in */; do
        echo "update $d"
        pushd $d > /dev/null
        git pull
        popd > /dev/null
    done
    popd > /dev/null
}

_fix_asdf() {
    # ref: https://github.com/asdf-vm/asdf/issues/692
    autoload -U +X bashcompinit && bashcompinit
}

_p10k_instant_prompt() {
    # [powerlevel10k] enable instant prompt
    # ref: https://github.com/romkatv/powerlevel10k#instant-prompt
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
}

_init_oh_my_zsh() {
    _source_plugin "ohmyzsh/oh-my-zsh.sh" # set ZSH_CACHE_DIR
}

_load_oh_my_zsh_libraries() {
    local libraries=(
        functions
        clipboard
        compfix
        completion
        correction
        directories
        git
        history
        key-bindings
        misc
        prompt_info_functions
        termsupport
    )
    for library in $libraries; do
        _source_plugin "ohmyzsh/lib/$library.zsh"
    done

    export DISABLE_LS_COLORS=true
    _source_plugin "ohmyzsh/lib/theme-and-appearance.zsh"
}

_load_oh_my_zsh_plugins() {
    local plugins=(
        asdf
        command-not-found
        common-aliases
        direnv
        docker-compose
        fzf
        gem
        git
        golang
        gitignore
        gpg-agent
        helm
        kubectl
        python
        ruby
        # rails
        virtualenvwrapper
    )
    for plugin in $plugins; do
        _source_plugin "ohmyzsh/plugins/$plugin/$plugin.plugin.zsh"
    done

    [[ $OSTYPE = *darwin* ]] && _source_plugin "ohmyzsh/plugins/brew/brew.plugin.zsh"

    export PIP_REQUIRE_VIRTUALENV=1
    _source_plugin "ohmyzsh/plugins/pip/pip.plugin.zsh"
}

_load_theme() {
    [[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"
    _source_plugin "powerlevel10k/powerlevel10k.zsh-theme"
}

_load_zsh_plugins() {
    _source_plugin "zsh-autosuggestions/zsh-autosuggestions.zsh"
    _source_plugin "zsh-completions/zsh-completions.plugin.zsh"
    _source_plugin "zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

    if [[ $OSTYPE = *darwin* ]] || (( $+commands[notify-send] )); then
        _source_plugin "zsh-auto-notify/auto-notify.plugin.zsh"
    fi

    export YSU_HARDCORE=1
    _source_plugin "zsh-you-should-use/you-should-use.plugin.zsh"

    _source_plugin "zsh-autopair/zsh-autopair.plugin.zsh"
    _source_plugin "zsh-secrets/zsh-secrets.plugin.zsh"
    _source_plugin "fzf-tab/fzf-tab.plugin.zsh"
    _source_plugin "zsh-titles/titles.plugin.zsh"
}

_source_plugin() {
    source "$DOTFILES/$1"
}

_init() {
    if [[ -d "$DOTFILES" ]]; then
        _p10k_instant_prompt
        _fix_asdf
        _init_oh_my_zsh
        _load_oh_my_zsh_libraries
        _load_oh_my_zsh_plugins
        _load_zsh_plugins
        _load_theme
    fi

    # [zsh] configuration for history
    setopt histfindnodups histignorealldups histignorespace histsavenodups

    # [[aliases]] https://remysharp.com/2018/08/23/cli-improved
    (( $+commands[bat] )) && alias cat="bat"
    (( $+commands[fd] )) && alias find="fd"
    (( $+commands[fzf] )) && alias preview="fzf --preview 'bat --color \"always\" {}'"
    (( $+commands[lsd] )) && alias ls="lsd"
    (( $+commands[procs] )) && alias ps="procs"
    (( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

    # [my] executables
    [[ -d "$HOME/bin" ]] && path+="$HOME/bin"

    # [my] private configuration
    [[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

    true # prevent result of shorthand expression from being exit status
}

_init

# vim: set foldlevel=0 foldmethod=marker:
