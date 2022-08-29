#!/usr/bin/env sh

# mkdate - utility to mkdir with current date in front.
#          e.g. 220310-some-project
mkdate ()
{
	for i do
	  set -- "$@" "$(date +%y%m%d)-${i}"
	  shift
	done
	mkdir "$@"
}

