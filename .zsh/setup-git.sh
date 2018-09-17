#!/bin/bash

/usr/bin/env git --git-dir=${HOME}/.cfg --work-tree=${HOME} \
    config --local status.showUntrackedFiles no

/usr/bin/env git config --global pager.diff "diff-so-fancy | less --tabs=1,5 -RFX"
/usr/bin/env git config --global pager.show "diff-so-fancy | less --tabs=1,5 -RFX"
