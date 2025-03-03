# dotfiles

## Installation

### Clone the repo

```sh
cd ~
git clone git@github.com:aldoestebanpaz/dotfiles.git
```

### Configure bash

```sh
if [ -f ~/.bashrc ]; then mv ~/.bashrc ~/.bashrc_bak; fi
cp ~/dotfiles/.bashrc ~/.bashrc
. ~/.bashrc
```

### Restore the .ssh/ files

Copy the .ssh/ files:

```sh
cp -R <src-location>/.ssh ~
```

Change the permissions and add the keys:

```sh
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/id_!(*.pub)
chmod 600 ~/.ssh/id_*.pub ~/.ssh/config ~/.ssh/known_hosts
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_!(*.pub)
```

### Restore the .gnupg/ files

Copy the .gnupg/ files:

```sh
cp -R <src-location>/.gnupg ~
```

Change the permissions and check it:

```sh
chmod 700 ~/.gnupg/
chmod 600 ~/.gnupg/*

gpg --list-keys --keyid-format short
```

### Check the OS and version to proceed

```sh
./distro-checker.sh
```
