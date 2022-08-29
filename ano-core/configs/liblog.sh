#!/usr/bin/env sh
# Logging functions.
# Should never be sourced into current shells.
# Designed to be sourced by other executable scripts starting a new shell.
# Credits to Alexandru N. Onea!

[ -n "${_ano_log_sh_loaded}" ] && return 0
readonly _ano_log_sh_loaded=1

logger_name="liblog"
logger_quiet=0

log_info ()
{
	[ "${logger_quiet}" -eq 0 ] && echo "info: ${logger_name}: $@"
	return 0
}

log_warn ()
{
	[ "${logger_quiet}" -eq 0 ] && echo 1>&2 "warning: ${logger_name}: $@"
	return 0
}

log_err ()
{
	[ "${logger_quiet}" -eq 0 ] && echo 1>&2 "error: ${logger_name}: $@"
	return 0
}

log_set_quiet ()
{
	[ $# -eq 0 ] && logger_quiet=1 || logger_quiet="$1"
	return 0
}

log_set_name ()
{
	logger_name="$1"
	return 0
}

