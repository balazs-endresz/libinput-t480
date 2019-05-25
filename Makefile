
build:
	sudo ninja -C builddir/

install: build
	sudo ninja -C builddir/ install
	sudo udevadm hwdb --update

logout:
	gnome-session-quit

logs:
	sudo libinput debug-events --verbose
