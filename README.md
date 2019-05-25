libinput with Thinkpad T480 specific settings
=============================================

At the moment libinput doesn't have many customisation options but the code is easy to follow, so I'm just configuring it in a custom build for myself. This means it is _very_ opinionated and some features I'm not using might not work too well.


WARNING:
--------

ANY MISTAKES IN THIS FORK CAN CAUSE YOUR OS TO CRASH AND REQUIRE REINSTALLING IT!


original git repo
-----------------
https://cgit.freedesktop.org/wayland/libinput/

initial setup
-------------

```
echo 255 | sudo tee /sys/class/input/event6/device/device/sensitivity

sudo apt install meson check ninja-build
# git clone ... && cd libinput
meson --prefix=/usr -Ddocumentation=false builddir/
```

build
-----

```
make install
# now log out and back in

# none of these reload the driver:
# sudo  modprobe -r psmouse && sudo modprobe psmouse
# xinput disable 12 && xinput enable 12
```

log events
----------

```
evdev_log_debug(tp->device, "t->point.x: %d\n", t->point.x);

# man libinput-debug-events
sudo libinput debug-events --enable-tap --set-scroll-method=edge --set-click-method=clickfinger --enable-dwt --disable-natural-scrolling --verbose
```

features
--------

* don't overshoot when selecting text
* make sure hysteresis is never enabled (although, this might not be an issue)
* edge scrolling tweaks:
  * start scrolling earlier
  * increase speed
  * use accelerared profile
* ignore all events in the top left corner, i.e. when finger is on the top left mouse button
* extend area for thumb detection at the bottom
* increase trackpoint speed
* increase trackpoint+middlebutton scroll speed


TODO
----

* try trackpoint scroll speed increase with this: https://bugs.freedesktop.org/attachment.cgi?id=139618
* disable touchpad buttons and palm detection at the bottom
* make trackpoint movement smoother
* make edge scroll work even with just half a finger on the touchpad
* don't lock into edge scrolling if direction is far from vertical
* increase `TP_MAGIC_SLOWDOWN` dynamically when not selecting text,
  i.e. probably when the touch move starts out much faster
* disable scroll over taskbar: https://bugs.launchpad.net/gnome-panel/+bug/39328
* disable scroll over chrome tab list
* ignore scroll as soon as ctrl is pressed: https://bugs.chromium.org/p/chromium/issues/detail?id=927992

___


original libinput readme:
=========================

libinput is a library that provides a full input stack for display servers
and other applications that need to handle input devices provided by the
kernel.

libinput provides device detection, event handling and abstraction to
minimize the amount of custom input code the user of libinput needs to
provide the common set of functionality that users expect. Input event
processing includes scaling touch coordinates, generating
relative pointer events from touchpads, pointer acceleration, etc.

User documentation
------------------

Documentation explaining features available in libinput is available
[here](https://wayland.freedesktop.org/libinput/doc/latest/features.html).

This includes the [FAQ](https://wayland.freedesktop.org/libinput/doc/latest/faqs.html)
and the instructions on
[reporting bugs](https://wayland.freedesktop.org/libinput/doc/latest/reporting-bugs.html).


Source code
-----------

The source code of libinput can be found at:
https://gitlab.freedesktop.org/libinput/libinput

For a list of current and past releases visit:
https://www.freedesktop.org/wiki/Software/libinput/

Build instructions:
https://wayland.freedesktop.org/libinput/doc/latest/building.html

Reporting Bugs
--------------

Bugs can be filed on freedesktop.org GitLab:
https://gitlab.freedesktop.org/libinput/libinput/issues/

Where possible, please provide the `libinput record` output
of the input device and/or the event sequence in question.

See https://wayland.freedesktop.org/libinput/doc/latest/reporting-bugs.html
for more info.

Documentation
-------------

- Developer API documentation: https://wayland.freedesktop.org/libinput/doc/latest/development.html
- High-level documentation about libinput's features:
  https://wayland.freedesktop.org/libinput/doc/latest/features.html
- Build instructions:
  https://wayland.freedesktop.org/libinput/doc/latest/building.html
- Documentation for previous versions of libinput: https://wayland.freedesktop.org/libinput/doc/

Examples of how to use libinput are the debugging tools in the libinput
repository. Developers are encouraged to look at those tools for a
real-world (yet simple) example on how to use libinput.

- A commandline debugging tool: https://gitlab.freedesktop.org/libinput/libinput/tree/master/tools/libinput-debug-events.c
- A GTK application that draws cursor/touch/tablet positions: https://gitlab.freedesktop.org/libinput/libinput/tree/master/tools/libinput-debug-gui.c

License
-------

libinput is licensed under the MIT license.

> Permission is hereby granted, free of charge, to any person obtaining a
> copy of this software and associated documentation files (the "Software"),
> to deal in the Software without restriction, including without limitation
> the rights to use, copy, modify, merge, publish, distribute, sublicense,
> and/or sell copies of the Software, and to permit persons to whom the
> Software is furnished to do so, subject to the following conditions: [...]

See the [COPYING](https://gitlab.freedesktop.org/libinput/libinput/tree/master/COPYING)
file for the full license information.

About
-----

Documentation generated by from git commit [__GIT_VERSION__](https://gitlab.freedesktop.org/libinput/libinput/commit/__GIT_VERSION__)
