#!/usr/bin/sh

# Script initializes other scripts.
# sourceables.d contains scripts that should modify the current shell's environment.
# executables.d contains scripts that run in a separate shell.

# For more information about the distincion between sourceables and executables check out this link:
# https://superuser.com/questions/176783/what-is-the-difference-between-executing-a-bash-script-vs-sourcing-it

# Install the script by executing (not sourcing) init.sh manually the first time.
case "$0" in *bin/*sh) ANO_sourced=1;; esac
if [ -z "${ANO_sourced}" ]; then
    if [ -z $ANO_SCRIPTS_INSTALLED ]; then
        echo >> "${HOME}/.bashrc"
        echo "# Source custom initializer for all shell variables, functions and scripts." >> "${HOME}/.bashrc"
        echo "export ANO_SCRIPTS_INSTALLED=1" >> "${HOME}/.bashrc"
        echo ". $(realpath $0)" >> "${HOME}/.bashrc"
        echo "Successfully added ano initializer to .bashrc. Changes will be available in a new shell."
    else
        echo "ANO_SCRIPTS_INSTALLED=1 already found in .bashrc."
    fi
    return
fi

ANO_basedir="${HOME}/.config/ano"
export ANO_SOURCEABLES_DIR="${ANO_basedir}/sourceables.d"
export ANO_EXECUTABLES_DIR="${ANO_basedir}/executables.d"
export ANO_SH_LIBS_DIR="${ANO_basedir}/sourceables.d/shlibs"

# Created sourceables.d/ and executables.d/ folders if not found.
[ ! -d "${ANO_SOURCEABLES_DIR}" ] && mkdir "${ANO_SOURCEABLES_DIR}"
[ ! -d "${ANO_EXECUTABLES_DIR}" ] && mkdir "${ANO_EXECUTABLES_DIR}"

# Source all scripts in sourceables.d/. One directory depth is allowed for organization.
# Add patterns to the exclude list if you wish before "); do" in a similar way.
# 	suggestion: ! -name ".*" \ (exclude all hidden files).
for ANO_cur_file in $(find "${ANO_SOURCEABLES_DIR}" -mindepth 1 -maxdepth 2 -type f \
					! -name "*.bak" \
					! -name "*.old" \
					! -name "*.impl" \
					! -name "*_pimpl*" \
					! -name "lib*.sh" \
					); do
	. "${ANO_cur_file}"
done

# Include all scripts in executables.d/.
[ ! $ANO_SCRIPTS_INITIALIZED ] && PATH="${ANO_EXECUTABLES_DIR}:$PATH"

# If .bashrc is sourced once for login shells and once for interactive shells,
# then PATH would be modified twice. The variable should prevent that.
# NOTE: the same check as above must be made for all sourceables that also
# modify any environment variables such as PATH or LD_LIBRARY_PATH.
export ANO_SCRIPTS_INITIALIZED=1

unset ANO_cur_file
unset ANO_basedir
unset ANO_sourced

