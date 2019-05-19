
build:
	ninja -C builddir/

install: build
	sudo ninja -C builddir/ install
	sudo udevadm hwdb --update
