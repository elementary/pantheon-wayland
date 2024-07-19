project('pantheon-wayland', ['c', 'vala'], version: '1.0.0')

pkgconfig = import('pkgconfig')
gnome = import('gnome')

pkg_config_name = 'pantheon-wayland-1'

include_dir = join_paths(
    get_option('prefix'),
    get_option('includedir'),
    pkg_config_name
)

glib_min_version = '2.50'

wayland_client_dep = dependency('wayland-client')

libpantheon_wayland_deps = [
    dependency('gio-2.0', version: '>=' + glib_min_version),
    dependency('glib-2.0', version: '>=' + glib_min_version),
    dependency('gobject-2.0', version: '>=' + glib_min_version),
    dependency('gtk4', version: '>=4.4'),
]

libpantheon_wayland_private_deps = [
    wayland_client_dep,
    dependency('gtk4-wayland', version: '>=4.4'),
]

subdir('protocol')
subdir('src')
