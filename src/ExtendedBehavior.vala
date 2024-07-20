/*
 * Copyright 2024 elementary, Inc. <https://elementary.io>
 * Copyright 2024 Corentin Noël <tintou@noel.tf>
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

/**
 * This interface is used for certain special behavior of surfaces on a pantheon wayland
 * session.
 */
public interface PantheonWayland.ExtendedBehavior : Gtk.Widget, Gtk.Native {
    private void registry_handle_global (Wl.Registry wl_registry, uint32 name, string @interface, uint32 version) {
        if (@interface == "io_elementary_pantheon_shell_v1") {
            var desktop_shell = wl_registry.bind<PantheonDesktop.Shell> (name, ref PantheonDesktop.Shell.iface, uint32.min (version, 1));
            unowned var surface = get_surface ();
            if (surface is Gdk.Wayland.Surface) {
                unowned var wl_surface = ((Gdk.Wayland.Surface) surface).get_wl_surface ();
                set_data ("-pantheon-wayland-extended-behavior", desktop_shell.get_extended_behavior (wl_surface));
            }
        }
    }

    private static Wl.RegistryListener registry_listener;
    /**
     * Connects to the pantheon wayland shell protocol and does the required setup.
     * This has to be called before any of the other methods.
     */
    public void connect_to_shell () {
        registry_listener.global = registry_handle_global;
        unowned var display = get_display ();
        if (display is Gdk.Wayland.Display) {
            unowned var wl_display = ((Gdk.Wayland.Display) display).get_wl_display ();
            var wl_registry = wl_display.get_registry ();
            wl_registry.add_listener (
                registry_listener,
                this
            );

            if (wl_display.roundtrip () < 0) {
                return;
            }
        }
    }

    /**
     * Tells the wm to keep the surface above other surfaces.
     * Should only be called after {@link connect_to_shell}.
     */
    public void set_keep_above () {
        unowned PantheonDesktop.ExtendedBehavior? extended_behavior = get_data ("-pantheon-wayland-extended-behavior");
        if (extended_behavior != null) {
            extended_behavior.set_keep_above ();
        }
    }

    /**
     * Tells the wm to keep this surface centered. It will also stay centered if it resizes.
     * Note though that it can still be moved with Super + Mouse drag, or by the surface itself,
     * e.g. via a WindowHandle
     * Should only be called after {@link connect_to_shell}.
     */
    public void make_centered () {
        unowned PantheonDesktop.ExtendedBehavior? extended_behavior = get_data ("-pantheon-wayland-extended-behavior");
        if (extended_behavior != null) {
            extended_behavior.make_centered ();
        }
    }

    /**
     * Tells the wm to give this surface keyboard focus.
     * Should only be called after {@link connect_to_shell}.
     */
    public void focus () {
        unowned PantheonDesktop.ExtendedBehavior? extended_behavior = get_data ("-pantheon-wayland-extended-behavior");
        if (extended_behavior != null) {
            extended_behavior.focus ();
        }
    }
}
