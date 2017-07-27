#!/bin/bash

function showhelp() {
	echo "Usage: $0 [setup|start|help]"
}

function setup() {
	mkdir -p tempenv/{chroot,persist,files,dev/pts}

	mknod -m 622 tempenv/dev/console c 5 1
	mknod -m 666 tempenv/dev/null c 1 3
	mknod -m 666 tempenv/dev/zero c 1 5
	mknod -m 666 tempenv/dev/ptmx c 5 2
	mknod -m 666 tempenv/dev/tty c 5 0
	mknod -m 444 tempenv/dev/random c 1 8
	mknod -m 444 tempenv/dev/urandom c 1 9
	chown root:tty tempenv/dev/{console,ptmx,tty}
}

function verifysetup() {
	for i in tempenv/{chroot,persist,files,dev/pts}; do
		if [[ ! -d $i ]]; then
			return 1
		fi
	done

	return 0
}

function start() {
	if ! verifysetup; then
		echo "Environment wasn't set up."
		return 1
	fi

	unionfs-fuse -o cow,allow_other tempenv/files=RW:tempenv/persist:/ tempenv/chroot
	mount --bind tempenv/dev tempenv/chroot/dev
	mount --bind /dev/pts tempenv/chroot/dev/pts

	set +e
	chroot tempenv/chroot
	umount tempenv/chroot/{dev/pts,dev} tempenv/chroot
	set -e
}

set -e

if [[ -z $1 ]] || [[ $1 == "help" ]]; then
	showhelp
	exit 0
fi

cd "$(dirname "$0")"

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root"
	exit 1
fi

case "$1" in
	"start")
		start
		;;
	"setup")
		setup
		;;
	*)
		echo "Unknown command: $1"
		;;
esac
