set fish_greeting
set secret_environment "$HOME/.secrets/environment.gpg"

function benchmark
    for i in (seq 1 10)
        time $SHELL -i -c exit
    end
end

function check
    set binaries \
        direnv \
        xsv \
        lsd \
        tokei \
        zoxide \
        dust \
        procs \
        puma-dev
    for binary in $binaries
        if type -q $binary
            echo "[OK] "(file (which $binary))
        else
            echo "[error] $binary not found"
        end
    end
end

function decrypt
    if test -z $RECEPIENT
        echo "\$RECEPIENT is required"
        return 1
    end

    gpg -q --decrypt $secret_environment | source
end

function encrypt
    if test -z $RECEPIENT
        echo "\$RECEPIENT is required"
        return 1
    end

    gpg --batch --yes --output $secret_environment --encrypt --recipient $RECEPIENT $argv[1]
    echo "remember to delete $argv[1]"
end

function _install_asdf
    echo "==> install asdf"
    if ! test -d "$HOME/.asdf"
        git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.0
    end
    echo "==> asdf installed"
end

function install_crates
    if ! type -q cargo
        return 1
    end

    set crates \
        du-dust:0.6.2 \
        lsd:0.20.1 \
        procs:0.11.10 \
        tokei:12.1.2 \
        xsv:0.13.0 \
        starship:1.0.0 \
        zoxide:0.7.9
    for line in $crates
        set tuple (string split : $line)
        cargo install $tuple[1] --version $tuple[2]
    end
end

function _install_tpm
    echo "==> install tpm"
    if ! test -d "$HOME/.tmux/plugins/tpm"
        git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm --branch v3.0.0
    end
    echo "==> tpm installed"
end

function _install_vim_plug
    echo "==> install vim-plug"
    set xdg_data_home $XDG_DATA_HOME $HOME/.local/share
    if ! test -f "$xdg_data_home[1]/nvim/site/autoload/plug.vim"
        curl -fLo "$xdg_data_home[1]/nvim/site/autoload/plug.vim" \
            --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    end
    echo "==> vim-plug installed"
end

function _safe_alias
    if type -q $argv[2]
        alias $argv[1]=$argv[3]
    end
end

function reload
    exec $SHELL
end

function restore
    if ! type -q stow
        echo "stow not found"
        return 1
    end

    pushd $HOME/.cfg
    stow (ls -d */)
    popd
end

function setup
    _install_asdf
    _install_tpm
    _install_vim_plug
end

function _start_gpg_agent
    # ref: https://www.foxk.it/blog/gpg-ssh-agent-fish/
    if type -q gpgconf
        set -e SSH_AUTH_SOCK
        set -U -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

        set -x GPG_TTY (tty)

        gpgconf --launch gpg-agent
    end
end

function _init
    _safe_alias ls lsd lsd
    _safe_alias find lsd fd
    _safe_alias preview fzf "fzf --preview 'bat --color \"always\" {}'"
    _safe_alias cat bat bat
    _safe_alias ps procs procs

    if test -f "$HOME/.asdf/asdf.fish"
        source "$HOME/.asdf/asdf.fish"
    end

    if type -q direnv
        direnv hook fish | source
    end

    if type -q zoxide
        zoxide init fish | source
    end

    if type -q starship
        starship init fish | source
    end

    _start_gpg_agent
end

_init
