
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
* `arc-theme`: theme mainly for GTK apps. It installs `gnome-themes-extra` and `gnome-themes-extra-data` too.
* `adwaita-icon-theme`: theme for GTK installed automatically as a dependency of `libgtk2.0-0`.
* `kde-style-breeze`: Breeze theme for Qt5 apps.
* `breeze-cursor-theme`: the cursor theme.
* `sddm` + `sddm-theme-lubuntu` + `lubuntu-default-settings`: QML-based display manager
* `xscreensaver` + `lubuntu-default-settings`: the standard screen saver and screen locker.
* `xdg-utils`: cli tools required by LXQt. LXQt use these tools to indirectly run commands with `xscreensaver`.
* `lubuntu-update-notifier`: the packages updates dialog that appears when log in.
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

The following environment variables customizes mainly some XDG-based apps like for example LXQt:
```
XDG_CONFIG_DIRS=/etc/xdg/xdg-Lubuntu:/etc/xdg:/etc:/usr/share
MANDATORY_PATH=/usr/share/gconf/Lubuntu.mandatory.path
DESKTOP_SESSION=Lubuntu
DEFAULTS_PATH=/usr/share/gconf/Lubuntu.default.path
XDG_DATA_DIRS=/usr/share/Lubuntu:/usr/local/share:/usr/share:/var/lib/snapd/desktop
```

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


## Some notes about de Desktop environment

**Walpapers**

The wallpapers are located in `/usr/share/lubuntu/wallpapers`

**The menu bar**

File locations:
* The menu layout is described in `/etc/xdg/menus/lxqt-applications.menu`. The package `lxqt-panel` provides it. It consume the .directory and .desktop entries listed below which contains names, descriptions, icon references and categories.
* NOTE the .desktop items in the menu and submenus are ordered by name automatically (the order in the .menu file is ignored).
* Directory items goes into `/usr/share/desktop-directories/*.directory` and provides the description of the menu and submenus. The package `lxmenu-data` provides the base menu and submenu entries.
* Desktop items goes into `/usr/share/applications/*.desktop` and provides the description of the menu and submenu items.

**The configuration center**

The configuration center is provided by the package `lxqt-config`.

The app with the same name reads `/etc/xdg/menus/lxqt-config.menu` to show the menu. It follows the same structure as the .menu file for the menu bar.

**The application runner**

The runner is `lxqt-runner` and it saves the execution history in the following location:
```
~/.cache/lxqt-runner.history
```

**Notifications**

Notifications are send via Dbus:
```sh

# Service (object path):
#   /org/freedesktop/Notifications
# Interface:
#   org.freedesktop.Notifications
# Method:
#   Notify
# Parameters:
#   app_name (string)
#   replaces_id (uint)
#   app_icon (string)
#   summary (string)
#   body (string)
#   actions (array)
#   hints (dict)
#   expire_timeout (int)
#
# Reference:
# https://specifications.freedesktop.org/notification-spec/1.2/protocol.html

gdbus call --session \
  --dest org.freedesktop.Notifications \
  --object-path /org/freedesktop/Notifications \
  --method org.freedesktop.Notifications.Notify \
    'testApp' \
    0 \
    'icon-name' \
    'a title' \
    'the message' \
    [] \
    "{}" \
    0

# Alternative:
#     dbus-send --session --type=method_call --print-reply \
#       --dest='org.freedesktop.Notifications' \
#       /org/freedesktop/Notifications \
#       org.freedesktop.Notifications.Notify \
#         string:'testApp' \
#         uint32:0 \
#         string:'icon-name' \
#         string:'a title' \
#         string:'the message' \
#         array:string:'' \
#         dict:string:string:'','' \
#         int32:0
```

These notifications are being shown by `lxqt-notificationd` and cached in the following location:
```
~/.cache/lxqt-notificationd/unattended.list
```


## Plymouth, graphical boot animation while the boot process happens in the background

It provides a flicker-free graphical boot process. It relies on kernel mode setting (KMS) to set the native resolution of the display as early as possible, then provides an eye-candy splash screen leading all the way up to the login manager.

Plymouth primarily uses KMS to display graphics, but on UEFI systems it can utilize the EFI framebuffer.

The post-installation script of `plymouth-theme-lubuntu-logo` package (`/usr/share/plymouth/themes/default.plymouth`) configures `/usr/share/plymouth/themes/default.plymouth` to point to `/usr/share/plymouth/themes/lubuntu-logo/lubuntu-logo.plymouth`.
```bash
update-alternatives --display default.plymouth
# output:
#     default.plymouth - auto mode
#       link best version is /usr/share/plymouth/themes/lubuntu-logo/lubuntu-logo.plymouth
#       link currently points to /usr/share/plymouth/themes/lubuntu-logo/lubuntu-logo.plymouth
#       link default.plymouth is /usr/share/plymouth/themes/default.plymouth
#     /usr/share/plymouth/themes/bgrt/bgrt.plymouth - priority 110
#     /usr/share/plymouth/themes/lubuntu-logo/lubuntu-logo.plymouth - priority 150
```

Reference:
* https://www.freedesktop.org/wiki/Software/Plymouth/
* https://wiki.archlinux.org/title/Plymouth


## SDDM, the display manager

Package: sddm

The background image is `/usr/share/sddm/themes/lubuntu/wall.png`.

The default avatar image is `/usr/share/sddm/faces/.face.icon`.

For custom user icons (aka. avatars) we have to place PNG images with the name like `username.face.icon` in `FacesDir` (which by default points to `/usr/share/sddm/faces`).

After the installation, it is automatically enabled when the post-installation script runs (`/var/lib/dpkg/info/sddm.postinst`):
```
/etc/systemd/system/display-manager.service -> /lib/systemd/system/sddm.service
```

NOTE: `lubuntu-default-settings` provides the following profile:
```
/usr/share/xsessions/Lubuntu.desktop
```

The last logged-in user and selected session are cached in `/var/lib/sddm/state.conf`:
```
sudo less /var/lib/sddm/state.conf
```

The default theme is `ubuntu-theme`. It was hardcoded with the following patch:
https://git.launchpad.net/~ubuntu-qt-code/+git/sddm/tree/debian/patches/02_use_debian_theme.diff?h=ubuntu/jammy


The post-installation script of the `sddm-theme-lubuntu` package (`/var/lib/dpkg/info/sddm-theme-lubuntu.postinst`) sets `/usr/share/sddm/themes/ubuntu-theme` to point to `/usr/share/sddm/themes/lubuntu`
```bash
update-alternatives --display sddm-ubuntu-theme
# output:
#   sddm-ubuntu-theme - auto mode
#     link best version is /usr/share/sddm/themes/lubuntu
#     link currently points to /usr/share/sddm/themes/lubuntu
#     link sddm-ubuntu-theme is /usr/share/sddm/themes/ubuntu-theme
#   /usr/share/sddm/themes/lubuntu - priority 50
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

If the panel accidentally disappears just remove `~/.config/lxqt/panel.conf` and login again after running `lxqt-leave --logout`.


## lubuntu-update-notifier, the packages updates dialog that appears when log in

The package `lubuntu-update-notifier` includes the following entry that internally runs `lubuntu-notifier.py` to show updates in a dialog box:
```
/etc/xdg/autostart/upg-notifier-autostart.desktop
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

