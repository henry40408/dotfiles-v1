#!/usr/bin/env bash

main() {
    local tpm_path="$HOME/.tmux/plugins"
    pushd $tpm_path > /dev/null
    for p in */*.tmux; do
        echo $p
        source $p >/dev/null 2>&1
    done
    popd
}
main
