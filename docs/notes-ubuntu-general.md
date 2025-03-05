
# Notes for Ubuntu-based distributions

## Package post-installation script (*.postinst)

A post-installation script contains commands that should be executed after installation is complete.

These scripts are located in `/var/lib/dpkg/info`. These scripts have a .postinst extension.

```bash
find /var/lib/dpkg/info -type f -iname '*.postinst'
```

## Package configuration (debconf)

TODO
```bash
debconf-show <packagename>s

echo "sddm shared/default-x-display-manager select sddm" | debconf-set-selections
# or
debconf-set-selections <<< 'sddm shared/default-x-display-manager select sddm'
# or
set shared/default-x-display-manager sddm | debconf-communicate ;
```

## Debian alternatives system (update-alternatives)

TODO