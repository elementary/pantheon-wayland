
pantheon_wayland_gi_name = 'PantheonWayland'
pantheon_wayland_gi_version = '1'

pantheon_wayland_gi = pantheon_wayland_gi_name + '-' + pantheon_wayland_gi_version
pantheon_wayland_gir = pantheon_wayland_gi + '.gir'
pantheon_wayland_typelib = pantheon_wayland_gi + '.typelib'

libpantheon_wayland = library(
    'pantheon-wayland',

    'ExtendedBehavior.vala',

    dependencies: [
        libpantheon_wayland_deps,
        libpantheon_wayland_private_deps,
        pantheon_desktop_shell_dep,
    ],

    vala_header: 'pantheon-wayland.h',
    vala_vapi: pkg_config_name + '.vapi',
    vala_gir: pantheon_wayland_gir,

    version: meson.project_version(),
    install: true,
    install_dir: [true, include_dir, true, true],
)

install_data(
    pkg_config_name + '.deps',
    install_dir: join_paths(get_option('datadir'), 'vala', 'vapi')
)


g_ir_compiler = find_program('g-ir-compiler')
custom_target(
    pantheon_wayland_typelib,
    command: [
        g_ir_compiler,
        '--shared-library',
        '@PLAINNAME@',
        '--output',
        '@OUTPUT@',
        join_paths(meson.current_build_dir(), pantheon_wayland_gir),
    ],
    input: libpantheon_wayland,
    output: pantheon_wayland_typelib,
    depends: libpantheon_wayland,
    install: true,
    install_dir: join_paths(get_option('libdir'), 'girepository-1.0'),
)

libpantheon_wayland_dep = declare_dependency(
    link_with: libpantheon_wayland,
    dependencies: libpantheon_wayland_deps,
    include_directories: [include_directories('.')],
)

# generate pkgconfig file
pantheon_wayland_pc = pkgconfig.generate(
    libpantheon_wayland,
    name: pkg_config_name,
    requires: libpantheon_wayland_deps,
    requires_private: libpantheon_wayland_private_deps,
    subdirs: [ pkg_config_name ],
    description: 'Pantheon desktop wayland protocol helper',
    version: meson.project_version(),
    url: 'https://github.com/elementary/pantheon-wayland',
)
