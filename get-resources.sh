#!/usr/bin/env bash
#
# Usage:
# 	get-resources <URLs.txt> [target_dir]

set -e

get-assets() {
	wget --continue --content-disposition \
		--input-file "$1" --directory-prefix "$2"
}

error() {
	echo "$@" >&2
	exit 1
}

main() {
	local target_dir
	target_dir="."

	if [ $# -lt 1 ]; then
		error "Too few arguments!"
	fi

	if [ $# -gt 2 ]; then
		error "Too many arguments!"
	fi

	if [ $# -eq 2 ]; then
		target_dir="$2"
	fi

	if [ ! -f "$1" ]; then
		error "URLs file $1 not found!"
	fi

	if [ ! -d "${target_dir}" ]; then
		error "Target directory ${target_dir} not found"
	fi

	get-assets "$1" "${target_dir}"
}

main "$@"
