## ISO Build Process for Ubuntu

Reference:
* https://discourse.lubuntu.me/t/how-is-the-lubuntu-system-created/4759/2
* https://phab.lubuntu.me/w/release-team/iso-building/
* https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html

### Tools and scripts

* [germinate](https://git.launchpad.net/germinate): Germinate is a package available in Debian and Ubuntu which starts with lists of packages (called seeds) and grows them into a full list of packages including dependencies and (in additional lists) suggests, recommends, and sources for each of these lists.

* [`ubuntu-cdimage`](https://code.launchpad.net/~ubuntu-cdimage/ubuntu-cdimage/mainline): is the tooling which triggers the entire process. It interacts with Launchpad, handles ISO publishing, etc. What ubuntu-cdimage specifically handles is the creation of the index pages for each published ISO, and triggering of each build. If you ever need someone with direct SSH access to tweak something, file a bug against the project https://bugs.launchpad.net/ubuntu-cdimage.

* [`livecd-rootfs`](https://git.launchpad.net/livecd-rootfs): is what handles the creation of the --squashfs--, and this is done on Launchpad itself. This --squashfs-- is not only the one that is used on the live CD, it is the initial image that is installed on the system prior to customization. Using `livecd-rootfs`, you can install files which are not in any package, and add customization scripts that are also not in any package.

* [`debian-cd`](https://code.launchpad.net/~ubuntu-cdimage/debian-cd/ubuntu): as forked by Ubuntu, is what handles wrapping up the --squashfs-- and adding metadata. It takes the produced --squashfs-- and wraps it up in an ISO file.

* [`Casper`](https://git.launchpad.net/ubuntu/+source/casper): it is a middle ground between customization done directly on the --squashfs-- and ISO-level customization done by `debian-cd`. It is a set of scripts ran immediately after the ISO is booted which affects the --squashfs-- only when viewed on the ISO and not on the installed system. This is where the live user is created, among other modifications.

#### Other tools

* [`live-build`](https://salsa.debian.org/live-team/live-build): A collection of scripts used to build customized live systems. See the [Debian Live Manual](https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html) for details.
* [Calamares Installer](https://calamares.io/): an end-user-friendly installer, a distribution-independent installer framework.

### Seeds and germinate

Reference:
* https://wiki.ubuntu.com/Germinate
* https://wiki.ubuntu.com/SeedManagement

There can be three reasons for creating a separate seed:
* either this seed will form a metapackage or ISO image in its afterlife,
* or it’s a set of packages inherited by several seeds that will form a metapackage or ISO image in their afterlife.
* The third reason is forming a task for tasksel

Ubuntu itself uses them for generating their ISO images and metapackages (empty packages that do nothing on their own, but depend on other packages).

A seed file is what determines what packages are included on the ISO. Eg. https://ubuntu-archive-team.ubuntu.com/seeds/lubuntu.noble/desktop

The seeds are read by a program called Germinate, which resolves the dependencies of packages in the seed lists. By adding additional packages to satisfy these dependencies, the final package lists are produced.

CD builds:
* The desktop CD contains the software in the ship-live seed (and its dependencies)
* The alternate CD contains the software in the ship seed (and its dependencies)
* The DVD contains the software in the dvd seed (and its dependencies)
* The live server CD contains the software in the server-ship-live seed (and its dependencies)

NOTE: all, all+extra, and provides are not real seeds, so ignore these.

Seeds are maintained in a Launchpad project (https://launchpad.net/ubuntu-seeds) whose git repositories are published here: https://code.launchpad.net/~ubuntu-core-dev/ubuntu-seeds/+git/

Seed files (and changes) can be examined on launchpad (eg. https://git.launchpad.net/~lubuntu-dev/ubuntu-seeds/+git/lubuntu_). It could be in another oficial repository like https://git.lubuntu.me/Lubuntu/seed but it’s Launchpad that Ubuntu uses for many of its tasks.

You can view the current seeds in http://people.canonical.com/~ubuntu-archive/seeds/, and the current output of germinate for them in http://people.canonical.com/~ubuntu-archive/germinate-output/.

Also you can look at germinate's output, which sometimes provides rationale and supporting information (although in a rather terse form). The output is in CD build logs: http://people.canonical.com/~ubuntu-archive/cd-build-logs/


### Metapackages

Metapackages are packages that don’t do anything themselves, but depend on other packages. They’re the only way to push package selection updates during both pre-release and post-release cycles. They also provide some additional niceties - for example, it’s a handy way to install the package selection of your distribution to another system, so you can transform an Ubuntu install into your distro with 1 line in terminal.

#### Required tools
```sh
sudo apt-get install debootstrap germinate bzr devscripts
```

#### The only files to update
The only files that you might ever need are:
```
COPYING
metapackage-map
README
update
update.cfg
debian/
```
Everything else is auto-generated, and any tweaks you do there will be erased on next update.

#### The location of seeds
Ubuntu has the metapackage `update` script configured to get the seeds from bazaar branches. The location of seeds is specified in `update.cfg` file.

#### The location of required packages
```
archive_base/default: http://archive.ubuntu.com/ubuntu/
```
This field in `update.cfg` holds the addresses of repositories that will be used for generating the metapackages. You should specify the repositories that contain all the packages you listed in seeds and their dependencies. The list of repositories is comma-separated.

#### Rebrand the metapackage before updating
In `metapackage-map file` and replace any occurrences of ubuntu, kubuntu, xubuntu etc with the name of your project. Then do the same in `debian/control`, and update descriptions in there accordingly.
You can also add and remove metapackages by tweaking those two files and the `seeds:` field in `update.cfg` if you wish.

#### Updating
Once you've specified the seeds to use for building metapackages. Run `update` script to apply changes.

#### Building the metapackage
Run `debuild` to build the binary packages, or `debuild -S` to build source package.


### Nusakan

The ISO images and the building of the final ISO is done on a machine called Nusakan. Canonical employees have direct SSH access to this machine (Nusakan) and can use it to manually trigger builds, as well as doing final publishing.

Nusakan outputs its ISO building logs to
https://people.canonical.com/~ubuntu-archive/cd-build-logs/
here you can also find links to the --livefs build-- within each respective build log.


### Launchpad

The only thing Launchpad is used for is the building of the --squashfs-- using `livecd-rootfs`. We very rarely trigger builds using Launchpad, but we do use it to view the logs of the --livefs build--.

Links like this always give you the latest output of the --livefs builds-- if you do not want to find the Nusakan logs first.
https://launchpad.net/~ubuntu-cdimage/+livefs/ubuntu/CODENAME/lubuntu/


### debian-cd fork

In tools/boot/CODENAME/boot-ARCH is where you can find the boot parameters and entries for the ISOs. Of note are two boot parameters; maybe-ubiquity and only-ubiquity. Ubiquity then intercepts this and can act accordingly, however, they are fairly useless for us until Calamares gains that functionality.

In data/CODENAME/ you can find the theming for the boot menu on BIOS systems for the live CD.





