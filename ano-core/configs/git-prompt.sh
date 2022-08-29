#!/usr/bin/env bash

. "${ANO_SH_LIBS_DIR}/libgit-prompt.sh"

check_last_cmd_success()
{
	if [ $? -eq 0 ]
	then
		echo -e '\033[0;32m'
	else
		echo -e '\033[0;91m'
	fi
}

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1

export PS1='${debian_chroot:+($debian_chroot)}\[\033[00m\][\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0;96m\]$(__git_ps1 "(%s)")\[\033[00m\]]\n\[$(check_last_cmd_success)\]\$\[\033[00m\] '
