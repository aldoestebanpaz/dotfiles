
# Notes about Lubuntu 22.04

Seed: https://ubuntu-archive-team.ubuntu.com/seeds/lubuntu.jammy/desktop
Seed repository: https://git.lubuntu.me/Lubuntu/seed

Metapackage: lubuntu-desktop
Metapackage repository: https://git.lubuntu.me/Lubuntu/lubuntu-meta

LXQt repositories: https://github.com/lxqt
Lubuntu repositories: https://git.lubuntu.me/

## Upgrading guide

https://manual.lubuntu.me/stable/D/upgrading.html

## The UI components

* `plymouth` + `plymouth-theme-lubuntu-logo` + `plymouth-theme-lubuntu-text`: graphical boot animation while the booting
* `lubuntu-grub-theme`: theme for grub.
* `ubuntu-mono` + `lubuntu-artwork`: icon themes, wallpapers, LXQt themes, and openbox-3 themes.
* `oxygen-icon-theme`: Default icon theme consumed by LXQt.
* `papirus-icon-theme`: Alternative icon theme.
* `arc-theme`: theme mainly for GTK apps.
* `adwaita-icon-theme`: theme for GTK installed automatically as a dependency of `libgtk2.0-0`.
* `kde-style-breeze`: Breeze theme for Qt5 apps.
* `breeze-cursor-theme`: the cursor theme.
* `sddm` + `sddm-theme-lubuntu` + `lubuntu-default-settings`: QML-based display manager
* `xscreensaver` + `lubuntu-default-settings`: the standard screen saver and screen locker.
* `xdg-utils`: cli tools required by LXQt. LXQt use these tools to indirectly run commands with `xscreensaver`.
* `openbox` + `lubuntu-default-settings` + `lubuntu-artwork`: the windows manager.
* `lxqt-panel` + `lubuntu-default-settings`: the toolbar and menu.
* `pcmanfm-qt` + `lubuntu-default-settings`: the file manager.
* `qterminal` + `lubuntu-default-settings`: a Qt-based terminal.

## TODOs

Explain the purpose of the following items from `lubuntu-default-settings`:
```
/usr/share/glib-2.0/schemas/50_lubuntu.gschema.override
/usr/share/lubuntu/qt/Trolltech-qt-session.conf
/usr/share/lubuntu/qt/Trolltech.conf
```

## Recommended

* Install `qt5-style-kvantum` for more themes in Qt apps.

## Desktop customizations

`lubuntu-default-settings` adds the following to configure and automatically run the system try applet of NetworkManager:
```
/etc/xdg/xdg-Lubuntu/nm-tray/nm-tray.conf
/etc/xdg/xdg-Lubuntu/autostart/nm-applet.desktop
```

NOTE: `lubuntu-default-settings` provides the following customizations:
```
/etc/xdg/xdg-Lubuntu/lxqt/globalkeyshortcuts.conf
/etc/xdg/xdg-Lubuntu/lxqt/lxqt-config-appearance.conf
/etc/xdg/xdg-Lubuntu/lxqt/lxqt-runner.conf
/etc/xdg/xdg-Lubuntu/lxqt/lxqt.conf
/etc/xdg/xdg-Lubuntu/lxqt/notifications.conf
/etc/xdg/xdg-Lubuntu/lxqt/panel.conf
/etc/xdg/xdg-Lubuntu/lxqt/session.conf
/etc/xdg/xdg-Lubuntu/lxqt/windowmanagers.conf
/usr/share/Lubuntu/applications/lximage-qt-screenshot.desktop
```

## Plymouth, graphical boot animation while the boot process happens in the background

It provides a flicker-free graphical boot process. It relies on kernel mode setting (KMS) to set the native resolution of the display as early as possible, then provides an eye-candy splash screen leading all the way up to the login manager.

Plymouth primarily uses KMS to display graphics, but on UEFI systems it can utilize the EFI framebuffer.

Reference:
* https://www.freedesktop.org/wiki/Software/Plymouth/
* https://wiki.archlinux.org/title/Plymouth

## SDDM, the display manager

Package: sddm

To enable it the following symlink exists:
```
/etc/systemd/system/display-manager.service -> /lib/systemd/system/sddm.service
```

NOTE: `lubuntu-default-settings` provides the following profile:
```
/usr/share/xsessions/Lubuntu.desktop
```

Reference:
* https://wiki.archlinux.org/title/SDDM

## xscreensaver, the screen saver and screen locker

NOTE: `lubuntu-default-settings` provides the following customizations:
```
/usr/lib/X11/app-defaults/XScreenSaver
/usr/share/lubuntu/xscreensaver/xscreensaver
```

NOTE: the horrible icon of the lock screen is located here:
```
/usr/share/pixmaps/xscreensaver.xpm
```

Reference:
* https://wiki.archlinux.org/title/XScreenSaver

## lxqt-panel, the toolbar and menu


NOTE: the following configurations are merged to create the final result in the UI:
```
~/.config/lxqt/panel.conf
/etc/xdg/xdg-Lubuntu/lxqt/panel.conf
```

## openbox, the windows manager

NOTE: `lubuntu-default-settings` provides the following customizations:
```
/etc/xdg/xdg-Lubuntu/openbox/rc.xml
/usr/share/lubuntu/openbox/menu.xml
```

NOTE: `lubuntu-artwork` provides some themes for this app.

## pcmanfm-qt, the file manager

NOTE: `lubuntu-default-settings` provides the following customizations:
```
/etc/xdg/xdg-Lubuntu/libfm/libfm.conf
/etc/xdg/xdg-Lubuntu/pcmanfm-qt/lxqt/settings.conf
```

## qterminal, the UI for the terminal

NOTE: `lubuntu-default-settings` provides the following customizations:
```
/etc/xdg/xdg-Lubuntu/qterminal.org/qterminal.ini
```

