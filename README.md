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


TODO
----

* disable touchpad buttons and palm detection at the bottom
* trackpoint: increase acceleration in trackpoint_accelerator_set_speed instead of in trackpoint_accel_profile
* speed up trackpoint+middlebutton scrolling
* make edge scroll work even with just half a finger on the touchpad
* don't lock into edge scrolling if direction is far from vertical
* increase `TP_MAGIC_SLOWDOWN` dynamically when not selecting text,
  i.e. probably when the touch move starts out much faster

___


original libinput readme:
=========================

libinput is a library that handles input devices for display servers and other
applications that need to directly deal with input devices.

It provides device detection, device handling, input device event processing
and abstraction so minimize the amount of custom input code the user of
libinput need to provide the common set of functionality that users expect.
Input event processing includes scaling touch coordinates, generating
pointer events from touchpads, pointer acceleration, etc.

libinput originates from
[weston](http://cgit.freedesktop.org/wayland/weston/), the Wayland reference
compositor.

Architecture
------------

libinput is not used directly by applications, rather it is used by the
xf86-input-libinput X.Org driver or wayland compositors. The typical
software stack for a system running Wayland is:

@dotfile libinput-stack-wayland.gv

Where the Wayland compositor may be Weston, mutter, KWin, etc. Note that
Wayland encourages the use of toolkits, so the Wayland client (your
application) does not usually talk directly to the compositor but rather
employs a toolkit (e.g. GTK) to do so.

The simplified software stack for a system running X.Org is:

@dotfile libinput-stack-xorg.gv

Again, on a modern system the application does not usually talk directly to
the X server using Xlib but rather employs a toolkit to do so.

Source code
-----------

The source code of libinput can be found at:
http://cgit.freedesktop.org/wayland/libinput

For a list of current and past releases visit:
http://www.freedesktop.org/wiki/Software/libinput/

Build instructions:
http://wayland.freedesktop.org/libinput/doc/latest/building_libinput.html

Reporting Bugs
--------------

Bugs can be filed in the libinput component of Wayland:
https://bugs.freedesktop.org/enter_bug.cgi?product=Wayland&component=libinput

Where possible, please provide the `libinput record` output
of the input device and/or the event sequence in question.

See @ref reporting_bugs for more info.

Documentation
-------------

- Developer API documentation: http://wayland.freedesktop.org/libinput/doc/latest/modules.html
- High-level documentation about libinput's features:
http://wayland.freedesktop.org/libinput/doc/latest/pages.html
- Build instructions:
http://wayland.freedesktop.org/libinput/doc/latest/building_libinput.html
- Documentation for previous versions of libinput: https://wayland.freedesktop.org/libinput/doc/

Examples of how to use libinput are the debugging tools in the libinput
repository. Developers are encouraged to look at those tools for a
real-world (yet simple) example on how to use libinput.

- A commandline debugging tool: https://cgit.freedesktop.org/wayland/libinput/tree/tools/libinput-debug-events.c
- A GTK application that draws cursor/touch/tablet positions: https://cgit.freedesktop.org/wayland/libinput/tree/tools/libinput-debug-gui.c

License
-------

libinput is licensed under the MIT license.

> Permission is hereby granted, free of charge, to any person obtaining a
> copy of this software and associated documentation files (the "Software"),
> to deal in the Software without restriction, including without limitation
> the rights to use, copy, modify, merge, publish, distribute, sublicense,
> and/or sell copies of the Software, and to permit persons to whom the
> Software is furnished to do so, subject to the following conditions: [...]

See the [COPYING](http://cgit.freedesktop.org/wayland/libinput/tree/COPYING)
file for the full license information.
