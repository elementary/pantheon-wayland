/*
 * Copyright 2024 elementary, Inc. <https://elementary.io>
 * Copyright 2024 Corentin Noël <tintou@noel.tf>
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

/**
 * This interface is used by objects that need to be serialized in a Settings.
 * The object must have a string representation and provide these methods to
 * translate between the string and object representations.
 */
public interface PantheonWayland.ExtendedBehavior : Gtk.Widget, Gtk.Native {
    private void registry_handle_global (Wl.Registry wl_registry, uint32 name, string @interface, uint32 version) {
        if (@interface == "io_elementary_pantheon_shell_v1") {
            var desktop_shell = wl_registry.bind<PantheonDesktop.Shell> (name, ref PantheonDesktop.Shell.iface, uint32.min (version, 1));
            unowned var surface = get_surface ();
            if (surface is Gdk.Wayland.Surface) {
                unowned var wl_surface = ((Gdk.Wayland.Surface) surface).get_wl_surface ();
                set_data ("-granite-extended-behavior", desktop_shell.get_extended_behavior (wl_surface));
            }
        }
    }

    private static Wl.RegistryListener registry_listener;
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
     * Serializes the object into a string representation.
     *
     * @return the string representation of the object
     */
    public void set_keep_above () {
        unowned PantheonDesktop.ExtendedBehavior? extended_behavior = get_data ("-granite-extended-behavior");
        if (extended_behavior != null)
            extended_behavior.set_keep_above ();
    }

    /**
     * Serializes the object into a string representation.
     *
     * @return the string representation of the object
     */
    public void make_centered () {
        unowned PantheonDesktop.ExtendedBehavior? extended_behavior = get_data ("-granite-extended-behavior");
        if (extended_behavior != null)
            extended_behavior.make_centered ();
    }

    /**
     * Serializes the object into a string representation.
     *
     * @return the string representation of the object
     */
    public void focus () {
        unowned PantheonDesktop.ExtendedBehavior? extended_behavior = get_data ("-granite-extended-behavior");
        if (extended_behavior != null)
            extended_behavior.focus ();
    }
}
