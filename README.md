# Pantheon Wayland
Pantheon Wayland is an utility library made for exclusively for the Pantheon
Desktop utilities.

## Building and Installation

You'll need the following dependencies:
* meson >= 0.57.0
* gobject-introspection
* libgirepository1.0-dev
* libgtk-4-dev >= 4.4.0
* valac

Run `meson build` to configure the build environment:

    meson build --prefix=/usr

This command creates a `build` directory. For all following commands, change to
the build directory before running them.

To build it, use `ninja`:

    ninja

To install, use `ninja install`

    ninja install
