#!/usr/bin/env bash

# sd - utility to cd to a directory using words in the middle as well.
#      it is most useful in conjunction with directories created by `mkdate`
#      e.g. $ ls
#             220310-company-projectpatternname 220308-company-othername
#           $ sd pattern<TAB>
#               =>
#           $ sd 220310-company-projectpatternname/
sd ()
{
	cd $@
}

# TODO: Fix bug when two dirs have a common start.
#       e.g. 220311-opengl-caca 220311-test-opengl
#            will turn prompt into "$ sd 220311-"
_sd_completions ()
{
	if [[ "${#COMP_WORDS[@]}" != 2 ]]; then
		return
	fi

	compopt -o dirnames
	compopt -o nospace

	local prev="." cur suggestions

	[[ "${COMP_WORDS[1]}" == *"/"* ]] && prev="${COMP_WORDS[1]%/*}"
	cur="${COMP_WORDS[1]##*/}"

	local suggestions=($(compgen -W "$(find "${prev}/" -mindepth 1 -maxdepth 1 -type d -name "*${cur}*" -printf "%f/\n" 2>/dev/null)"))

	if [[ "${#suggestions[@]}" == 1 && "${prev}" != "." ]]; then
		suggestions[0]="${prev}/${suggestions[0]}"
	fi

	COMPREPLY=("${suggestions[@]}")
	#echo "${COMPREPLY[0]}"
}

complete -F _sd_completions sd
# sd - end of implementation.

